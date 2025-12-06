unit Meters;

{ Visual Lazarus components

  MIT license

  Created by Michal Jahelka at vsb.cz

  TAnalogMeter - Analog meter, linear, can be used as Voltmeter
                 Position, Maximum and Minimum are real numbers
                 3 colors, angle, auto position }

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, LResources;

type
  TAnalogMeter = class(TCustomControl)
  private
    { Private declarations }
    fBevelWidth:integer;
    fTicks:Integer;
    fBackground,fColor1,fColor2,fColor3,fNeedleColor:TColor;
    fBigTicksDiv,fTickHeight,fBigTickHeight:integer;
    fNeedleWidth,fAngle,fNumDistance:integer;
    fMin,fMax,fPosition:real;
    fPrecision,fDigits:integer;
    fPercent1,fPercent2:integer;
    Polomer,Posun:integer;
    AMeter:TRect;
    procedure SetBackground(NewValue:TColor);
    procedure SetBevelWidth(NewValue:integer);
    procedure SetNumDistance(NewValue:integer);
    procedure SetTicks(NewValue:integer);
    procedure SetColor1(NewValue:TColor);
    procedure SetColor2(NewValue:TColor);
    procedure SetColor3(NewValue:TColor);
    procedure SetBigTicksDiv(NewValue:integer);
    procedure SetTickHeight(NewValue:integer);
    procedure SetBigTickHeight(NewValue:integer);
    procedure SetNeedleColor(NewValue:TColor);
    procedure SetNeedleWidth(NewValue:integer);
    procedure SetAngle(NewValue:integer);
    procedure SetMin(NewValue:real);
    procedure SetMax(NewValue:real);
    procedure SetPosition(NewValue:real);
    procedure SetPrecision(NewValue:integer);
    procedure SetDigits(NewValue:integer);
    procedure SetPercent1(NewValue:integer);
    procedure SetPercent2(NewValue:integer);
  protected
    { Protected declarations }
    procedure PaintInterior(All:boolean);
    procedure RemoveNeedle;
    procedure Paint; override;
    procedure Resize; override;
  public
    { Public declarations }
    OuterBevel,InnerBevel:TBevel;
    constructor create(AOwner: TComponent); override;
    destructor destroy; override;
  published
    { Published declarations }
    property Background:TColor read fBackground write SetBackground;
    property BevelWidth:integer read fBevelWidth write SetBevelWidth;
    property NumDistance:integer read fNumDistance write SetNumDistance;
    property Ticks:integer read fTicks write SetTicks;
    property Color1:TColor read fColor1 write SetColor1;
    property Color2:TColor read fColor2 write SetColor2;
    property Color3:TColor read fColor3 write SetColor3;
    property BigTicksDiv:integer read fBigTicksDiv write SetBigTicksDiv;
    property TickHeight:integer read fTickHeight write SetTickHeight;
    property BigTickHeight:integer read fBigTickHeight write SetBigTickHeight;
    property NeedleColor:TColor read fNeedleColor write SetNeedleColor;
    property NeedleWidth:integer read fNeedleWidth write SetNeedleWidth;
    property Angle:integer read fAngle write SetAngle;
    property Min:real read fMin write SetMin;
    property Max:real read fMax write SetMax;
    property Position:real read fPosition write SetPosition;
    property Precision:integer read fPrecision write SetPrecision;
    property Digits:integer read fDigits write SetDigits;
    property Percent1:integer read fPercent1 write SetPercent1;
    property Percent2:integer read fPercent2 write SetPercent2;
    property Caption;
    property Name;
    property Font;
    property Enabled;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnContextPopup;
    property PopupMenu;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Majk', [TAnalogMeter]);
end;

constructor TAnalogMeter.create(AOwner: TComponent);
var fWidth,fHeight:integer;
begin
  inherited Create(AOwner);
  fWidth:=241;
  fHeight:=105;
  SetInitialBounds(0,0,fWidth,fHeight);
  OuterBevel:=TBevel.Create(Self);
  InnerBevel:=TBevel.Create(Self);
  fBevelWidth:=5;
