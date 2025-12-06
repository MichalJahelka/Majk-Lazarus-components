unit Edits;

{ Visual Lazarus components

  MIT license

  Created by Michal Jahelka at vsb.cz

  TRangeEdit - Edit with numeric checking, coloring and conversion  
  TFloatRangeEdit - Edit with float checking, coloring and conversion

  TRangeInput - Edit with caption and numeric checking, coloring and conversion
  TFloatRangeInput - Edit with caption and float checking, coloring and conversion }

{$mode objfpc}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, LCLType;

type

  { TRangeEdit }

  TRangeEdit = class(TEdit)
  private
    { Private declarations }
    fMaxRange,fMinRange:integer;
    fNormalColor,fErrColor,fRangeColor:TColor;
    fIsHex:boolean;
    fCreating:boolean;
    fHexDigits:integer;
    procedure SetMinRange(Value:integer);
    procedure SetMaxRange(Value:integer);
    procedure SetRangeColor(Value:TColor);
    procedure SetNormalColor(Value:TColor);
    procedure SetErrColor(Value:TColor);
    function GetValue:integer;
    procedure SetValue(Value:integer);
    procedure SetHex(Value:boolean);
    function OKTest:boolean;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    procedure Change; override;
    procedure UpdateState;
  published
    { Published declarations }
    property OnChange;
    property MinRange:integer read fMinRange write SetMinRange;
    property MaxRange:integer read fMaxRange write SetMaxRange;
    property RangeColor:TColor read fRangeColor write SetRangeColor;
    property NormalColor:TColor read fNormalColor write SetNormalColor;
    property ErrColor:TColor read fErrColor write SetErrColor;
    property Value:integer read GetValue write SetValue;
    property IsHex:boolean read fIsHex write SetHex;
    property HexDigits:integer read fHexDigits write fHexDigits;
    property IsOK:boolean read OKTest;
  end;

  { TFloatRangeEdit }

  TFloatRangeEdit = class(TEdit)
  private
    { Private declarations }
    fMaxRange,fMinRange:real;
    fDecimals:integer;
    fNormalColor,fErrColor,fRangeColor:TColor;
    fCreating:boolean;
    procedure SetMinRange(Value:real);
    procedure SetMaxRange(Value:real);
    procedure SetRangeColor(Value:TColor);
    procedure SetNormalColor(Value:TColor);
    procedure SetErrColor(Value:TColor);
    function GetValue:real;
    procedure SetValue(Value:real);
    function GetIValue:Integer;
    procedure SetIValue(Value:Integer);
    function OKTest:boolean;
    procedure SetDecimals(Value:Integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    procedure Change; override;
    procedure UpdateState;
  published
    { Published declarations }
    property OnChange;
    property Decimals:integer read fDecimals write SetDecimals;
    property MinRange:real read fMinRange write SetMinRange;
    property MaxRange:real read fMaxRange write SetMaxRange;
    property RangeColor:TColor read fRangeColor write SetRangeColor;
    property NormalColor:TColor read fNormalColor write SetNormalColor;
    property ErrColor:TColor read fErrColor write SetErrColor;
    property Value:real read GetValue write SetValue;
    property IntValue:integer read GetIValue write SetIValue;
    property IsOK:boolean read OKTest;
  end;

  { TRangeInput }
  // TRangeEdit+Caption pro snadnější zarovnávání
  TRangeInput=class(TCustomControl)
  private
    fLabel:TLabel;
    fEdit:TRangeEdit;
    fLabelSpacing:integer;
    fEditWidth:integer;
    fLabelPosition: TLabelPosition;
    function GetCaption: TCaption;
    function GetErrColor: TColor;
    function GetHexDigits: integer;
    function GetHint:TTranslateString;
    function GetIsHex: boolean;
    function GetMaxRange: integer;
    function GetMinRange: integer;
    function GetNormalColor: TColor;
    function GetOKTest: boolean;
    function GetRangeColor: TColor;
    function GetShowHint: Boolean;
    function GetText: TCaption;
    function GetValue: integer;
    procedure SetCaption(AValue: TCaption);
    procedure SetErrColor(AValue: TColor);
    procedure SetHex(AValue: boolean);
    procedure SetHexDigits(AValue: integer);
    procedure SetLabelPosition(AValue: TLabelPosition);
    procedure SetLabelSpacing(AValue: Integer);
    procedure SetEditWidth(AValue: Integer);
    procedure SetMaxRange(AValue: integer);
    procedure SetMinRange(AValue: integer);
    procedure SetNormalColor(AValue: TColor);
    procedure SetRangeColor(AValue: TColor);
    procedure SetShowHint(AValue: Boolean);
    procedure SetText(AValue: TCaption);
    procedure SetValue(AValue: integer);
  protected
    { Protected declarations }
    procedure SetParent(AParent: TWinControl); override;
    procedure Loaded; override;
    procedure DoPositionLabel; virtual;
    procedure SetName(const Value: TComponentName); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    procedure Resize; override;
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    procedure SetHint(const AValue: TTranslateString); override;
  published
    { Published declarations }
    property Caption:TCaption read GetCaption write SetCaption;
    property EmbeddedLabel:TLabel read fLabel;
    property EmbeddedEdit:TRangeEdit read fEdit;
    property LabelPosition:TLabelPosition read fLabelPosition write SetLabelPosition;
    property LabelSpacing:Integer read fLabelSpacing write SetLabelSpacing default 2;
    property EditWidth:Integer read fEditWidth write SetEditWidth default 100;
    property MinRange:integer read GetMinRange write SetMinRange;
    property MaxRange:integer read GetMaxRange write SetMaxRange;
    property RangeColor:TColor read GetRangeColor write SetRangeColor;
    property NormalColor:TColor read GetNormalColor write SetNormalColor;
    property ErrColor:TColor read GetErrColor write SetErrColor;
    property Value:integer read GetValue write SetValue;
    property IsHex:boolean read GetIsHex write SetHex;
    property HexDigits:integer read GetHexDigits write SetHexDigits;
    property IsOK:boolean read GetOKTest;
    property Text:TCaption read GetText write SetText;
    property ShowHint:Boolean read GetShowHint write SetShowHint;
    property Hint:TTranslateString read GetHint write SetHint;
    property Anchors;
    property AutoSize;
    property BorderSpacing;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

  { TFloatRangeInput }
  // TFloatRangeEdit+Caption pro snadnější zarovnávání
  TFloatRangeInput=class(TCustomControl)
  private
    fLabel:TLabel;
    fEdit:TFloatRangeEdit;
    fLabelSpacing:integer;
    fEditWidth:integer;
    fLabelPosition: TLabelPosition;
    function GetCaption: TCaption;
    function GetDecimals: integer;
    function GetErrColor: TColor;
    function GetHint: TTranslateString;
    function GetIValue: integer;
    function GetMaxRange: real;
    function GetMinRange: real;
    function GetNormalColor: TColor;
    function GetOKTest: boolean;
    function GetRangeColor: TColor;
    function GetShowHint: Boolean;
    function GetText: TCaption;
    function GetValue: real;
    procedure SetCaption(AValue: TCaption);
    procedure SetDecimals(AValue: integer);
    procedure SetEditWidth(AValue: Integer);
    procedure SetErrColor(AValue: TColor);
    procedure SetIValue(AValue: integer);
    procedure SetLabelPosition(AValue: TLabelPosition);
    procedure SetLabelSpacing(AValue: Integer);
    procedure SetMaxRange(AValue: real);
    procedure SetMinRange(AValue: real);
    procedure SetNormalColor(AValue: TColor);
    procedure SetRangeColor(AValue: TColor);
    procedure SetShowHint(AValue: Boolean);
    procedure SetText(AValue: TCaption);
    procedure SetValue(AValue: real);
  protected
    { Protected declarations }
    procedure SetParent(AParent: TWinControl); override;
    procedure Loaded; override;
    procedure DoPositionLabel; virtual;
    procedure SetName(const Value: TComponentName); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: integer); override;
    procedure Resize; override;
  public
    { Public declarations }
    constructor Create(TheOwner: TComponent); override;
    procedure SetHint(const AValue: TTranslateString); override;
  published
    { Published declarations }
    property Caption:TCaption read GetCaption write SetCaption;
    property EmbeddedLabel:TLabel read fLabel;
    property EmbeddedEdit:TFloatRangeEdit read fEdit;
    property LabelPosition:TLabelPosition read fLabelPosition write SetLabelPosition;
    property LabelSpacing:Integer read fLabelSpacing write SetLabelSpacing default 2;
    property EditWidth:Integer read fEditWidth write SetEditWidth default 100;
    property Decimals:integer read GetDecimals write SetDecimals;
    property MinRange:real read GetMinRange write SetMinRange;
    property MaxRange:real read GetMaxRange write SetMaxRange;
    property RangeColor:TColor read GetRangeColor write SetRangeColor;
    property NormalColor:TColor read GetNormalColor write SetNormalColor;
    property ErrColor:TColor read GetErrColor write SetErrColor;
    property Value:real read GetValue write SetValue;
    property IntValue:integer read GetIValue write SetIValue;
    property IsOK:boolean read GetOKTest;
    property Text:TCaption read GetText write SetText;
    property ShowHint:Boolean read GetShowHint write SetShowHint;
    property Hint:TTranslateString read GetHint write SetHint;
    property Anchors;
    property AutoSize;
    property BorderSpacing;
    property Enabled;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  end;

