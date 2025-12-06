unit Switches;

{ Switches - Visual Lazarus components

  MIT license

  Created by Michal Jahelka at vsb.cz

  TImageSwitch - Draw a switch and load it
                 Four images: OnImage and OffImage, On and Off mouse over images

  TAniSwitch - Nonvisual component, but good for create animation switch
               From this class comes next switches

  TLeverSwitch - Animated lever switch

  TPushPullSwitch - Animated Push-Pull switch (flip-flop) }

interface

{$mode objfpc}{$H+}

uses
  LCLIntf, LCLType, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, LResources, LMessages;

type
  TArea=class(TPersistent)
  private
    fLeft,fRight,fTop,fBottom:integer;
  published
    property Left:integer read fLeft write fLeft;
    property Right:integer read fRight write fRight;
    property Top:integer read fTop write fTop;
    property Bottom:integer read fBottom write fBottom;
  end;

  { TImageSwitch }

  TImageSwitch = class(TCustomControl)
  private
    { Private declarations }
    fOnImage,fOffImage,fOnMouseImage,fOffMouseImage:TPicture;
    fSwitchState:boolean;
    fOnArea,fOffArea:TArea;
    fOnChange:TNotifyEvent;
    fOldWidth,fOldHeight:integer;
    fMouseOver:boolean;
    procedure SetOnImage(Value:TPicture);
    procedure SetOffImage(Value:TPicture);
    procedure SetOnMouseImage(Value:TPicture);
    procedure SetOffMouseImage(Value:TPicture);
    procedure SetSwitchState(Value:boolean);
    procedure WMSetFocus(var Message: TLMSetFocus); message LM_SETFOCUS;
    procedure WMKillFocus(var Message: TLMSetFocus); message LM_KILLFOCUS;
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X,Y: Integer); override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Resize; override;
  published
    { Published declarations }
    property OnImage:TPicture read fOnImage write SetOnImage;
    property OffImage:TPicture read fOffImage write SetOffImage;
    property OnMouseImage:TPicture read fOnMouseImage write SetOnMouseImage;
    property OffMouseImage:TPicture read fOffMouseImage write SetOffMouseImage;
    property SwitchState:boolean read fSwitchState write SetSwitchState default false;
    property OnArea:TArea read fOnArea write fOnArea;
    property OffArea:TArea read fOffArea write fOffArea;
    property OnChange:TNotifyEvent read fOnChange write fOnChange;
    property Enabled;
    property TabOrder;
    property TabStop stored true;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
  end;

  { TAniSwitch }

  TAniSwitch=class(TCustomControl)
  private
    fOrientation:TUDOrientation;
    fOnChange:TNotifyEvent;
    fSwitchState,Rotating:boolean;
    SwitchPosition,fSteps:Integer;
    Timer:TTimer;
    TimerTicks:Cardinal;
    procedure SetOrientation(Value:TUDOrientation);
    procedure SetSwitchState(Value:boolean);
    procedure SetSteps(Value:integer);
    function  GetSteps:integer;
    procedure SetInterval(Value:cardinal);
    function  GetInterval:cardinal;
    procedure SwitchingTimer(Sender: TObject);
    procedure WMSetFocus(var Message: TLMSetFocus); message LM_SETFOCUS;
    procedure WMKillFocus(var Message: TLMSetFocus); message LM_KILLFOCUS;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  published
    property Orientation:TUDOrientation read fOrientation write SetOrientation default udVertical;
    property OnChange:TNotifyEvent read fOnChange write fOnChange;
    property SwitchState:boolean read fSwitchState write SetSwitchState default false;
    property Steps:integer read GetSteps write SetSteps default 3;
    property Interval:cardinal read GetInterval write SetInterval default 50;
    property Enabled;
    property TabOrder;
    property TabStop default true;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
  end;

  TLeverSwitch=class(TAniSwitch)
  private
    fLever,fPipe,fInterior,fFront,fScrew:TColor;
    fLeverHeight,fLeverWidth:integer;
    fPipeHeight,fPipeWidth:integer;
    fScrewSize:integer;
    fOldWidth,fOldHeight:integer;
    procedure SetLeverColor(Value:TColor);
    procedure SetPipeColor(Value:TColor);
    procedure SetInteriorColor(Value:TColor);
    procedure SetFrontColor(Value:TColor);
    procedure SetScrewColor(Value:TColor);
    procedure SetLeverHeight(Value:Integer);
    procedure SetLeverWidth(Value:Integer);
    procedure SetPipeHeight(Value:Integer);
    procedure SetPipeWidth(Value:Integer);
    procedure SetScrewSize(Value:Integer);
    procedure SetSwitchState(Value:Boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Resize; override;
  published
    property Lever:TColor read fLever write SetLeverColor default clRed;
    property Pipe:TColor read fPipe write SetPipeColor default clWhite;
    property Interior:TColor read fInterior write SetInteriorColor default clGray;
    property Front:TColor read fFront write SetFrontColor default clAqua;
    property Screw:TColor read fScrew write SetScrewColor default clBlack;
    property LeverWidth:integer read fLeverWidth write SetLeverWidth default 10;
    property LeverHeight:integer read fLeverHeight write SetLeverHeight default 20;
    property PipeWidth:integer read fPipeWidth write SetPipeWidth default 5;
    property PipeHeight:integer read fPipeHeight write SetPipeHeight default 10;
    property ScrewSize:integer read fScrewSize write SetScrewSize default 3;
    property SwitchState:boolean read fSwitchState write SetSwitchState;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

  TPushPullSwitch=class(TAniSwitch)
  private
    fBottomColor,fTopColor,fTopSideColor,fBottomSideColor,fSideColor,fBoardColor:TColor;
    fPushHeight,fPullHeight,fBoardWidth,fTopWidth,fBottomWidth:integer;
    procedure SetBottomColor(Value:TColor);
    procedure SetTopColor(Value:TColor);
    procedure SetSideColor(Value:TColor);
    procedure SetTopSideColor(Value:TColor);
    procedure SetBottomSideColor(Value:TColor);
    procedure SetBoardColor(Value:TColor);
    procedure SetPushHeight(Value:Integer);
    procedure SetPullHeight(Value:Integer);
    procedure SetBoardWidth(Value:Integer);
    procedure SetTopWidth(Value:Integer);
    procedure SetBottomWidth(Value:Integer);
    procedure SetSwitchState(Value:Boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property TopColor:TColor read fTopColor write SetTopColor default clBlue;
    property BottomColor:TColor read fBottomColor write SetBottomColor default $FF9F9F;
    property SideColor:TColor read fSideColor write SetSideColor default clGray;
    property TopSideColor:TColor read fTopSideColor write SetTopSideColor default $FFDDDD;
    property BottomSideColor:TColor read fBottomSideColor write SetBottomSideColor default $550000;
    property BoardColor:TColor read fBoardColor write SetBoardColor default clWhite;
    property PushHeight:integer read fPushHeight write SetPushHeight default 4;
    property PullHeight:integer read fPullHeight write SetPullHeight default 10;
    property BoardWidth:integer read fBoardWidth write SetBoardWidth default 3;
    property TopWidth:integer read fTopWidth write SetTopWidth default 2;
    property BottomWidth:integer read fBottomWidth write SetBottomWidth default 0;
    property SwitchState:boolean read fSwitchState write SetSwitchState;
    property OnMouseEnter;
    property OnMouseLeave;
  end;

procedure Register;

implementation

uses Math;

procedure Register;
begin
  RegisterComponents('Majk', [TImageSwitch]);
  RegisterComponents('Majk', [TLeverSwitch]);
  RegisterComponents('Majk', [TPushPullSwitch]);
end;

constructor TImageSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fOnImage:=TPicture.Create;
  fOffImage:=TPicture.Create;
  fOnMouseImage:=TPicture.Create;
  fOffMouseImage:=TPicture.Create;
  fMouseOver:=false;
  Brush.Style:=bsClear;
  fOnArea:=TArea.Create;
  fOffArea:=TArea.Create;
  fOldWidth:=20;
  fOldHeight:=40;
  SetInitialBounds(0,0,20,40);
end;

destructor TImageSwitch.Destroy;
begin
  fOnImage.Destroy;
  fOffImage.Destroy;
  fOnMouseImage.Destroy;
  fOffMouseImage.Destroy;
  fOnArea.Destroy;
  fOffArea.Destroy;
  inherited Destroy;
end;

procedure TImageSwitch.SetOnImage(Value:TPicture);
begin
  fOnImage.Assign(Value);
  SetBounds(left,top,Value.Width,Value.Height);
  Invalidate;
end;

procedure TImageSwitch.SetOffImage(Value:TPicture);
begin
  fOffImage.Assign(Value);
  SetBounds(left,top,Value.Width,Value.Height);
  Invalidate;
end;

procedure TImageSwitch.SetOnMouseImage(Value: TPicture);
begin
  fOnMouseImage.Assign(Value);
  SetBounds(left,top,Value.Width,Value.Height);
  Invalidate;
end;

procedure TImageSwitch.SetOffMouseImage(Value: TPicture);
begin
  fOffMouseImage.Assign(Value);
  SetBounds(left,top,Value.Width,Value.Height);
  Invalidate;
end;

procedure TImageSwitch.Paint;
var Arect:TRect;
    Drawed:boolean;
begin
  ARect:=ClientRect;
  Canvas.Brush.Color:=clBtnFace;
  Canvas.Brush.Style:=bsSolid;
  Drawed:=false;
  if fSwitchState then
  begin
    if fMouseOver or Self.Focused then
    begin
      if assigned(fOnMouseImage.Graphic) then
        if not fOnImage.Graphic.Empty then
        begin
          Canvas.StretchDraw(ClientRect,fOnImage.Graphic);
          Drawed:=true;
        end;
    end else begin
      if assigned(fOnMouseImage.Graphic) then
        if not fOnMouseImage.Graphic.Empty then
        begin
          Canvas.StretchDraw(ClientRect,fOnMouseImage.Graphic);
          Drawed:=true;
        end;
    end;
    if not Drawed then
    begin
      Canvas.FillRect(ARect);
      Canvas.Frame3d(ARect,3,bvLowered);
    end;
  end else begin
    if fMouseOver or Self.Focused then
    begin
      if assigned(fOffMouseImage.Graphic) then
        if not fOffMouseImage.Graphic.Empty then
        begin
          Canvas.StretchDraw(ClientRect,fOffMouseImage.Graphic);
          Drawed:=true;
        end;
    end else begin
      if assigned(fOffImage.Graphic) then
        if not fOffImage.Graphic.Empty then
        begin
          Canvas.StretchDraw(ClientRect,fOffImage.Graphic);
          Drawed:=true;
        end;
    end;
    if not Drawed then
    begin
      Canvas.FillRect(ARect);
      Canvas.Frame3d(ARect,3,bvRaised);
    end;
  end;
end;

procedure TImageSwitch.MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  if (fOnArea.Right<=fOnArea.Left)or(fOnArea.Bottom<=fOnArea.Top)or
     (fOffArea.Right<=fOffArea.Left)or(fOffArea.Bottom<=fOffArea.Top) then
  begin
    fSwitchState:=not fSwitchState;
    Invalidate;
    if Assigned(fOnChange) then fOnChange(Self);
  end else begin
    if not fSwitchState and(X>=fOnArea.Left)and(X<fOnArea.Right)and
       (Y>=fOnArea.Top)and(Y<fOnArea.Bottom) then
    begin
      fSwitchState:=true;
      Invalidate;
      if Assigned(fOnChange) then fOnChange(Self);
    end;
    if fSwitchState and(X>=fOffArea.Left)and(X<fOffArea.Right)and
       (Y>=fOffArea.Top)and(Y<fOffArea.Bottom) then
    begin
      fSwitchState:=false;
      Invalidate;
      if Assigned(fOnChange) then fOnChange(Self);
    end;
  end;
  if CanFocus and not Focused and TabStop then SetFocus;
end;

procedure TImageSwitch.SetSwitchState(Value:boolean);
begin
  fSwitchState:=Value;
  Invalidate;
end;

procedure TImageSwitch.WMSetFocus(var Message: TLMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TImageSwitch.WMKillFocus(var Message: TLMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TImageSwitch.MouseMove(Shift: TShiftState; X,Y: Integer);
begin
  if (ssLeft in Shift)and
     not((fOnArea.Right<=fOnArea.Left)or(fOnArea.Bottom<=fOnArea.Top)or
     (fOffArea.Right<=fOffArea.Left)or(fOffArea.Bottom<=fOffArea.Top)) then
  begin
    if not fSwitchState and(X>=fOnArea.Left)and(X<fOnArea.Right)and
       (Y>=fOnArea.Top)and(Y<fOnArea.Bottom) then
    begin
      fSwitchState:=true;
      Invalidate;
      if Assigned(fOnChange) then fOnChange(Self);
    end;
    if fSwitchState and(X>=fOffArea.Left)and(X<fOffArea.Right)and
       (Y>=fOffArea.Top)and(Y<fOffArea.Bottom) then
    begin
      fSwitchState:=false;
      Invalidate;
      if Assigned(fOnChange) then fOnChange(Self);
    end;
  end;
end;

procedure TImageSwitch.MouseEnter;
begin
  inherited MouseEnter;
  fMouseOver:=true;
  Invalidate;
end;

procedure TImageSwitch.MouseLeave;
begin
  inherited MouseLeave;
  fMouseOver:=false;
  Invalidate;
end;

procedure TImageSwitch.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key=vk_Space then
  begin
    fSwitchState:=not fSwitchState;
    Invalidate;
    if Assigned(fOnChange) then fOnChange(Self);
  end;
end;

procedure TImageSwitch.Resize;
begin
  if Height<5 then Height:=5;
  if Width<5 then Width:=5;
  OnArea.Left:=fOnArea.Left*Width div fOldWidth;
  OnArea.Right:=fOnArea.Right*Width div fOldWidth;
  OffArea.Left:=fOffArea.Left*Width div fOldWidth;
  OffArea.Right:=fOffArea.Right*Width div fOldWidth;
  OnArea.Top:=fOnArea.Top*Height div fOldHeight;
  OnArea.Bottom:=fOnArea.Bottom*Height div fOldHeight;
  OffArea.Top:=fOffArea.Top*Height div fOldHeight;
  OffArea.Bottom:=fOffArea.Bottom*Height div fOldHeight;
  fOldWidth:=Width;
  fOldHeight:=Height;
end;

constructor TAniSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Timer:=TTimer.Create(Self);
  Timer.Enabled:=false;
  Timer.Interval:=50;
  Timer.OnTimer:=@SwitchingTimer;
  fSteps:=3;
  fOrientation:=udVertical;
  SwitchPosition:=fSteps;
  fSwitchState:=false;
  TabStop:=true;
end;

destructor TAniSwitch.Destroy;
begin
  Timer.Destroy;
  inherited Destroy;
end;

procedure TAniSwitch.SetOrientation(Value:TUDOrientation);
var w:integer;
begin
  if (fOrientation<>Value)and((Orientation=udHorizontal)and(Width>Height)
                            or(Orientation=udVertical)and(Width<Height)) then
  begin
    Rotating:=true;
    w:=Width;
    Width:=Height;
    Height:=w;
    Rotating:=false;
  end;
  fOrientation:=Value;
  Invalidate;
end;

procedure TAniSwitch.MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  if fSteps=0 then
  begin
    fSwitchState:=not fSwitchState;
    if fSwitchState then SwitchPosition:=-1 else SwitchPosition:=1;
    if Assigned(fOnChange) then fOnChange(Self);
  end else begin
    Timer.Enabled:=true;
    TimerTicks:=GetTickCount;
    if fSwitchState then Inc(SwitchPosition)
                    else Dec(SwitchPosition);
  end;
  if CanFocus and not Focused and TabStop then SetFocus;
  Invalidate;
end;

procedure TAniSwitch.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key=vk_Space then
  begin
    if fSteps=0 then
    begin
      fSwitchState:=not fSwitchState;
      if fSwitchState then SwitchPosition:=-1 else SwitchPosition:=1;
      if Assigned(fOnChange) then fOnChange(Self);
    end else begin
      Timer.Enabled:=true;
      TimerTicks:=GetTickCount;
      if fSwitchState then Inc(SwitchPosition)
                      else Dec(SwitchPosition);
    end;
    if CanFocus and not Focused then SetFocus;
    Invalidate;
  end;
end;

procedure TAniSwitch.SetSwitchState(Value:boolean);
begin
  fSwitchState:=Value;
  if fSteps=0 then
  begin
    if Value then SwitchPosition:=-1 else SwitchPosition:=1;
  end else begin
    if Value then SwitchPosition:=-fSteps else SwitchPosition:=fSteps;
  end;
  Invalidate;
end;

procedure TAniSwitch.SetSteps(Value:integer);
begin
  if Value<1 then Value:=1;
  if Value>10 then Value:=10;
  fSteps:=Value div 2;
  if fSwitchState then SwitchPosition:=-fSteps else SwitchPosition:=fSteps;
  if fSteps=0 then if fSwitchState then SwitchPosition:=-1 else SwitchPosition:=1;
end;

function TAniSwitch.GetSteps:integer;
begin
  if fSteps=0 then Result:=1 else Result:=fSteps*2;
end;

procedure TAniSwitch.SetInterval(Value:cardinal);
begin
  if Value<1 then Value:=1;
  Timer.Interval:=Value;
end;

function  TAniSwitch.GetInterval:cardinal;
begin
  Result:=Timer.Interval;
end;

procedure TAniSwitch.SwitchingTimer(Sender: TObject);
var x:cardinal;
begin
  x:=(GetTickCount-TimerTicks) div Timer.Interval;
  if x=0 then x:=1;
  if fSwitchState then SwitchPosition:=SwitchPosition+Integer(x)
                  else SwitchPosition:=SwitchPosition-Integer(x);
  if SwitchPosition>fSteps then SwitchPosition:=fSteps;
  if SwitchPosition<-fSteps then SwitchPosition:=-fSteps;
  if Abs(SwitchPosition)=fSteps then
  begin
    Timer.Enabled:=false;
    fSwitchState:=not fSwitchState;
    if Assigned(OnChange) then OnChange(Self);
  end;
  Invalidate;
end;

procedure TAniSwitch.WMSetFocus(var Message: TLMSetFocus);
begin
  inherited;
  Invalidate;
end;

procedure TAniSwitch.WMKillFocus(var Message: TLMSetFocus);
begin
  inherited;
  Invalidate;
end;

constructor TLeverSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fLever:=clRed;
  fPipe:=clWhite;
  fInterior:=clGray;
  fFront:=clAqua;
  fScrew:=clBlack;
  fLeverWidth:=10;
  fLeverHeight:=20;
  fPipeWidth:=5;
  fPipeHeight:=10;
  fScrewSize:=3;
  fOldWidth:=20;
  fOldHeight:=28*2;
  SetInitialBounds(0,0,fOldWidth,fOldHeight);
end;

procedure TLeverSwitch.Paint;
var PipeBegin,PipeEnd,LeverBegin,LeverEnd:integer;
begin
  if fSteps=0 then
  begin
    PipeBegin:=0;
    PipeEnd:=fPipeHeight*SwitchPosition;
    LeverBegin:=fPipeHeight*4*SwitchPosition div 5;
    LeverEnd:=fPipeHeight*4*SwitchPosition div 5+fLeverHeight*SwitchPosition;
  end else if SwitchPosition>=0 then
  begin
    PipeBegin:=-(PipeWidth-PipeWidth*SwitchPosition div fSteps) div 2;
    PipeEnd:=fPipeHeight*SwitchPosition div fSteps+
             (PipeWidth-PipeWidth*SwitchPosition div fSteps) div 2;
    LeverBegin:=fPipeHeight*4*SwitchPosition div 5 div fSteps-
                (LeverWidth-LeverWidth*SwitchPosition div fSteps) div 2;
    LeverEnd:=fPipeHeight*4*SwitchPosition div 5 div fSteps+
              fLeverHeight*SwitchPosition div fSteps+
              (LeverWidth-LeverWidth*SwitchPosition div fSteps) div 2;
  end else begin
    PipeBegin:=(PipeWidth+PipeWidth*SwitchPosition div fSteps) div 2;
    PipeEnd:=fPipeHeight*SwitchPosition div fSteps-
             (PipeWidth+PipeWidth*SwitchPosition div fSteps) div 2;
    LeverBegin:=fPipeHeight*4*SwitchPosition div 5 div fSteps+
                (LeverWidth+LeverWidth*SwitchPosition div fSteps) div 2;
    LeverEnd:=fPipeHeight*4*SwitchPosition div 5 div fSteps+
              fLeverHeight*SwitchPosition div fSteps-
              (LeverWidth+LeverWidth*SwitchPosition div fSteps) div 2;
  end;
  if fOrientation=udVertical then
  begin
    if fScrewSize=0 then Canvas.Pen.Style:=psClear else Canvas.Pen.Style:=psSolid;
    Canvas.Pen.Color:=fScrew;
    Canvas.Pen.Width:=fScrewSize;
    Canvas.Brush.Color:=fFront;
    Canvas.Ellipse(ScrewSize div 2,Height div 2-width div 2+ScrewSize div 2,
                   width-ScrewSize div 2,Height div 2+width div 2-ScrewSize div 2);
    Canvas.Pen.Style:=psClear;
    Canvas.Brush.Color:=fInterior;
    Canvas.Ellipse(Width div 2-fPipeWidth*6 div 10,Height div 2-width div 2+fScrewSize*5 div 4,
                   Width div 2+fPipeWidth*6 div 10,Height div 2+width div 2-fScrewSize*5 div 4);
    Canvas.Brush.Color:=fPipe;
    Canvas.RoundRect(Width div 2-fPipeWidth div 2,Height div 2+PipeBegin,
                     Width div 2+fPipeWidth div 2,Height div 2+PipeEnd,
                     fPipeWidth div 2,fPipeHeight div 2);
    Canvas.Brush.Color:=fLever;
    Canvas.Ellipse(Width div 2-fLeverWidth div 2,Height div 2+LeverBegin,
                   Width div 2+fLeverWidth div 2,Height div 2+LeverEnd);
  end;
  if fOrientation=udHorizontal then
  begin
    Canvas.Brush.Color:=fFront;
    Canvas.Pen.Style:=psSolid;
    Canvas.Pen.Color:=fScrew;
    Canvas.Pen.Width:=fScrewSize;
    Canvas.Ellipse(Width div 2-Height div 2+ScrewSize div 2,ScrewSize div 2,
                   Width div 2+Height div 2-ScrewSize div 2,Height-ScrewSize div 2);
    Canvas.Pen.Style:=psClear;
    Canvas.Brush.Color:=fInterior;
    Canvas.Ellipse(Width div 2-Height div 2+fScrewSize*5 div 4,Height div 2-fPipeWidth*6 div 10,
                   Width div 2+Height div 2-fScrewSize*5 div 4,Height div 2+fPipeWidth*6 div 10);
    Canvas.Brush.Color:=fPipe;
    Canvas.RoundRect(Width div 2+PipeBegin,Height div 2-fPipeWidth div 2,
                     Width div 2+PipeEnd,Height div 2+fPipeWidth div 2,
                     fPipeHeight div 2,fPipeWidth div 2);
    Canvas.Brush.Color:=fLever;
    Canvas.Ellipse(Width div 2+LeverBegin,Height div 2-fLeverWidth div 2,
                   Width div 2+LeverEnd,Height div 2+fLeverWidth div 2);
  end;
  Canvas.Pen.Color:=clWindowFrame;
  Canvas.Brush.Color:=clBtnFace;
  if Self.Focused then Canvas.DrawFocusRect(ClientRect);
end;

procedure TLeverSwitch.SetLeverColor(Value:TColor);
begin
  fLever:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetPipeColor(Value:TColor);
begin
  fPipe:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetInteriorColor(Value:TColor);
begin
  fInterior:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetFrontColor(Value:TColor);
begin
  fFront:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetScrewColor(Value:TColor);
begin
  fScrew:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetLeverHeight(Value:Integer);
begin
  fLeverHeight:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetLeverWidth(Value:Integer);
begin
  fLeverWidth:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetPipeHeight(Value:Integer);
begin
  fPipeHeight:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetPipeWidth(Value:Integer);
begin
  fPipeWidth:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetScrewSize(Value:Integer);
begin
  fScrewSize:=Value;
  Invalidate;
end;

procedure TLeverSwitch.SetSwitchState(Value:Boolean);
begin
  inherited SetSwitchState(Value);
end;

procedure TLeverSwitch.Resize;
begin
  if not Rotating then
  begin
    if fOrientation=udVertical then
    begin
      LeverWidth:=LeverWidth*Width div fOldWidth;
      LeverHeight:=LeverHeight*Height div fOldHeight;
      PipeWidth:=PipeWidth*Width div fOldWidth;
      PipeHeight:=PipeHeight*Height div fOldHeight;
      fScrewSize:=fScrewSize*Width div fOldWidth;
    end else begin
      LeverWidth:=LeverWidth*Height div fOldHeight;
      LeverHeight:=LeverHeight*Width div fOldWidth;
      PipeWidth:=PipeWidth*Height div fOldHeight;
      PipeHeight:=PipeHeight*Width div fOldWidth;
      fScrewSize:=fScrewSize*Height div fOldHeight;
    end;
    Invalidate;
  end;
end;

constructor TPushPullSwitch.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBottomColor:=$FF9F9F;
  fTopColor:=clBlue;
  fTopSideColor:=$FFDDDD;
  fBottomSideColor:=$550000;
  fSideColor:=clGray;
  fBoardColor:=clWhite;
  fPushHeight:=5;
  fPullHeight:=12;
  fBoardWidth:=4;
  fTopWidth:=2;
  fBottomWidth:=0;
  SetBounds(0,0,20+fPullHeight+fBoardWidth div 2,60+fBoardWidth)
end;

procedure TPushPullSwitch.Paint;
var x1,y1,x2,y2,xx1,xx2,r,g,b:integer;
    alfa,Beta:real;
    xBottomColor,xTopColor:TColor;
begin
  xTopColor:=RGB(GetRValue(TopColor)*(fSteps*3-SwitchPosition) div fSteps div 4,
                 GetGValue(TopColor)*(fSteps*3-SwitchPosition) div fSteps div 4,
                 GetBValue(TopColor)*(fSteps*3-SwitchPosition) div fSteps div 4);
  r:=GetRValue(BottomColor)*(fSteps-SwitchPosition) div fSteps div 2
     +GetRValue(TopColor)*(fSteps+SwitchPosition) div fSteps div 2;
  g:=GetGValue(BottomColor)*(fSteps-SwitchPosition) div fSteps div 2
     +GetGValue(TopColor)*(fSteps+SwitchPosition) div fSteps div 2;
  b:=GetBValue(BottomColor)*(fSteps-SwitchPosition) div fSteps div 2
     +GetBValue(TopColor)*(fSteps+SwitchPosition) div fSteps div 2;
  if r>255 then r:=255;
  if g>255 then g:=255;
  if b>255 then b:=255;
  xBottomColor:=RGB(r,g,b);
  with Canvas do
  begin
    Pen.Width:=fBoardWidth;
    Pen.Style:=psSolid;
    Pen.Color:=fBoardColor;
    Brush.Style:=bsClear;
  end;
  if fOrientation=udVertical then if fPullHeight>=0 then
  begin
    alfa:=fPullHeight/(Height div 2-fBottomWidth-fBoardWidth);
    if alfa<-1 then alfa:=-1;
    if alfa>1 then alfa:=1;
    beta:=fPullHeight/(Height div 2-fTopWidth-fBoardWidth);
    if beta<-1 then beta:=-1;
    if beta>1 then beta:=1;
    beta:=ArcSin(Beta)*(1-(fSteps-SwitchPosition)/fSteps/2);
    alfa:=ArcSin(alfa)*(fSteps-SwitchPosition)/fSteps/2;
    x1:=round((Height div 2-fBottomWidth-fBoardWidth)*sin(alfa));
    y1:=round((Height div 2-fBottomWidth-fBoardWidth)*cos(2*alfa));
    x2:=round((Height div 2-fTopWidth-fBoardWidth)*sin(beta));
    y2:=round((Height div 2-fTopWidth-fBoardWidth)*cos(2*beta));
    xx1:=Width-fBoardWidth-fPushHeight-x1;
    xx2:=Width-fBoardWidth-fPushHeight-x2;
    if fBoardWidth<>0 then
      Canvas.Rectangle(fBoardWidth div 2+PullHeight+PushHeight,fBoardWidth div 2,Width-fBoardWidth div 2,Height-fBoardWidth div 2);
    Canvas.Pen.Style:=psClear;
    Canvas.Brush.Color:=fSideColor;
    Canvas.Brush.Style:=bsSolid;

    Canvas.Polygon([Point(Width-fBoardWidth,fBoardWidth),
                    Point(Width-fBoardWidth,Height-fBoardWidth),
                    Point(xx1,Height div 2+y1),
                    Point(Width-fBoardWidth-fPushHeight,Height div 2),
                    Point(xx2,Height div 2-y2)]);
    Canvas.Brush.Color:=xBottomColor;
    Canvas.Polygon([Point(fPullHeight,Height div 2),
                    Point(Width-fBoardWidth-fPushHeight,Height div 2),
                    Point(xx1,Height div 2+y1),
                    Point(fPullHeight-x1,Height div 2+y1)]);
    Canvas.Brush.Color:=xTopColor;
    Canvas.Polygon([Point(fPullHeight,Height div 2),
                    Point(Width-fBoardWidth-fPushHeight,Height div 2),
                    Point(xx2,Height div 2-y2),
                    Point(fPullHeight-x2,Height div 2-y2)]);
    Canvas.Brush.Color:=TopSideColor;
    Canvas.Polygon([Point(fBoardWidth+fPullHeight+fPushHeight,fBoardWidth),
                    Point(Width-fBoardWidth,fBoardWidth),
                    Point(xx2,Height div 2-y2),
                    Point(fPullHeight-x2,Height div 2-y2)]);
    Canvas.Brush.Color:=BottomSideColor;
    Canvas.Polygon([Point(fBoardWidth+fPullHeight+fPushHeight,Height-fBoardWidth),
                    Point(Width-fBoardWidth,Height-fBoardWidth),
                    Point(xx1,Height div 2+y1),
                    Point(fPullHeight-x1,Height div 2+y1)]);
  end else begin
    alfa:=fPullHeight/(Height div 2-fBottomWidth-fBoardWidth);
    if alfa<-1 then alfa:=-1;
    if alfa>1 then alfa:=1;
    beta:=fPullHeight/(Height div 2-fTopWidth-fBoardWidth);
    if beta<-1 then beta:=-1;
    if beta>1 then beta:=1;
    beta:=-ArcSin(Beta)*(1-(fSteps-SwitchPosition)/fSteps/2);
    alfa:=-ArcSin(Alfa)*(fSteps-SwitchPosition)/fSteps/2;
    x1:=round((Height div 2-fBottomWidth-fBoardWidth)*sin(alfa));
    y1:=round((Height div 2-fBottomWidth-fBoardWidth)*cos(2*alfa));
    x2:=round((Height div 2-fTopWidth-fBoardWidth)*sin(beta));
    y2:=round((Height div 2-fTopWidth-fBoardWidth)*cos(2*beta));
    xx1:=fBoardWidth+fPushHeight+x1;
    xx2:=fBoardWidth+fPushHeight+x2;
    if fBoardWidth<>0 then
      Canvas.Rectangle(fBoardWidth div 2,fBoardWidth div 2,Width-fBoardWidth div 2+PullHeight-PushHeight,Height-fBoardWidth div 2);
    Canvas.Pen.Style:=psClear;
    Canvas.Brush.Color:=fSideColor;
    Canvas.Brush.Style:=bsSolid;

    Canvas.Polygon([Point(fBoardWidth,fBoardWidth),
                    Point(fBoardWidth,Height-fBoardWidth),
                    Point(xx1,Height div 2+y1),
                    Point(fBoardWidth+fPushHeight,Height div 2),
                    Point(xx2,Height div 2-y2)]);
    Canvas.Brush.Color:=xBottomColor;
    Canvas.Polygon([Point(Width+fPullHeight,Height div 2),
                    Point(fBoardWidth+fPushHeight,Height div 2),
                    Point(xx1,Height div 2+y1),
                    Point(Width+fPullHeight+x1,Height div 2+y1)]);
    Canvas.Brush.Color:=xTopColor;
    Canvas.Polygon([Point(Width+fPullHeight,Height div 2),
                    Point(fBoardWidth+fPushHeight,Height div 2),
                    Point(xx2,Height div 2-y2),
                    Point(Width+fPullHeight+x2,Height div 2-y2)]);
    Canvas.Brush.Color:=TopSideColor;
    Canvas.Polygon([Point(Width-fBoardWidth+fPullHeight-PushHeight,fBoardWidth),
                    Point(fBoardWidth,fBoardWidth),
                    Point(xx2,Height div 2-y2),
                    Point(Width+fPullHeight+x2,Height div 2-y2)]);
    Canvas.Brush.Color:=BottomSideColor;
    Canvas.Polygon([Point(Width-fBoardWidth+fPullHeight-fPushHeight,Height-fBoardWidth),
                    Point(fBoardWidth,Height-fBoardWidth),
                    Point(xx1,Height div 2+y1),
                    Point(Width+fPullHeight+x1,Height div 2+y1)]);
  end;
  if fOrientation=udHorizontal then if fPullHeight>=0 then
  begin
    alfa:=fPullHeight/(Width div 2-fBottomWidth-fBoardWidth);
    if alfa<-1 then alfa:=-1;
    if alfa>1 then alfa:=1;
    beta:=fPullHeight/(Width div 2-fTopWidth-fBoardWidth);
    if beta<-1 then beta:=-1;
    if beta>1 then beta:=1;
    beta:=ArcSin(Beta)*(1-(fSteps-SwitchPosition)/fSteps/2);
    alfa:=ArcSin(Alfa)*(fSteps-SwitchPosition)/fSteps/2;
    x1:=round((Width div 2-fBottomWidth-fBoardWidth)*sin(alfa));
    y1:=round((Width div 2-fBottomWidth-fBoardWidth)*cos(2*alfa));
    x2:=round((Width div 2-fTopWidth-fBoardWidth)*sin(beta));
    y2:=round((Width div 2-fTopWidth-fBoardWidth)*cos(2*beta));
    xx1:=Height-fBoardWidth-fPushHeight-x1;
    xx2:=Height-fBoardWidth-fPushHeight-x2;
    if fBoardWidth<>0 then
      Canvas.Rectangle(fBoardWidth div 2,fBoardWidth div 2+PullHeight+PushHeight,Width-fBoardWidth div 2,Height-fBoardWidth div 2);
    Canvas.Pen.Style:=psClear;
    Canvas.Brush.Color:=fSideColor;
    Canvas.Brush.Style:=bsSolid;

    Canvas.Polygon([Point(fBoardWidth,Height-fBoardWidth),
                    Point(Width-fBoardWidth,Height-fBoardWidth),
                    Point(Width div 2+y1,xx1),
                    Point(Width div 2,Height-fBoardWidth-fPushHeight),
                    Point(Width div 2-y2,xx2)]);
    Canvas.Brush.Color:=xBottomColor;
    Canvas.Polygon([Point(Width div 2,fPullHeight),
                    Point(Width div 2,Height-fBoardWidth-fPushHeight),
                    Point(Width div 2+y1,xx1),
                    Point(Width div 2+y1,fPullHeight-x1)]);
    Canvas.Brush.Color:=xTopColor;
    Canvas.Polygon([Point(Width div 2,fPullHeight),
                    Point(Width div 2,Height-fBoardWidth-fPushHeight),
                    Point(Width div 2-y2,xx2),
                    Point(Width div 2-y2,fPullHeight-x2)]);
    Canvas.Brush.Color:=TopSideColor;
    Canvas.Polygon([Point(fBoardWidth,fBoardWidth+fPullHeight+fPushHeight),
                    Point(fBoardWidth,Height-fBoardWidth),
                    Point(Width div 2-y2,xx2),
                    Point(Width div 2-y2,fPullHeight-x2)]);
    Canvas.Brush.Color:=BottomSideColor;
    Canvas.Polygon([Point(Width-fBoardWidth,fBoardWidth+fPullHeight+fPushHeight),
                    Point(Width-fBoardWidth,Height-fBoardWidth),
                    Point(Width div 2+y1,xx1),
                    Point(Width div 2+y1,fPullHeight-x1)]);
  end else begin
    alfa:=fPullHeight/(Width div 2-fBottomWidth-fBoardWidth);
    if alfa<-1 then alfa:=-1;
    if alfa>1 then alfa:=1;
    beta:=fPullHeight/(Width div 2-fTopWidth-fBoardWidth);
    if beta<-1 then beta:=-1;
    if beta>1 then beta:=1;
    beta:=-ArcSin(Beta)*(1-(fSteps-SwitchPosition)/fSteps/2);
    alfa:=-ArcSin(Alfa)*(fSteps-SwitchPosition)/fSteps/2;
    x1:=round((Width div 2-fBottomWidth-fBoardWidth)*sin(alfa));
    y1:=round((Width div 2-fBottomWidth-fBoardWidth)*cos(2*alfa));
    x2:=round((Width div 2-fTopWidth-fBoardWidth)*sin(beta));
    y2:=round((Width div 2-fTopWidth-fBoardWidth)*cos(2*beta));
    xx1:=fBoardWidth+fPushHeight+x1;
    xx2:=fBoardWidth+fPushHeight+x2;
    if fBoardWidth<>0 then
      Canvas.Rectangle(fBoardWidth div 2,fBoardWidth div 2,Width-fBoardWidth div 2,Height-fBoardWidth div 2+PullHeight-PushHeight);
    Canvas.Pen.Style:=psClear;
    Canvas.Brush.Color:=fSideColor;
    Canvas.Brush.Style:=bsSolid;

    Canvas.Polygon([Point(fBoardWidth,fBoardWidth),
                    Point(Width-fBoardWidth,fBoardWidth),
                    Point(Width div 2+y1,xx1),
                    Point(Width div 2,fBoardWidth+fPushHeight),
                    Point(Width div 2-y2,xx2)]);
    Canvas.Brush.Color:=xBottomColor;
    Canvas.Polygon([Point(Width div 2,Height+fPullHeight),
                    Point(Width div 2,fBoardWidth+fPushHeight),
                    Point(Width div 2+y1,xx1),
                    Point(Width div 2+y1,Height+fPullHeight+x1)]);
    Canvas.Brush.Color:=xTopColor;
    Canvas.Polygon([Point(Width div 2,Height+fPullHeight),
                    Point(Width div 2,fBoardWidth+fPushHeight),
                    Point(Width div 2-y2,xx2),
                    Point(Width div 2-y2,Height+fPullHeight+x2)]);
    Canvas.Brush.Color:=TopSideColor;
    Canvas.Polygon([Point(fBoardWidth,Height-fBoardWidth+fPullHeight-PushHeight),
                    Point(fBoardWidth,fBoardWidth),
                    Point(Width div 2-y2,xx2),
                    Point(Width div 2-y2,Height+fPullHeight+x2)]);
    Canvas.Brush.Color:=BottomSideColor;
    Canvas.Polygon([Point(Width-fBoardWidth,Height-fBoardWidth+fPullHeight-fPushHeight),
                    Point(Width-fBoardWidth,fBoardWidth),
                    Point(Width div 2+y1,xx1),
                    Point(Width div 2+y1,Height+fPullHeight+x1)]);
  end;
end;

procedure TPushPullSwitch.SetTopColor(Value:TColor);
begin
  fTopColor:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetBottomColor(Value:TColor);
begin
  fBottomColor:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetSideColor(Value:TColor);
begin
  fSideColor:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetTopSideColor(Value:TColor);
begin
  fTopSideColor:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetBottomSideColor(Value:TColor);
begin
  fBottomSideColor:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetBoardColor(Value:TColor);
begin
  fBoardColor:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetPushHeight(Value:Integer);
begin
  fPushHeight:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetPullHeight(Value:Integer);
begin
  fPullHeight:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetBoardWidth(Value:Integer);
begin
  fBoardWidth:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetTopWidth(Value:Integer);
begin
  fTopWidth:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetBottomWidth(Value:Integer);
begin
  fBottomWidth:=Value;
  Invalidate;
end;

procedure TPushPullSwitch.SetSwitchState(Value:Boolean);
begin
  inherited SetSwitchState(Value);
end;

initialization
  {$I Switches.lrs}
end.