//  if Width<20 then Width:=20;
//  if Height<20 then Height:=20;
  OuterBevel.Parent:=Self;
  OuterBevel.Left:=0;
  OuterBevel.Top:=0;
  OuterBevel.Width:=fWidth;
  OuterBevel.Height:=fHeight;
  OuterBevel.Style:=bsRaised;
  OuterBevel.Shape:=bsBox;
  OuterBevel.Align:=alClient;
  OuterBevel.ControlStyle:=OuterBevel.ControlStyle + [csNoDesignSelectable];
  InnerBevel.Parent:=Self;
  InnerBevel.Left:=fBevelWidth;
  InnerBevel.Top:=fBevelWidth;
  InnerBevel.Width:=fWidth-fBevelWidth*2;
  InnerBevel.Height:=fHeight-fBevelWidth*2;
  InnerBevel.Style:=bsLowered;
  InnerBevel.Shape:=bsBox;
  InnerBevel.ControlStyle:=InnerBevel.ControlStyle + [csNoDesignSelectable];
  AMeter.Left:=fBevelWidth+1;
  AMeter.Top:=fBevelWidth+1;
  AMeter.Right:=fBevelWidth+InnerBevel.Width;
  AMeter.Bottom:=fBevelWidth+InnerBevel.Height;
  fTicks:=51;
  fColor1:=clLime;
  fColor2:=clYellow;
  fColor3:=clRed;
  fNeedleColor:=clWhite;
  fBigTicksDiv:=10;
  fTickHeight:=5;
  fBigTickHeight:=10;
  fNeedleWidth:=1;
  fAngle:=90;
  fNumDistance:=15;
  fMin:=0.0;
  fMax:=5.0;
  fPosition:=0.0;
  fPrecision:=2;
  fDigits:=1;
  fPercent1:=60;
  fPercent2:=20;
  //Caption:=Name;
  fBackground:=clBlack;
  Font.Color:=clWhite;
  Font.Name:='Arial';
  Font.Size:=8;
end;

destructor TAnalogMeter.destroy;
begin
  OuterBevel.Destroy;
  InnerBevel.Destroy;
  inherited Destroy;
end;

procedure TAnalogMeter.PaintInterior(All:boolean);
var f,g,x,y:integer;
    alfa:real;
    s:string;
    OrigRect:TRect;
    OrigClipping:Boolean;
begin
  OrigRect:=Canvas.ClipRect;
  OrigClipping:=Canvas.Clipping;
  Canvas.ClipRect:=AMeter;
  Canvas.Clipping:=true;
  with Canvas do
  begin
    //Font.Color:=clWhite;
    Brush.Color:=fBackground;
    Pen.Width:=1;
    Pen.Color:=fColor1;
    for f:=0 to fTicks-1 do
    begin
      if f*100 div (fTicks-1)>fPercent1 then
        if f*100 div (fTicks-1)>fPercent1+fPercent2 then Pen.Color:=fColor3
                                                    else Pen.Color:=fColor2;
      alfa:=(f-(fTicks-1)/2)/(fTicks-1)*PI*Angle/180;
      x:=Self.Width div 2+trunc(sin(Alfa)*Polomer);
      y:=Posun-trunc(cos(Alfa)*Polomer);
      MoveTo(x,y);
      if f mod fBigTicksDiv=0 then g:=Polomer+fBigTickHeight
                              else g:=Polomer+fTickHeight;
      x:=Self.Width div 2+trunc(sin(Alfa)*g);
      y:=Posun-trunc(cos(Alfa)*g);
      LineTo(x,y);
      if (f mod fBigTicksDiv=0)and All then
      begin
        x:=Self.Width div 2+trunc(sin(Alfa)*(fNumDistance+Polomer));
        y:=Posun-trunc(cos(Alfa)*(fNumDistance+Polomer));
        s:=FloatToStrF(f/(fTicks-1)*(fMax-fMin)+fMin,ffNumber,fPrecision,fDigits);
        x:=x-TextWidth(s) div 2;
        y:=y-TextHeight(s);
        TextOut(x,y,s);
      end;
    end;
    TextOut(Self.Width div 2-TextWidth(Caption) div 2,
            AMeter.Bottom-TextHeight(Caption)-11,Caption);
    Pen.Color:=fNeedleColor;
    alfa:=(fPosition-(fMin+fMax)/2)/(fMax-fMin)*PI*Angle/180;
    x:=Self.Width div 2+trunc(sin(Alfa)*(Polomer+fBigTickHeight));
    y:=Posun-trunc(cos(Alfa)*(Polomer+fBigTickHeight));
    MoveTo(Self.Width div 2,Posun);
    Pen.Width:=fNeedleWidth;
    LineTo(x,y);
  end;
  Canvas.ClipRect:=OrigRect;
  Canvas.Clipping:=OrigClipping;