procedure Register;

implementation

uses strutils,math;

procedure Register;
begin
  {$I Edits_icon.lrs}
  RegisterComponents('Majk',[TRangeEdit]);
  RegisterComponents('Majk',[TFloatRangeEdit]);
  RegisterComponents('Majk',[TRangeInput]);
  RegisterComponents('Majk',[TFloatRangeInput]);
end;

{ TFloatRangeInput }

function TFloatRangeInput.GetCaption: TCaption;
begin
  Result:=fLabel.Caption;
end;

function TFloatRangeInput.GetDecimals: integer;
begin
  Result:=fEdit.Decimals;
end;

function TFloatRangeInput.GetErrColor: TColor;
begin
  Result:=fEdit.ErrColor;
end;

function TFloatRangeInput.GetHint: TTranslateString;
begin
  Result:=fLabel.Hint;
end;

function TFloatRangeInput.GetIValue: integer;
begin
  Result:=fEdit.GetIValue;
end;

function TFloatRangeInput.GetMaxRange: real;
begin
  Result:=fEdit.MaxRange;
end;

function TFloatRangeInput.GetMinRange: real;
begin
  Result:=fEdit.MinRange;
end;

function TFloatRangeInput.GetNormalColor: TColor;
begin
  Result:=fEdit.NormalColor;
