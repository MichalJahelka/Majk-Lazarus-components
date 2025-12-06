unit Gauges;

{ Visual Lazarus components

  MIT license

  Created by Michal Jahelka at vsb.cz

  TGauge - Gauge with Foreground and Background color
  TGauge3D - Gauge with Foreground and Background color and 3D effect
  TLED - LED like visual component, on, off, colors
  TLEDLabel - LED like visual component with text, on, off, colors }

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  GraphUtil, ExtCtrls;

type

  { TGauge }

  TGauge = class(TGraphicControl)
  private
    { Private declarations }
    fForeColor,fBackColor:TColor;
    fProgress,fMaxValue,fMinValue:integer;
    fTextVisible:boolean;
    procedure SetProgress(Value:integer);
    procedure SetMaxValue(Value:integer);
    procedure SetMinValue(Value:integer);
    procedure SetTextVisible(Value:boolean);
    procedure SetForeColor(Value:TColor);
    procedure SetBackColor(Value:TColor);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property BorderSpacing;
    property Constraints;
    property Enabled;
    property ParentShowHint;
    property OnChangeBounds;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint;
    property OnResize;
    property ShowHint;
    property Visible;
    property Font;
    property Color;
    property Progress:integer read fProgress write SetProgress;
    property MaxValue:integer read fMaxValue write SetMaxValue;
    property MinValue:integer read fMinValue write SetMinValue;
    property TextVisible:boolean read fTextVisible write SetTextVisible;
    property ForeColor:TColor read fForeColor write SetForeColor;
    property BackColor:TColor read fBackColor write SetBackColor;
  end;

  { TGauge3D }

  TGauge3D = class(TGraphicControl)
  private
    { Private declarations }
    fForeColor,fBackColor:TColor;
    fProgress,fMaxValue,fMinValue:integer;
    fTextVisible:boolean;
    procedure SetProgress(Value:integer);
    procedure SetMaxValue(Value:integer);
    procedure SetMinValue(Value:integer);
    procedure SetTextVisible(Value:boolean);
    procedure SetForeColor(Value:TColor);
    procedure SetBackColor(Value:TColor);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property BorderSpacing;
    property Constraints;
    property Enabled;
    property ParentShowHint;
    property OnChangeBounds;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnPaint;
    property OnResize;
    property ShowHint;
    property Visible;
    property Font;
    property Color;
    property Progress:integer read fProgress write SetProgress;
    property MaxValue:integer read fMaxValue write SetMaxValue;
    property MinValue:integer read fMinValue write SetMinValue;
    property TextVisible:boolean read fTextVisible write SetTextVisible;
    property ForeColor:TColor read fForeColor write SetForeColor;
    property BackColor:TColor read fBackColor write SetBackColor;
  end;

  { TLED }

  TLED = class(TGraphicControl)
  private
    { Private declarations }
    fOnColor,fOffColor:TColor;
    fLit:boolean;
    fRound:boolean;
    procedure SetLit(Value:boolean);
    procedure SetOnColor(Value:TColor);
    procedure SetOffColor(Value:TColor);
    procedure SetRound(Value:boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property BorderSpacing;
    property Constraints;
    property OnChangeBounds;
    property OnClick;
    property OnPaint;
    property OnResize;
    property Visible;
    property Lit:boolean read fLit write SetLit;
    property OnColor:TColor read fOnColor write SetOnColor;
    property OffColor:TColor read fOffColor write SetOffColor;
    property Round:boolean read fRound write SetRound;
  end;

  { TLEDLabel }

  TLEDLabel = class(TLED)
  private
    { Private declarations }
    fCaption:string;
    fLabelPosition:TLabelPosition;
    fTransparent:Boolean;
    procedure DrawLED(PozX,PozY,Size:integer);
    procedure SetLabelPosition(Value:TLabelPosition);
    procedure SetTransparent(Value:boolean);
    procedure SetCaption(Value:string);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    { Published declarations }
    property Align;
    property Anchors;
    property BorderSpacing;
    property Constraints;
    property OnChangeBounds;
    property OnClick;
    property OnPaint;
    property OnResize;
    property Visible;
    property Font;
    property Color;
    property Lit;
    property OnColor;
    property OffColor;
    property LabelPosition:TLabelPosition read fLabelPosition write SetLabelPosition;
    property Transparent:boolean read fTransparent write SetTransparent;
    property Caption:string read fCaption write SetCaption;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Majk',[TGauge]);
  RegisterComponents('Majk',[TGauge3D]);
  RegisterComponents('Majk',[TLED]);
  RegisterComponents('Majk',[TLEDLabel]);
end;

function ZmenJas(Barva:TColor;Jas:integer):TColor;
var ColH, ColL, ColS: Byte;
begin
  ColorToHLS(Barva, ColH, ColL, ColS);
  Jas:=Jas+ColL;
  if Jas>255 then Jas:=255;
  if Jas<0 then Jas:=0;
  Result:=HLStoColor(ColH, Jas, ColS);
end;

{ TGauge }

constructor TGauge.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  fMaxValue:=100;
  fMinValue:=0;
  fProgress:=0;
  fForeColor:=clBlue;
  fBackColor:=clRed;
  fTextVisible:=true;
  Color:=clBlack;
  SetInitialBounds(0,0,200,40);
end;

destructor TGauge.Destroy;
begin
  inherited Destroy;
end;

procedure TGauge.Paint;
var Pozice,Sirka:integer;
    s:string;
begin
  inherited Paint;
  Canvas.Brush.Style:=bsSolid;
  Canvas.Pen.Color:=Color;
  Canvas.Pen.Style:=psSolid;
  Canvas.Rectangle(0,0,Width,Height);
  Sirka:=Width-2;
  Pozice:=fProgress;
  if fMaxValue=fMinValue then fMaxValue:=fMinValue+1;
  if Pozice<fMinValue then Pozice:=fMinValue;
  if Pozice>fMaxValue then Pozice:=fMaxValue;
  Pozice:=(Pozice-fMinValue)*Sirka div (fMaxValue-fMinValue);
  Canvas.Brush.Color:=fForeColor;
  if Pozice>0 then Canvas.FillRect(1,1,Pozice+1,Height-1);
  Canvas.Brush.Color:=fBackColor;
  if Pozice+3<Width then Canvas.FillRect(Pozice+1,1,Width-1,Height-1);
  s:=IntToStr((fProgress-fMinValue)*100 div (fMaxValue-fMinValue))+'%';
  if fTextVisible then
  begin
    Canvas.Brush.Color:=InvertColor(Color);
    Canvas.Font.Color:=Font.Color;
    Canvas.TextOut(Width div 2-Canvas.TextWidth(s) div 2,
                   Height div 2-Canvas.TextHeight(s) div 2,s);
  end;
end;

procedure TGauge.SetProgress(Value: integer);
begin
  fProgress:=Value;
  Invalidate;
end;

procedure TGauge.SetMaxValue(Value: integer);
begin
  fMaxValue:=Value;
  Invalidate;
end;

procedure TGauge.SetMinValue(Value: integer);
begin
  fMinValue:=Value;
  Invalidate;
end;

procedure TGauge.SetTextVisible(Value: boolean);
begin
  fTextVisible:=Value;
  Invalidate;
end;

procedure TGauge.SetForeColor(Value: TColor);
begin
  fForeColor:=Value;
  Invalidate;
end;

procedure TGauge.SetBackColor(Value: TColor);
begin
  fBackColor:=Value;
  Invalidate;
end;

{ TGauge3D }

constructor TGauge3D.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  fMaxValue:=100;
  fMinValue:=0;
  fProgress:=0;
  fForeColor:=clBlue;
  fBackColor:=clRed;
  fTextVisible:=true;
  Color:=clBlack;
  SetInitialBounds(0,0,200,40);
end;

destructor TGauge3D.Destroy;
begin
  inherited Destroy;
end;

procedure TGauge3D.Paint;
var Pozice,Sirka,f:integer;
    s:string;
    ARect:TRect;
    CTextStyle:TTextStyle;
begin
  inherited Paint;
  Canvas.Brush.Style:=bsSolid;
  Canvas.Pen.Color:=Color;
  Canvas.Pen.Style:=psSolid;
  Canvas.Rectangle(0,0,Width,Height);
  Sirka:=Width-2;
  Pozice:=fProgress;
  if fMaxValue=fMinValue then fMaxValue:=fMinValue+1;
  if Pozice<fMinValue then Pozice:=fMinValue;
  if Pozice>fMaxValue then Pozice:=fMaxValue;
  Pozice:=(Pozice-fMinValue)*Sirka div (fMaxValue-fMinValue);
  if Pozice>0 then
  begin
    if(Pozice>5) then
    begin
      ARect.Left:=1;
      ARect.Top:=1;
      ARect.Right:=Pozice+1-5;
      ARect.Bottom:=Height div 2;
      Canvas.GradientFill(ARect,fForeColor,ZmenJas(fForeColor,50),gdVertical);
      ARect.Top:=Height div 2;
      ARect.Bottom:=Height-1;
      Canvas.GradientFill(ARect,ZmenJas(fForeColor,50),ZmenJas(fForeColor,-50),gdVertical);
    end;
    for f:=1 to 5 do if Pozice>=6-f then
    begin
      ARect.Left:=Pozice+f-5;
      ARect.Right:=1+Pozice+f-5;
      ARect.Top:=1;
      ARect.Bottom:=Height div 2;
      Canvas.GradientFill(ARect,ZmenJas(fForeColor,-f*5),ZmenJas(fForeColor,50-f*5),gdVertical);
      ARect.Top:=Height div 2;
      ARect.Bottom:=Height-1;
      Canvas.GradientFill(ARect,ZmenJas(fForeColor,50-f*5),ZmenJas(fForeColor,-50-f*5),gdVertical);
    end;
  end;
  if Pozice+3<Width then
  begin
    ARect.Left:=Pozice+1;
    ARect.Top:=1;
    ARect.Right:=Width-1;
    ARect.Bottom:=Height-1;
    Canvas.GradientFill(ARect,fBackColor,GetHighLightColor(fBackColor,50),gdVertical);
  end;
  s:=IntToStr((fProgress-fMinValue)*100 div (fMaxValue-fMinValue))+'%';
  if fTextVisible then
  begin
    CTextStyle:=Canvas.TextStyle;
    CTextStyle.Opaque:=true;
    Canvas.TextStyle:=CTextStyle;
    //Canvas.Brush.Color:=InvertColor(Color);
    Canvas.Font.Color:=Font.Color;
    Canvas.CopyMode:=cmSrcInvert;
    Canvas.Brush.Style:=bsClear;
    Canvas.TextOut(Width div 2-Canvas.TextWidth(s) div 2,
                   Height div 2-Canvas.TextHeight(s) div 2,s);
  end;
end;

procedure TGauge3D.SetProgress(Value: integer);
begin
  fProgress:=Value;
  Invalidate;
end;

procedure TGauge3D.SetMaxValue(Value: integer);
begin
  fMaxValue:=Value;
  Invalidate;
end;

procedure TGauge3D.SetMinValue(Value: integer);
begin
  fMinValue:=Value;
  Invalidate;
end;

procedure TGauge3D.SetTextVisible(Value: boolean);
begin
  fTextVisible:=Value;
  Invalidate;
end;

procedure TGauge3D.SetForeColor(Value: TColor);
begin
  fForeColor:=Value;
  Invalidate;
end;

procedure TGauge3D.SetBackColor(Value: TColor);
begin
  fBackColor:=Value;
  Invalidate;
end;

{ TLED }

constructor TLED.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  fOffColor:=clGreen;
  fOnColor:=clLime;
  fLit:=false;
  fRound:=false;
  SetInitialBounds(0,0,20,20);
end;

destructor TLED.Destroy;
begin
  inherited Destroy;
end;

procedure TLED.Paint;
var Barva:TColor;
    f,NasobekBarvy:integer;
    ColH, ColL, ColS: Byte;
begin
  if fRound then Width:=Height;
  inherited Paint;
  if Lit then Barva:=fOnColor
         else Barva:=fOffColor;
  Canvas.Pen.Color:=clBlack;
  Canvas.Brush.Color:=clWhite;
  Canvas.Ellipse(0,0,Width,Height);
  Canvas.Pen.Color:=clLtGray;
  Canvas.Brush.Color:=clLtGray;
  Canvas.Pie(0,0,Width,Height,width,3,3,Height);
  Canvas.Pen.Color:=clGray;
  Canvas.Brush.Color:=clGray;
  Canvas.Pie(0,0,Width,Height,width-3,0,0,Height-3);
  Canvas.Pen.Color:=clBlack;
  Canvas.Brush.Style:=bsClear;
  Canvas.Ellipse(0,0,Width,Height);
  Canvas.Brush.Style:=bsSolid;
  Canvas.Brush.Color:=Barva;
  Canvas.Pen.Color:=ZmenJas(Barva,-20);
  Canvas.Ellipse(3,3,Width-3,Height-3);
  ColorToHLS(Barva, ColH, ColL, ColS);
  NasobekBarvy:=ColL*400 div 64;
  for f:=0 to Width div 10 do
  begin
    Canvas.Pen.Color:=ZmenJas(Barva,f*NasobekBarvy div Width);
    Canvas.Arc(Width*3 div 7-f,Height*3 div 7-f*Height div Width,
               Width*4 div 7+f,Height*4 div 7+f*Height div Width,720,3000);
    Canvas.Arc(Width*3 div 7-Width div 5+f,Height*3 div 7+(f-Width div 5)*Height div Width,
               Width*4 div 7+Width div 5-f,Height*4 div 7+(Width div 5-f)*Height div Width,720,3000);
  end;
end;

procedure TLED.SetLit(Value: boolean);
begin
  fLit:=Value;
  Invalidate;
end;

procedure TLED.SetOnColor(Value: TColor);
begin
  fOnColor:=Value;
  Invalidate;
end;

procedure TLED.SetOffColor(Value: TColor);
begin
  fOffColor:=Value;
  Invalidate;
end;

procedure TLED.SetRound(Value: boolean);
begin
  fRound:=Value;
  if fRound then Width:=Height;
  Invalidate;
end;

{ TLEDLabel }

constructor TLEDLabel.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  ControlStyle := [csSetCaption, csClickEvents, csDoubleClicks, csReplicatable];
  fCaption:=Name;
  fRound:=false;
  Height:=20;
  Width:=100;
  fLabelPosition:=lpRight;
  fTransparent:=false;
end;

destructor TLEDLabel.Destroy;
begin
  inherited Destroy;
end;

procedure TLEDLabel.DrawLED(PozX, PozY, Size: integer);
var Barva:TColor;
    f,NasobekBarvy:integer;
    ColH, ColL, ColS: Byte;
begin
  if Size<8 then exit;
  if Lit then Barva:=fOnColor
         else Barva:=fOffColor;
  Canvas.Pen.Color:=clBlack;
  Canvas.Brush.Color:=clWhite;
  Canvas.Brush.Style:=bsSolid;
  Canvas.Ellipse(PozX,PozY,PozX+Size,PozY+Size);
  Canvas.Pen.Color:=clLtGray;
  Canvas.Brush.Color:=clLtGray;
  Canvas.Pie(PozX,PozY,PozX+Size,PozY+Size,PozX+Size,PozY+3,PozX+3,PozY+Size);
  Canvas.Pen.Color:=clGray;
  Canvas.Brush.Color:=clGray;
  Canvas.Pie(PozX,PozY,PozX+Size,PozY+Size,PozX+Size-3,PozY,PozX,PozY+Size-3);
  Canvas.Pen.Color:=clBlack;
  Canvas.Brush.Style:=bsClear;
  Canvas.Ellipse(PozX,PozY,PozX+Size,PozY+Size);
  Canvas.Brush.Style:=bsSolid;
  Canvas.Brush.Color:=Barva;
  Canvas.Pen.Color:=ZmenJas(Barva,-20);
  Canvas.Ellipse(PozX+3,PozY+3,PozX+Size-3,PozY+Size-3);
  ColorToHLS(Barva, ColH, ColL, ColS);
  NasobekBarvy:=ColL*400 div 64;
  for f:=0 to Size div 10 do
  begin
    Canvas.Pen.Color:=ZmenJas(Barva,f*NasobekBarvy div Size);
    Canvas.Arc(PozX+Size*3 div 7-f,PozY+Size*3 div 7-f,
               PozX+Size*4 div 7+f,PozY+Size*4 div 7+f,720,3000);
    Canvas.Arc(PozX+Size*3 div 7-Size div 5+f,PozY+Size*3 div 7-Size div 5+f,
               PozX+Size*4 div 7+Size div 5-f,PozY+Size*4 div 7+Size div 5-f,720,3000);
  end;
end;

procedure TLEDLabel.Paint;
var x,y:integer;
begin
  Canvas.Brush.Color:=Color;
  if fTransparent then Canvas.Brush.Style:=bsClear
                  else Canvas.FillRect(0,0,Width,Height);
  y:=Canvas.TextHeight(fCaption);
  x:=Canvas.TextWidth(fCaption);
  case fLabelPosition of
    lpRight:
    begin
      Canvas.TextOut(Height+5,(Height-y) div 2,fCaption);
      DrawLED(0,0,Height);
    end;
    lpLeft:
    begin
      Canvas.TextOut(0,(Height-y) div 2,fCaption);
      Canvas.FillRect(Width-Height-5,0,Width,Height);
      DrawLED(Width-Height,0,Height);
    end;
    lpAbove:
    begin
      Canvas.TextOut((Width-x) div 2,0,fCaption);
      DrawLED((Width-Height+y+5) div 2,y+5,Height-(y+5));
    end;
    lpBelow:
    begin
      Canvas.TextOut((Width-x) div 2,Height-y,fCaption);
      DrawLED((Width-Height+y+5) div 2,0,Height-(y+5));
    end;
  end;
end;

procedure TLEDLabel.SetLabelPosition(Value: TLabelPosition);
begin
  if fLabelPosition=Value then exit;
  fLabelPosition:=Value;
  if Self=nil then exit;
  case fLabelPosition of
    lpRight,lpLeft:
    begin
      Width:=Canvas.TextWidth(fCaption)+Canvas.TextHeight(fCaption)+5;
      Height:=Canvas.TextHeight(fCaption);
    end;
    lpAbove,lpBelow:
    begin
      Width:=Canvas.TextWidth(fCaption);
      Height:=Canvas.TextHeight(fCaption)*2+5;
    end;
  end;
  Invalidate;
end;

procedure TLEDLabel.SetTransparent(Value: boolean);
begin
  fTransparent:=Value;
  Invalidate;
end;

procedure TLEDLabel.SetCaption(Value: string);
begin
  fCaption:=Value;
  Invalidate;
end;

initialization
  {$I Gauges.lrs}
end.