end;

procedure TAnalogMeter.RemoveNeedle;
var x,y:integer;
    alfa:real;
begin
  with Canvas do
  begin
    Brush.Color:=fBackground;
    Pen.Color:=fBackground;
    alfa:=(fPosition-(fMin+fMax)/2)/(fMax-fMin)*PI*Angle/180;
    x:=Width div 2+trunc(sin(Alfa)*(Polomer+fBigTickHeight));
    y:=Posun-trunc(cos(Alfa)*(Polomer+fBigTickHeight));
    MoveTo(Width div 2,Posun);
    Pen.Width:=fNeedleWidth;
    LineTo(x,y);
  end;
end;

procedure TAnalogMeter.Paint;
begin
  Canvas.Font:=Font;
  Canvas.Brush.Color:=fBackground;
  Canvas.Clipping:=false;
  Canvas.FillRect(AMeter);
  Canvas.Pen.Style:=psSolid;
  PaintInterior(true);
end;

procedure TAnalogMeter.Resize;
var alfa:real;
    Hranice:integer;
begin
  if Width<20+fBevelWidth*2 then Width:=20+fBevelWidth*2;
  if Height<15+fBevelWidth*2 then Height:=15+fBevelWidth*2;
  Inherited Resize;
  if not Assigned(Parent) then exit;
  InnerBevel.Left:=fBevelWidth;
  InnerBevel.Top:=fBevelWidth;
  InnerBevel.Width:=Width-fBevelWidth*2;
  InnerBevel.Height:=Height-fBevelWidth*2;
  AMeter.Left:=fBevelWidth+1;
  AMeter.Top:=fBevelWidth+1;
  AMeter.Right:=fBevelWidth+InnerBevel.Width;
  AMeter.Bottom:=fBevelWidth+InnerBevel.Height;
  Polomer:=(AMeter.Bottom-AMeter.Top)*5 div 4-5-fNumDistance-Canvas.TextHeight('0')-fBigTickHeight;
  Posun:=5+fNumDistance+Canvas.TextHeight('0')+Polomer+AMeter.Top;
  alfa:=(0-(fTicks-1)/2)/(fTicks-1)*PI*fAngle/180;
  Hranice:=Posun-trunc(cos(Alfa)*Polomer);
  if (Hranice>AMeter.Bottom-5)and(fAngle<>0) then
  begin
    Polomer:=trunc((AMeter.Bottom-AMeter.Top-5-fNumDistance-Canvas.TextHeight('0')-fBigTickHeight)/(1-cos(fAngle*PI/360)));
    Posun:=Polomer+AMeter.Top+fNumDistance+fBigTickHeight+trunc(Canvas.TextHeight('0')*sin(fAngle*PI/360));
  end;
  Paint;
end;

procedure TAnalogMeter.SetBackground(NewValue:TColor);
begin
  fBackground:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetBevelWidth(NewValue:integer);
var alfa:real;
    Hranice:integer;
begin
  fBevelWidth:=NewValue;
  if Width<20+fBevelWidth*2 then fBevelWidth:=(Width-20) div 2;
  if Height<20+fBevelWidth*2 then fBevelWidth:=(Height-20) div 2;
  if fBevelWidth<0 then fBevelWidth:=0;
  InnerBevel.Left:=fBevelWidth;
  InnerBevel.Top:=fBevelWidth;
  InnerBevel.Width:=Width-fBevelWidth*2;
  InnerBevel.Height:=Height-fBevelWidth*2;
  AMeter.Left:=fBevelWidth+1;
  AMeter.Top:=fBevelWidth+1;
  AMeter.Right:=fBevelWidth+InnerBevel.Width;
  AMeter.Bottom:=fBevelWidth+InnerBevel.Height;
  Polomer:=(AMeter.Bottom-AMeter.Top)*5 div 4-5-fNumDistance-Canvas.TextHeight('0')-fBigTickHeight;
  Posun:=5+fNumDistance+Canvas.TextHeight('0')+Polomer+AMeter.Top;
  alfa:=(0-(fTicks-1)/2)/(fTicks-1)*PI*fAngle/180;
  Hranice:=Posun-trunc(cos(Alfa)*Polomer);
  if (Hranice>AMeter.Bottom-5)and(fAngle<>0) then
  begin
    Polomer:=trunc((AMeter.Bottom-AMeter.Top-5-fNumDistance-Canvas.TextHeight('0')-fBigTickHeight)/(1-cos(fAngle*PI/360)));
    Posun:=Polomer+AMeter.Top+fNumDistance+fBigTickHeight+trunc(Canvas.TextHeight('0')*sin(fAngle*PI/360));
  end;
  Paint;