end;

function TFloatRangeInput.GetOKTest: boolean;
begin
  Result:=fEdit.OKTest;
end;

function TFloatRangeInput.GetRangeColor: TColor;
begin
  Result:=fEdit.RangeColor;
end;

function TFloatRangeInput.GetShowHint: Boolean;
begin
  Result:=fLabel.ShowHint;
end;

function TFloatRangeInput.GetText: TCaption;
begin
  Result:=fEdit.Text;
end;

function TFloatRangeInput.GetValue: real;
begin
  Result:=fEdit.Value;
end;

procedure TFloatRangeInput.SetCaption(AValue: TCaption);
begin
  fLabel.Caption:=AValue;
end;

procedure TFloatRangeInput.SetDecimals(AValue: integer);
begin
  fEdit.Decimals:=AValue;
end;

procedure TFloatRangeInput.SetEditWidth(AValue: Integer);
begin
  if fEditWidth=AValue then Exit;
  fEditWidth:=AValue;
  DoPositionLabel;
end;

procedure TFloatRangeInput.SetErrColor(AValue: TColor);
begin
  fEdit.ErrColor:=AValue;
end;

procedure TFloatRangeInput.SetIValue(AValue: integer);
begin
  fEdit.IntValue:=AValue;
end;

procedure TFloatRangeInput.SetLabelPosition(AValue: TLabelPosition);
begin
  if fLabelPosition=AValue then Exit;
  fLabelPosition:=AValue;
  DoPositionLabel;
end;

procedure TFloatRangeInput.SetLabelSpacing(AValue: Integer);
begin
  if fLabelSpacing=AValue then Exit;
  fLabelSpacing:=AValue;
  DoPositionLabel;
end;

procedure TFloatRangeInput.SetMaxRange(AValue: real);
begin
  fEdit.MaxRange:=AValue;
end;

procedure TFloatRangeInput.SetMinRange(AValue: real);
begin
  fEdit.MinRange:=AValue;
end;

procedure TFloatRangeInput.SetNormalColor(AValue: TColor);
begin
  fEdit.NormalColor:=AValue;
end;

procedure TFloatRangeInput.SetRangeColor(AValue: TColor);
begin
  fEdit.RangeColor:=AValue;
end;

procedure TFloatRangeInput.SetShowHint(AValue: Boolean);
begin
  fLabel.ShowHint:=AValue;
end;

procedure TFloatRangeInput.SetText(AValue: TCaption);
begin
  fEdit.Text:=AValue;
end;

procedure TFloatRangeInput.SetValue(AValue: real);
begin
  fEdit.Value:=AValue;
end;

procedure TFloatRangeInput.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  DoPositionLabel;
end;

procedure TFloatRangeInput.Loaded;
begin
  inherited Loaded;
  DoPositionLabel;
end;

procedure TFloatRangeInput.DoPositionLabel;
begin
  if (fLabel=nil)or(fEdit=nil) then exit;
  fLabel.Anchors:=[];
  fEdit.Anchors:=[];
  case FLabelPosition of
    lpAbove:
    begin
      fLabel.AnchorParallel(akLeft,0,Self);
      fLabel.AnchorParallel(akTop,0,Self);
      fLabel.AnchorSideRight.Control:=Self;
      fEdit.AnchorParallel(akLeft,0,fLabel);
      fEdit.AnchorToCompanion(akTop,fLabelSpacing,fLabel);
      fEdit.AnchorSideRight.Control:=Self;
      {$IFDEF Windows}
        Height:=fEdit.Height;
      {$ELSE}
        Height:=fEdit.Top+fEdit.Height;
      {$ENDIF}
    end;
    lpBelow:
    begin
      fEdit.AnchorParallel(akLeft,0,Self);
      fEdit.AnchorParallel(akTop,0,Self);
      fEdit.AnchorSideRight.Control:=Self;
      fLabel.AnchorParallel(akLeft,0,fEdit);
      fLabel.AnchorToCompanion(akTop,fLabelSpacing,fEdit);
      fLabel.AnchorSideRight.Control:=Self;
      {$IFDEF Windows}
        Height:=fEdit.Height;
      {$ELSE}
        Height:=fLabel.Top+fLabel.Height;
      {$ENDIF}
    end;
    lpLeft:
    begin
      fLabel.AnchorParallel(akLeft,0,Self);
      fEdit.AnchorParallel(akRight,0,Self);
      fEdit.Width:=fEditWidth;
      fLabel.AnchorVerticalCenterTo(fEdit);
    end;
    lpRight:
    begin
      fEdit.AnchorParallel(akLeft,0,Self);
      fEdit.AnchorParallel(akTop,0,Self);
      fEdit.Width:=fEditWidth;
      fLabel.AnchorToNeighbour(akLeft,fLabelSpacing,fEdit);
      fLabel.AnchorVerticalCenterTo(fEdit);
    end;
  end;
end;