end;

procedure TAnalogMeter.SetNumDistance(NewValue:integer);
begin
  fNumDistance:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetTicks(NewValue:integer);
begin
  if NewValue<2 then NewValue:=2;
  if NewValue>10000 then NewValue:=10000;
  fTicks:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetColor1(NewValue:TColor);
begin
  fColor1:=NewValue;
  PaintInterior(false);
end;

procedure TAnalogMeter.SetColor2(NewValue:TColor);
begin
  fColor2:=NewValue;
  PaintInterior(false);
end;

procedure TAnalogMeter.SetColor3(NewValue:TColor);
begin
  fColor3:=NewValue;
  PaintInterior(false);
end;

procedure TAnalogMeter.SetBigTicksDiv(NewValue:integer);
begin
  if NewValue<1 then NewValue:=1;
  fBigTicksDiv:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetTickHeight(NewValue:integer);
begin
  if NewValue<0 then NewValue:=0;
  fTickHeight:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetBigTickHeight(NewValue:integer);
begin
  if NewValue<0 then NewValue:=0;
  fBigTickHeight:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetNeedleColor(NewValue:TColor);
begin
  fNeedleColor:=NewValue;
  PaintInterior(false);
end;

procedure TAnalogMeter.SetNeedleWidth(NewValue:integer);
begin
  if NewValue<0 then NewValue:=0;
  fNeedleWidth:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetAngle(NewValue:integer);
var alfa:real;
    Hranice:integer;
begin
  if NewValue<1 then NewValue:=1;
  fAngle:=NewValue;
  Polomer:=(AMeter.Bottom-AMeter.Top)*5 div 4-5-fNumDistance-Canvas.TextHeight('0')-fBigTickHeight;
  Posun:=5+fNumDistance+Canvas.TextHeight('0')+Polomer+AMeter.Top;
  alfa:=(0-(fTicks-1)/2)/(fTicks-1)*PI*fAngle/180;
  Hranice:=Posun-trunc(cos(Alfa)*Polomer);
  if (Hranice>AMeter.Bottom-5)and(fAngle<>0) then
  begin
    Polomer:=trunc((AMeter.Bottom-AMeter.Top-5-fNumDistance-Canvas.TextHeight('0')-fBigTickHeight)/(1-cos(fAngle*PI/360)));
    Posun:=Polomer+AMeter.Top+fNumDistance+fBigTickHeight+trunc(Canvas.TextHeight('0')*sin(fAngle*PI/360));
  end;
  Paint;
end;

procedure TAnalogMeter.SetMin(NewValue:real);
begin
  if NewValue>fPosition then NewValue:=fPosition;
  if NewValue>fMax then NewValue:=fMax;
  fMin:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetMax(NewValue:real);
begin
  if NewValue<fPosition then NewValue:=fPosition;
  if NewValue<fMin then NewValue:=fMin;
  fMax:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetPosition(NewValue:real);
begin
  if NewValue>fMax then NewValue:=fMax;
  if NewValue<fMin then NewValue:=fMin;
  RemoveNeedle;
  fPosition:=NewValue;
  PaintInterior(false);
end;

procedure TAnalogMeter.SetPrecision(NewValue:integer);
begin
  if NewValue<0 then NewValue:=0;
  fPrecision:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetDigits(NewValue:integer);
begin
  if NewValue<0 then NewValue:=0;
  fDigits:=NewValue;
  Paint;
end;

procedure TAnalogMeter.SetPercent1(NewValue:integer);
begin
  if NewValue<0 then NewValue:=0;
  if NewValue>100 then NewValue:=100;
  fPercent1:=NewValue;
  PaintInterior(false);
end;

procedure TAnalogMeter.SetPercent2(NewValue:integer);
begin
  if NewValue<0 then NewValue:=0;
  if NewValue>100 then NewValue:=100;
  fPercent2:=NewValue;
  PaintInterior(false);
end;

initialization
  {$I Meters.lrs}
end.