procedure TFloatRangeInput.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState)and((fLabel.Caption='')or(not AnsiSameText(flabel.Caption, Name))) then
  begin
    fLabel.Caption := Value;
    DoPositionLabel;
  end;
  inherited SetName(Value);
end;

procedure TFloatRangeInput.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
begin
  if (csDesigning in ComponentState)and(fEdit<>nil)and(fLabel<>nil) then
  begin
    case FLabelPosition of
      lpAbove:AHeight:=fEdit.Top+fEdit.Height;
      lpBelow:AHeight:=fLabel.Top+fLabel.Height;
      lpLeft,lpRight:
      begin
        AHeight:=flabel.Height;
        if fEdit.Height>AHeight then AHeight:=fEdit.Height;
      end;
    end;
  end;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TFloatRangeInput.Resize;
begin
  inherited Resize;
  if csDesigning in ComponentState then exit;
  case FLabelPosition of
    lpAbove,lpBelow:Height:=fLabel.Height+fLabelSpacing+fEdit.Height;
  end;
end;

constructor TFloatRangeInput.Create(TheOwner: TComponent);
var RI:TFloatRangeInput;
begin
  RI:=(inherited Create(TheOwner)) as TFloatRangeInput;
  // Set default width and height
  with GetControlClassDefaultSize do SetInitialBounds(0, 0, CX, CY);
  fLabelSpacing:=2;
  fEditWidth:=100;
  fLabelPosition:=lpAbove;
  fLabel:=TLabel.Create(RI);
  fLabel.SetSubComponent(true);
  fLabel.ControlStyle:=fLabel.ControlStyle + [csNoDesignSelectable];
  fLabel.Caption:=Name;
  fLabel.Parent:=RI;
  fEdit:=TFloatRangeEdit.Create(RI);
  fEdit.SetSubComponent(true);
  fEdit.ControlStyle:=fLabel.ControlStyle + [csNoDesignSelectable];
  fEdit.Parent:=RI;
end;

procedure TFloatRangeInput.SetHint(const AValue: TTranslateString);
begin
  fLabel.Hint:=Avalue;
end;

{ TRangeInput }

function TRangeInput.GetCaption: TCaption;
begin
  Result:=fLabel.Caption;
end;

function TRangeInput.GetErrColor: TColor;
begin
  Result:=fEdit.ErrColor;
end;

function TRangeInput.GetHexDigits: integer;
begin
  Result:=fEdit.HexDigits;
end;

function TRangeInput.GetHint: TTranslateString;
begin
  Result:=fLabel.Hint;
end;

function TRangeInput.GetIsHex: boolean;
begin
  Result:=fEdit.IsHex;
end;

function TRangeInput.GetMaxRange: integer;
begin
  Result:=fEdit.MaxRange;
end;

function TRangeInput.GetMinRange: integer;
begin
  Result:=fEdit.MinRange;
end;

function TRangeInput.GetNormalColor: TColor;
begin
  Result:=fEdit.NormalColor;
end;

function TRangeInput.GetOKTest: boolean;
begin
  Result:=fEdit.OKTest;
end;

function TRangeInput.GetRangeColor: TColor;
begin
  Result:=fEdit.RangeColor;
end;

function TRangeInput.GetShowHint: Boolean;
begin
  Result:=fLabel.ShowHint;
end;

function TRangeInput.GetText: TCaption;
begin
  Result:=fEdit.Text;
end;

function TRangeInput.GetValue: integer;
begin
  Result:=fEdit.Value;
end;

procedure TRangeInput.SetCaption(AValue: TCaption);
begin
  fLabel.Caption:=AValue;
end;

procedure TRangeInput.SetErrColor(AValue: TColor);
begin
  fEdit.ErrColor:=AValue;
end;

procedure TRangeInput.SetHex(AValue: boolean);
begin
  fEdit.IsHex:=AValue;
end;

procedure TRangeInput.SetHexDigits(AValue: integer);
begin
  fEdit.HexDigits:=AValue;
end;

procedure TRangeInput.SetLabelPosition(AValue: TLabelPosition);
begin
  if fLabelPosition=AValue then Exit;
  fLabelPosition:=AValue;
  DoPositionLabel;
end;

procedure TRangeInput.SetLabelSpacing(AValue: Integer);
begin
  if fLabelSpacing=AValue then Exit;
  fLabelSpacing:=AValue;
  DoPositionLabel;
end;

procedure TRangeInput.SetEditWidth(AValue: Integer);
begin
  if fEditWidth=AValue then Exit;
  fEditWidth:=AValue;
  DoPositionLabel;
end;

procedure TRangeInput.SetHint(const AValue: TTranslateString);
begin
  fLabel.Hint:=Avalue;
end;

procedure TRangeInput.SetMaxRange(AValue: integer);
begin
  fEdit.MaxRange:=AValue;
end;

procedure TRangeInput.SetMinRange(AValue: integer);
begin
  fEdit.MinRange:=AValue;
end;

procedure TRangeInput.SetNormalColor(AValue: TColor);
begin
  fEdit.NormalColor:=AValue;
end;

procedure TRangeInput.SetRangeColor(AValue: TColor);
begin
  fEdit.RangeColor:=AValue;
end;

procedure TRangeInput.SetShowHint(AValue: Boolean);
begin
  fLabel.ShowHint:=AValue;
end;

procedure TRangeInput.SetText(AValue: TCaption);
begin
  fEdit.Text:=AValue;
end;

procedure TRangeInput.SetValue(AValue: integer);
begin
  fEdit.Value:=AValue;
end;

procedure TRangeInput.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  DoPositionLabel;
end;

procedure TRangeInput.Loaded;
begin
  inherited Loaded;
  DoPositionLabel;
end;

procedure TRangeInput.DoPositionLabel;
begin
  if (fLabel=nil)or(fEdit=nil) then exit;
  fLabel.Anchors:=[];
  fEdit.Anchors:=[];
  case FLabelPosition of
    lpAbove:
    begin
      fLabel.AnchorParallel(akLeft,0,Self);
      fLabel.AnchorParallel(akTop,0,Self);
      fLabel.AnchorSideRight.Control:=Self;
      fEdit.AnchorParallel(akLeft,0,fLabel);
      fEdit.AnchorToCompanion(akTop,fLabelSpacing,fLabel);
      fEdit.AnchorSideRight.Control:=Self;
      {$IFDEF Windows}
        Height:=fEdit.Height;
      {$ELSE}
        Height:=fEdit.Top+fEdit.Height;
      {$ENDIF}
    end;
    lpBelow:
    begin
      fEdit.AnchorParallel(akLeft,0,Self);
      fEdit.AnchorParallel(akTop,0,Self);
      fEdit.AnchorSideRight.Control:=Self;
      fLabel.AnchorParallel(akLeft,0,fEdit);
      fLabel.AnchorToCompanion(akTop,fLabelSpacing,fEdit);
      fLabel.AnchorSideRight.Control:=Self;
      {$IFDEF Windows}
        Height:=fEdit.Height;
      {$ELSE}
        Height:=fLabel.Top+fLabel.Height;
      {$ENDIF}
    end;
    lpLeft:
    begin
      fLabel.AnchorParallel(akLeft,0,Self);
      fEdit.AnchorParallel(akRight,0,Self);
      fEdit.Width:=fEditWidth;
      fLabel.AnchorVerticalCenterTo(fEdit);
    end;
    lpRight:
    begin
      fEdit.AnchorParallel(akLeft,0,Self);
      fEdit.AnchorParallel(akTop,0,Self);
      fEdit.Width:=fEditWidth;
      fLabel.AnchorToNeighbour(akLeft,fLabelSpacing,fEdit);
      fLabel.AnchorVerticalCenterTo(fEdit);
    end;
  end;
end;

procedure TRangeInput.SetName(const Value: TComponentName);
begin
  if (csDesigning in ComponentState)and((fLabel.Caption='')or(not AnsiSameText(flabel.Caption, Name))) then
  begin
    fLabel.Caption := Value;
    DoPositionLabel;
  end;
  inherited SetName(Value);
end;

procedure TRangeInput.SetBounds(ALeft, ATop, AWidth, AHeight: integer);
begin
  if (csDesigning in ComponentState)and(fEdit<>nil)and(fLabel<>nil) then
  begin
    case FLabelPosition of
      lpAbove:AHeight:=fEdit.Top+fEdit.Height;
      lpBelow:AHeight:=fLabel.Top+fLabel.Height;
      lpLeft,lpRight:
      begin
        AHeight:=fLabel.Height;
        if fEdit.Height>AHeight then AHeight:=fEdit.Height;
      end;
    end;
  end;
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
end;

procedure TRangeInput.Resize;
begin
  inherited Resize;
  if csDesigning in ComponentState then exit;
  case FLabelPosition of
    lpAbove,lpBelow:Height:=fLabel.Height+fLabelSpacing+fEdit.Height;
  end;
end;

constructor TRangeInput.Create(TheOwner: TComponent);
var RI:TRangeInput;
begin
  RI:=(inherited Create(TheOwner)) as TRangeInput;
  // Set default width and height
  with GetControlClassDefaultSize do SetInitialBounds(0, 0, CX, CY);
  fLabelSpacing:=2;
  fEditWidth:=100;
  fLabelPosition:=lpAbove;
  fLabel:=TLabel.Create(RI);
  fLabel.SetSubComponent(true);
  fLabel.ControlStyle:=fLabel.ControlStyle + [csNoDesignSelectable];
  fLabel.Caption:=Name;
  fLabel.Parent:=RI;
  fEdit:=TRangeEdit.Create(RI);
  fEdit.SetSubComponent(true);
  fEdit.ControlStyle:=fLabel.ControlStyle + [csNoDesignSelectable];
  fEdit.Parent:=RI;
end;

{ TRangeEdit }

constructor TRangeEdit.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  fMaxRange:=MaxInt;
  fMinRange:=-MaxInt;
  fNormalColor:=clDefault;
  fErrColor:=$B9B9FF;
  fRangeColor:=$88FFFF;
  fIsHex:=false;
  fCreating:=true;
  fHexDigits:=2;
end;

procedure TRangeEdit.Change;
begin
  UpdateState;
  inherited Change;
  fCreating:=false;
end;

procedure TRangeEdit.UpdateState;
var x,err:integer;
    s:string;
begin
  s:=DelSpace(Text);
  if fIsHex then s:='$'+s;
  val(s,x,err);
  if err<>0 then
  begin
    Color:=fErrColor;
    Exit;
  end;
  if(x<fMinRange)or(x>fMaxRange) then
  begin
    Color:=fRangeColor;
    Exit;
  end;
  Color:=fNormalColor;
end;

procedure TRangeEdit.SetMaxRange(Value: integer);
begin
  fMaxRange:=Value;
  UpdateState;
end;

procedure TRangeEdit.SetMinRange(Value: integer);
begin
  fMinRange:=Value;
  UpdateState;
end;

procedure TRangeEdit.SetNormalColor(Value: TColor);
begin
  fNormalColor:=Value;
  UpdateState;
end;

procedure TRangeEdit.SetErrColor(Value: TColor);
begin
  fErrColor:=Value;
  UpdateState;
end;

function TRangeEdit.GetValue: integer;
var x,err:integer;
    s:string;
begin
  s:=DelSpace(Text);
  if fIsHex then s:='$'+s;
  val(s,x,err);
  if err<>0 then x:=0;
  Result:=x;
end;

{procedure TRangeEdit.SetOnChange(AValue: TNotifyEvent);
begin
  if FOnChange=AValue then Exit;
  FOnChange:=AValue;
end;}

procedure TRangeEdit.SetValue(Value: integer);
begin
  if (csDesigning in ComponentState)and(fCreating) then exit;
  if fIsHex then Text:=IntToHex(Value,fHexDigits)
            else Text:=IntToStr(Value);
  UpdateState;
end;

procedure TRangeEdit.SetHex(Value: boolean);
begin
  fIsHex:=Value;
  UpdateState;
end;

function TRangeEdit.OKTest: boolean;
var x,err:integer;
    s:string;
begin
  s:=DelSpace(Text);
  if fIsHex then s:='$'+s;
  val(s,x,err);
  if(err<>0)or(x<fMinRange)or(x>fMaxRange) then Result:=false else Result:=true;
end;

procedure TRangeEdit.SetRangeColor(Value: TColor);
begin
  fRangeColor:=Value;
  UpdateState;
end;

{ TFloatRangeEdit }

procedure TFloatRangeEdit.SetMinRange(Value: real);
begin
  fMinRange:=Value;
  UpdateState;
end;

procedure TFloatRangeEdit.SetMaxRange(Value: real);
begin
  fMaxRange:=Value;
  UpdateState;
end;

procedure TFloatRangeEdit.SetRangeColor(Value: TColor);
begin
  fRangeColor:=Value;
  UpdateState;
end;

procedure TFloatRangeEdit.SetNormalColor(Value: TColor);
begin
  fNormalColor:=Value;
  UpdateState;
end;

procedure TFloatRangeEdit.SetErrColor(Value: TColor);
begin
  fErrColor:=Value;
  UpdateState;
end;

function TFloatRangeEdit.GetValue: real;
var re:real;
    err:integer;
    s:string;
begin
  s:=DelSpace(Text);
  val(s,re,err);
  if err<>0 then re:=0;
  Result:=re;
end;

procedure TFloatRangeEdit.SetValue(Value: real);
var s:string;
begin
  if (csDesigning in ComponentState)and(fCreating) then exit;
  str(Value:1:fDecimals,s);
  Text:=s;
  UpdateState;
end;

function TFloatRangeEdit.GetIValue: Integer;
var re:real;
    err:integer;
    s:string;
begin
  s:=DelSpace(Text);
  val(s,re,err);
  if err<>0 then re:=0;
  Result:=round(re*power(10,fDecimals));
end;

procedure TFloatRangeEdit.SetIValue(Value: Integer);
var re:real;
    s:string;
begin
  if (csDesigning in ComponentState)and(fCreating) then exit;
  re:=Value;
  re:=re/(power(10,fDecimals));
  str(re:1:fDecimals,s);
  Text:=s;
  UpdateState;
end;

function TFloatRangeEdit.OKTest: boolean;
var re:real;
    err:integer;
    s:string;
begin
  s:=DelSpace(Text);
  val(s,re,err);
  if(err<>0)or(re<fMinRange)or(re>fMaxRange) then Result:=false else Result:=true;
end;

procedure TFloatRangeEdit.SetDecimals(Value: Integer);
var s:string;
    re:real;
    err:integer;
begin
  fDecimals:=Value;
  if (csDesigning in ComponentState)and(fCreating) then exit;
  s:=DelSpace(Text);
  val(s,re,err);
  if err=0 then
  begin
    str(re:1:fDecimals,s);
    Text:=s;
  end;
  UpdateState;
end;

constructor TFloatRangeEdit.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  fCreating:=true;
  fMaxRange:=1000;
  fMinRange:=-1000;
  fNormalColor:=clDefault;
  fErrColor:=$B9B9FF;
  fRangeColor:=$88FFFF;
  fDecimals:=1;
end;

procedure TFloatRangeEdit.Change;
begin
  inherited Change;
  UpdateState;
  fCreating:=false;
end;

procedure TFloatRangeEdit.UpdateState;
var re:real;
    err:integer;
    s:string;
begin
  s:=DelSpace(Text);
  val(s,re,err);
  if err<>0 then
  begin
    Color:=fErrColor;
    Exit;
  end;
  if(re<fMinRange)or(re>fMaxRange) then
  begin
    Color:=fRangeColor;
    Exit;
  end;
  Color:=fNormalColor;
end;

end.
