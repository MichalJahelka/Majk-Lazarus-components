unit HexControls;

{
    HexControls

    (F) 2009     Michal Jahelka

    FREEWARE

    If you use it, please send me e-mail to I know, that
    my work is useful for somebody else. Thanks, it was
    really terrible work.

    michal.jahelka@vsb.cz

}

{$mode objfpc}{$H+}

interface

uses
  LCLIntf, LCLType, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, ClipBrd, ExtCtrls, LResources;

type
  TSel=record
         Poc,Len:integer;
       end;
  TEditMode=(EdInsertMode,EdOverMode);
  THexEdit = class(TCustomControl)
  private
    { Private declarations }
    Delk01,Delk02,Delk03:Integer;     { Definice osdstupu èísel }
    ClrScr,KurCis,AClear:Boolean;
    Pozadi,BarvaIKurzoru,BarvaOKurzoru,BarvaOfsetu,BarvaVyberu,TextVyberu,
           BarvaCisel,BarvaTextu:TColor;
    Sloupcu,VeSloupci:integer;
    Obsah:string;
    Kurzor:TPoint;
    Sel:TSel;                         { Výbìr }
    EdMode:TEditMode;
    OldCursor:Array[1..3] of integer; { Grafická poloha kurzoru }
    NChar:char;                       { NullChar }
    procedure FormPaint(Sender:TObject);
    procedure SetSel(Shift:TShiftState);
    { Nastavovací pomocné procedury }
    procedure NastavObsah(NovyObsah:string);
    procedure NastavSloupce(NovyPocet:integer);
    procedure NastavVeSloupci(NovyPocet:integer);
    procedure NastavBO(NovaBarva:TColor);
    procedure NastavBC(NovaBarva:TColor);
    procedure NastavBT(NovaBarva:TColor);
    procedure NastavBIK(NovaBarva:TColor);
    procedure NastavBOK(NovaBarva:TColor);
    procedure NastavBVP(NovaBarva:TColor);
    procedure NastavBVT(NovaBarva:TColor);
    procedure NastavVyber(NovyVyber:TSel);
    function GetVyber:TSel;
    procedure SetEditMode(NovyMod:TEditMode);
    procedure SetNullChar(NewNullChar:char);
    function GetCursorPosition:integer;
    procedure SetCursorPosition(NewCP:Integer);
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    { Protected declarations }
    procedure Paint; override;
    Procedure DriveKey(Key: Word;Shift: TShiftState);
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseUp(Button: TMouseButton;Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X,Y: Integer); override;
    procedure Resize; override;
  public
    { Public declarations }
    HScrollBar,VScrollBar:TScrollBar;
    constructor create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure CommonReInit;        { Inicializace Délek }
    procedure ResizTabs;           { Spoèítat velikost tabulátorù }
    procedure UpravPoziceTab;      { Uprav pozice tabulátorù }
    procedure TextCopy;
    procedure TextCut;
    procedure TextPaste;
    property Selection:TSel read GetVyber Write NastavVyber;
  published
    { Published declarations }
    property Color default clWindow;
    property Font;
    Property Text:String read Obsah write NastavObsah;
    property Columns:integer read Sloupcu write NastavSloupce default 8;
    property InColumns:integer read VeSloupci write NastavVeSloupci default 1;
    property OfsetColor:TColor read BarvaOfsetu write NastavBO default ClBlue;
    property NumColor:TColor read BarvaCisel Write NastavBC default clBlack;
    property TextColor:TColor read BarvaTextu Write NastavBT default clPurple;
    property CursorIColor:TColor read BarvaIKurzoru Write NastavBIK default clPurple;
    property CursorOColor:TColor read BarvaOKurzoru Write NastavBOK default clPurple;
    property SelectBkCol:TColor read BarvaVyberu Write NastavBVP default clPurple;
    property SelectTextCol:TColor read TextVyberu Write NastavBVT default clPurple;
    property EditMode:TEditMode read EdMode write SetEditMode;
    property NullChar:Char read NChar write SetNullChar default '.';
    property AutoClear:boolean read AClear write AClear default true;
    property CursorPosition:integer read GetCursorPosition write SetCursorPosition;
    property Enabled;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
    property Anchors;
  end;

  { THexLine }

  THexLine = class(TCustomGroupBox)
  private
    { Private declarations }
    Kurzor:integer;
    Obsah:string;
    NChar:char;
    FOnChange:TNotifyEvent;
    procedure UpdateBoxes;
    procedure TextBoxKeyPressed(Sender: TObject;var Key: Char);
    procedure TextBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TextBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TextBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure HexBoxKeyPressed(Sender: TObject;var Key: Char);
    procedure HexBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HexBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure HexBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure BoxesOnEnter(Sender:TObject);
    procedure SetObsah(s:string);
    procedure SetWidth(x:integer);
  protected
    { Protected declarations }
    procedure Resize; override;
  public
    HexBox,TextBox:TEdit;
    HexLabel,TextLabel:TLabel;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TextCopy;
    procedure TextCut;
    procedure TextPaste;
    { Public declarations }
  published
    { Published declarations }
    property Font;
    property Text:string read Obsah write SetObsah;
    property Width Write SetWidth;
    property Enabled;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
    property Anchors;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  end;

procedure Register;

implementation

constructor THexEdit.Create(AOwner: TComponent);
var g:integer;
    Hxp:THexEdit;
begin
  inherited Create(AOwner);
  Hxp:=Self;
 // ControlStyle := ControlStyle + [csOpaque,csFramed,csCaptureMouse,csClickEvents];
  ControlStyle:=[csOpaque,csFramed,csCaptureMouse, csClickEvents, csDoubleClicks] ;
  Obsah:='';
  Cursor:=crIBeam;
  HScrollBar:=TScrollBar.Create(Hxp);
  VScrollBar:=TScrollBar.Create(Hxp);
  With HSCrollBar do
  begin
    Parent:=Hxp;
    TabStop:=false;
    ControlState:=ControlState - [csFocusing];
    ControlStyle:=ControlStyle - [csFramed] + [csNoDesignSelectable];
    Kind:=SbHorizontal;
    Align:=AlBottom;
    Min:=0;
    Max:=0;
    Position:=0;
    SmallChange:=10;
    LargeChange:=100;
    Name:='HScrollBar';
    OnChange:=@FormPaint;
  end;
  With VScrollBar do
  begin
    Parent:=Hxp;
    TabStop:=False;
    ControlState:=ControlState - [csFocusing];
    ControlStyle:=ControlStyle - [csFramed] + [csNoDesignSelectable];
    Kind:=sbVertical;
    Align:=AlRight;
    Min:=0;Max:=0;
    Position:=0;
    Name:='VScrollBar';
    OnChange:=@FormPaint;
  end;
  TabStop:=true;
  Color:=ClWhite;
  Font.Name:='Courier New';
  Font.Size:=12;
  Font.Style:=[];
  for g:=1 to 3 do OldCursor[g]:=0;
  Kurzor.X:=0;Kurzor.Y:=0;
  EdMode:=EdOverMode;
  ClrScr:=true;AClear:=true;KurCis:=True;
  Sloupcu:=8;VeSloupci:=1;
  BarvaCisel:=ClBlack;
  BarvaOfsetu:=ClBlue;
  BarvaTextu:=ClPurple;
  BarvaIKurzoru:=ClRed;
  BarvaOKurzoru:=ClYellow;
  BarvaVyberu:=ClNavy;
  TextVyberu:=ClWhite;
  Obsah:='';
  NChar:='.';
  Sel.Poc:=1;Sel.Len:=0;
  SetInitialBounds(0,0,300,150);
end;

destructor THexEdit.Destroy;
begin
  Obsah:='';
  HScrollBar.Destroy;
  VScrollBar.Destroy;
  inherited Destroy;
end;

Procedure THexEdit.CommonReInit;
begin
  Delk03:=Canvas.TextWidth('m');
  Delk01:=Canvas.TextWidth('00000:EE');
  Delk02:=Delk01+Delk03*(Sloupcu*(VeSloupci*2+1)+1);
end;

Procedure THexEdit.ResizTabs;
var g:integer;
begin
  CommonReInit;
  g:=Delk02+Delk03*Sloupcu*VeSloupci-ClientWidth+VScrollBar.Width;
  if g<0 then g:=0;
  HSCrollBar.Max:=g+5;
  HSCrollBar.LargeChange:=g div 10;
  HSCrollBar.Visible:=HSCrollBar.Max>5;
  g:=0;if HScrollBar.Visible then g:=HSCrollBar.Height;
  g:=Length(Obsah)div(Sloupcu*VeSloupci)-(ClientHeight+Font.Height div 4-1-g)div(2-Font.Height)+1;
  if g<0 then g:=0;
  VScrollBar.Max:=g;
  VScrollBar.Visible:=VScrollBar.Max>0;
  VScrollBar.LargeChange:=(ClientHeight+Font.Height div 4-1-HSCrollBar.Height)div (2-Font.Height);
end;

procedure THexEdit.UpravPoziceTab;
var g,vp:integer;
    bylo:boolean;
begin
  CommonReInit;
  vp:=VScrollBar.Position;
  g:=0;if HScrollBar.Visible then g:=HSCrollBar.Height;
  bylo:=false;
  if Kurzor.Y<VScrollBar.Position then begin g:=Kurzor.Y;Bylo:=true;end
    else if Kurzor.Y-VScrollBar.Position>(ClientHeight+Font.Height div 4-1-g)div(2-Font.Height)-1 then
         begin
            g:=Kurzor.Y-(ClientHeight+Font.Height div 4-1-g)div(2-Font.Height)+1;
            Bylo:=true;
         end;
  if Bylo then
  begin
    if g<0 then g:=0;
    if g<>Vp then ClrScr:=True;
    VScrollBar.OnChange:=nil;
    VScrollBar.Position:=g;
    VScrollBar.OnChange:=@FormPaint;
  end;
  Bylo:=false;g:=HScrollBar.Position;
  vp:=0;if VScrollBar.Visible then vp:=VScrollBar.Width;
  if KurCis then
  begin
    if Delk01+Delk03*(Kurzor.X+Kurzor.X div (VeSloupci*2))<HScrollBar.Position then
    begin
      g:=Delk01+Delk03*(Kurzor.X div 2 div VeSloupci*2*VeSloupci+Kurzor.X div (VeSloupci*2))-5;
      Bylo:=true;
    end;
    if Delk01+Delk03*(Kurzor.X+Kurzor.X div (VeSloupci*2)+1)>HScrollBar.Position+ClientWidth-vp then
    begin
      g:=Delk01+Delk03*(Kurzor.X div 2 div VeSloupci*2*VeSloupci+VeSloupci*2+Kurzor.X
         div (VeSloupci*2))-ClientWidth+vp+5;
      Bylo:=true;
    end;
  end else begin
    if Delk02+Delk03*(Kurzor.X-2) div 2<HScrollBar.Position then
    begin
      g:=Delk02+Delk03*(Kurzor.X-2) div 2-5;
      bylo:=true;
    end;
    if Delk02+Delk03*(Kurzor.X+2) div 2>HScrollBar.Position+ClientWidth-vp then
    begin
      g:=Delk02+Delk03*(Kurzor.X+2) div 2-ClientWidth+vp+5;
      Bylo:=true;
    end;
  end;
  if Bylo then
  begin
    if g<0 then g:=0;
    if g<>HScrollBar.Position then ClrScr:=True;
    VScrollBar.OnChange:=nil;
    HScrollBar.Position:=g;
    VScrollBar.OnChange:=@FormPaint;
  end;
end;

procedure THexEdit.Paint;
var f,g,n,d,Radku,Slo,Rad,Sup,Suk,Sus:integer;
    s:String;
begin
  if not assigned(Self.Parent) then exit;
  Canvas.Font:=Font;
  ResizTabs;
  Pozadi:=Color;
  Sup:=Sel.Poc;
  Suk:=Sel.Poc+Sel.Len;
  if Sup>Suk then begin Sup:=Suk;Suk:=Sel.Poc;end;
  Radku:=Length(Obsah) div (Sloupcu*VeSloupci);
  g:=0;if HScrollBar.Visible then g:=HSCrollBar.Height;
  g:=(ClientHeight+Font.Height div 4-1-g)div (2-Font.Height)-1;
  if Radku>g then Radku:=g;
  With Canvas do
  begin
    Pen.Style:=psClear;
    Brush.Color:=Pozadi;
    Pen.Color:=Pozadi;
    if ClrScr and Aclear then Rectangle(0,0,ClientWidth,ClientHeight);
    if ClrScr and not AClear then
      if (Radku+VScrollBar.Position)*Sloupcu*VeSloupci+Sloupcu*VeSloupci+1>Length(Obsah) then
      begin
        Rad:=(2-Font.Height)*(Radku+1)-Font.Height div 4;
        Rectangle(0,Rad,ClientWidth,ClientHeight);
      end;
    Pen.Style:=psSolid;
    Pen.Width:=Font.Size div 5;
    MoveTo(OldCursor[1],OldCursor[2]);
    LineTo(OldCursor[3],OldCursor[2]);
    Pen.Color:=BarvaIKurzoru;
  end;
  For g:=VScrollBar.Position to Radku+VScrollBar.Position do
  begin
    Canvas.Font.Color:=BarvaOfsetu;
    Canvas.Brush.Color:=Pozadi;
    s:=IntToHex(g*Sloupcu,5)+':';
    Rad:=(2-Font.Height)*(g-VScrollBar.Position)-Font.Height div 4;
    if not AClear then
    begin
      Canvas.TextOut(-HSCrollBar.Position,Rad,' ');
      s:=s+'  ';
    end;
    Canvas.TextOut(Font.Size div 2-HSCrollBar.Position,Rad,s);
    Slo:=Delk01;
    for f:=0 to Sloupcu-1 do
    begin
      for n:=1 to VeSloupci do if g*Sloupcu*VeSloupci+f*VeSloupci+n-1<Length(Obsah) then
      begin
        Sus:=f*VeSloupci+n+g*Sloupcu*VeSloupci+1;
        if (Sus>Sup)and(Sus<=Suk) then
        begin
          Canvas.Brush.Color:=BarvaVyberu;
          Canvas.Font.Color:=TextVyberu;
        end else begin
          Canvas.Brush.Color:=Pozadi;
          Canvas.Font.Color:=BarvaCisel;
          if KurCis and(Kurzor.Y=g)and(EdMode=EdOverMode)and(f*VeSloupci+n-1=Kurzor.X div 2) then
             Canvas.Brush.Color:=BarvaOKurzoru;
        end;
        s:=IntToHex(Byte(Obsah[Sus-1]),2);
        if not AClear and(n=VeSloupci)and(Sus<>Suk)and not(KurCis and(Kurzor.Y=g)
           and(EdMode=EdOverMode)and(f*VeSloupci+n-1=Kurzor.X div 2)) then s:=s+' ';
        Canvas.TextOut(Slo-HSCrollBar.Position,Rad,s);
        if not AClear and(n=VeSloupci)and((Sus=Suk)or KurCis and(Kurzor.Y=g)
           and(EdMode=EdOverMode)and(f*VeSloupci+n-1=Kurzor.X div 2)) then
        begin
          Canvas.Brush.Color:=Pozadi;
          Canvas.Font.Color:=BarvaCisel;
          Canvas.TextOut(Slo-HSCrollBar.Position+Canvas.TextWidth(s),Rad,' ');
        end;
        if KurCis and(Kurzor.Y=g)and(f*VeSloupci+n-1=Kurzor.X div 2) then
        with Canvas do
        begin
          d:=(Kurzor.X mod 2)*TextWidth(S[1]);
          OldCursor[1]:=d+Slo-HSCrollBar.Position;
          OldCursor[2]:=Rad-Font.Height;
          OldCursor[3]:=d+Slo+TextWidth(s[Kurzor.X mod 2])-HSCrollBar.Position;
          MoveTo(OldCursor[1],OldCursor[2]);
          LineTo(OldCursor[3],OldCursor[2]);
          Brush.Color:=Pozadi;
        end;
        Slo:=Slo+Delk03*2;
      end else if ClrScr and not Aclear then begin
        Canvas.Brush.Color:=Pozadi;
        Canvas.Font.Color:=BarvaCisel;
        Canvas.TextOut(Slo-HSCrollBar.Position,Rad,'  ');
        Slo:=Slo+Delk03*2;
      end;
      Slo:=Slo+Delk03;
    end;
    if not AClear then
    begin
      Canvas.Brush.Color:=Pozadi;
      Canvas.Font.Color:=BarvaCisel;
      Canvas.TextOut(Slo-Delk03-HSCrollBar.Position,Rad,'  ');
    end;
    Slo:=Delk02;
    for f:=1 to Sloupcu*VeSloupci do if g*Sloupcu*VeSloupci+f<=Length(Obsah) then
    begin
      if (f+1+g*Sloupcu*VeSloupci>Sup)and(f+1+g*Sloupcu*VeSloupci<=Suk) then
      begin
        Canvas.Brush.Color:=BarvaVyberu;
        Canvas.Font.Color:=TextVyberu;
      end else begin
        Canvas.Brush.Color:=Pozadi;
        Canvas.Font.Color:=BarvaTextu;
        if not(KurCis)and(Kurzor.Y=g)and(EdMode=EdOverMode)and(f-1=Kurzor.X div 2) then
           Canvas.Brush.Color:=BarvaOKurzoru;
      end;
      s:=AnsiToUtf8(Obsah[g*Sloupcu*VeSloupci+f]);
      if (s<' ')or(Canvas.TextWidth(s)=0) then s:=NChar;
      Canvas.TextOut(Slo-HSCrollBar.Position,Rad,s);

      if not(KurCis)and(Kurzor.Y=g)and(f-1=Kurzor.X div 2) then
      With Canvas do
      begin
        OldCursor[1]:=Slo-HSCrollBar.Position;
        OldCursor[2]:=Rad-Font.Height;
        OldCursor[3]:=Slo+TextWidth(s)-HSCrollBar.Position;
        if(OldCursor[1]=OldCursor[3]) then OldCursor[3]:=Slo+TextWidth(' ')-HSCrollBar.Position;
        MoveTo(OldCursor[1],OldCursor[2]);
        LineTo(OldCursor[3],OldCursor[2]);
        Brush.Color:=Pozadi;
      end;
      Slo:=Slo+Delk03;
    end else if ClrScr and not Aclear then begin
      Canvas.Brush.Color:=Pozadi;
      Canvas.Font.Color:=BarvaTextu;
      Canvas.TextOut(Slo-HSCrollBar.Position,Rad,' ');
      Slo:=Slo+Delk03;
    end;
    if not AClear then Canvas.TextOut(Slo-HSCrollBar.Position,Rad,' ');
  end;
  ClrScr:=True;
end;

procedure THexEdit.FormPaint(Sender:TObject);
begin
  Paint;
end;

procedure THexEdit.SetSel(Shift: TShiftState);
begin
  if Shift=[ssShift] then
  begin
    Sel.Len:=Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1-Sel.Poc;
  end else begin
    sel.poc:=Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1;
    sel.Len:=0;
  end;
end;

procedure THexEdit.TextCopy;
var s:string;
    p,d:integer;
begin
  if Sel.Len<>0 then  { Ctrl - C ... Copy }
  begin
    p:=Sel.Poc;d:=Sel.Len;
    if d<0 then begin p:=p+d;d:=-d;end;
    s:=AnsiToUTF8(Copy(Obsah,p,d));
    Clipboard.Open;
    Clipboard.AsText:=s;
    Clipboard.Close;
  end;
end;

procedure THexEdit.TextCut;
var p,d:integer;
begin
  if Sel.Len<>0 then
  begin
    TextCopy;
    p:=Sel.Poc;d:=Sel.Len;
    if d<0 then begin p:=p+d;d:=-d;end;
    Kurzor.X:=(p-1) mod (Sloupcu*VeSloupci)*2+1;
    Kurzor.Y:=(p-1) div (Sloupcu*VeSloupci);
    Delete(Obsah,p,d);
    Sel.Len:=0;
    ResizTabs;UpravPoziceTab;
    ClrScr:=true;
    Paint;
  end;
end;

procedure THexEdit.TextPaste;
var p,d,x:integer;
    s:string;
begin
  if ClipBoard.HasFormat(CF_TEXT) then
  begin
    s:=Utf8ToAnsi(ClipBoard.AsText);
    if Sel.Len=0 then
    begin
      x:=Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1;
      Insert(s,Obsah,x);
    end;
    if Sel.Len<>0 then
    begin
      p:=Sel.Poc;d:=Sel.Len;
      if d<0 then begin p:=p+d;d:=-d;end;
      Kurzor.X:=(p-1) mod (Sloupcu*VeSloupci)*2+1;
      Kurzor.Y:=(p-1) div (Sloupcu*VeSloupci);
      Delete(Obsah,p,d);
      Sel.Len:=0;
      Insert(s,Obsah,p);
    end;
    ResizTabs;UpravPoziceTab;
    ClrScr:=true;
    Paint;
  end;
end;

Procedure THexEdit.DriveKey(Key: Word;Shift: TShiftState);
var p,d:integer;
begin
  if Key=Vk_Back then
  begin
    if Sel.Len=0 then
    begin
      p:=Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2;
      if p>0 then
      begin
        Delete(Obsah,p,1);
        Key:=Vk_Left;
        if KurCis then DriveKey(vk_Left,[]); { Èíslo se skládá ze dvou }
        ResizTabs;UpravPoziceTab;
        ClrScr:=true;
        Paint;
      end else exit;
    end else Key:=Vk_Delete;
  end;
  Case Key of
    VK_Insert:
    begin
      if EdMode=EdInsertMode then EdMode:=EdOverMode else EdMode:=EdInsertMode;
      ClrScr:=false;Paint;
    end;
    VK_Tab:
    begin
      KurCis:=Not KurCis;
      ClrScr:=False;
      UpravPoziceTab;
      Paint;
    end;
    Vk_Left:
    begin
      Dec(Kurzor.X);
      if not Kurcis then Dec(Kurzor.X);
      if Kurzor.X<0 then begin Kurzor.X:=Sloupcu*VeSloupci*2-1;Dec(Kurzor.Y);end;
      if Kurzor.Y<0 then begin Kurzor.Y:=0;Kurzor.X:=0;end;
      SetSel(Shift);ClrScr:=False;UpravPoziceTab;Paint;
    end;
    Vk_Right:
    begin
      Inc(Kurzor.X);
      if not Kurcis then Inc(Kurzor.X);
      if Kurzor.X>Sloupcu*VeSloupci*2-1 then begin Kurzor.X:=0;Inc(Kurzor.Y);end;
      if Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1>Length(Obsah) then
      begin
        Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
        Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
      end;
      SetSel(Shift);ClrScr:=False;UpravPoziceTab;Paint;
    end;
    Vk_Up:
    begin
      Dec(Kurzor.Y);
      if Kurzor.Y<0 then begin Kurzor.Y:=0;Kurzor.X:=0;end;
      SetSel(Shift);ClrScr:=false;UpravPoziceTab;Paint;
    end;
    Vk_Down:
    begin
      Inc(Kurzor.Y);
      if Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1>Length(Obsah) then
      begin
        Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
        Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
      end;
      SetSel(Shift);ClrScr:=False;UpravPoziceTab;Paint;
    end;
    Vk_Prior:
    begin
      p:=0;if HScrollBar.Visible then p:=HSCrollBar.Height;
      Kurzor.Y:=Kurzor.Y-(ClientHeight+Font.Height div 4-1-p)div (2-Font.Height)+1;
      if Kurzor.Y<0 then begin Kurzor.X:=0;Kurzor.Y:=0;end;
      SetSel(Shift);ClrScr:=False;UpravPoziceTab;Paint;
    end;
    Vk_Next:
    begin
      p:=0;if HScrollBar.Visible then p:=HSCrollBar.Height;
      Kurzor.Y:=Kurzor.Y+(ClientHeight+Font.Height div 4-1-p)div (2-Font.Height)-1;
      if Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1>Length(Obsah) then
      begin
        Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
        Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
      end;
      SetSel(Shift);ClrScr:=False;UpravPoziceTab;Paint;
    end;
    Vk_Home:
    begin
      if shift<>[ssCtrl] then
      begin
        Kurzor.X:=0;Kurzor.Y:=0;
        SetSel(Shift);ClrScr:=False;UpravPoziceTab;
      end else HScrollBar.Position:=0;
      Paint;
    end;
    Vk_End:
    begin
      if shift<>[ssCtrl] then
      begin
        Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
        Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
        SetSel(Shift);ClrScr:=False;UpravPoziceTab;
      end else HScrollBar.Position:=HScrollBar.Max;
      Paint;
    end;
    Vk_Delete:
    begin
      if Sel.Len=0 then
      begin
        Delete(Obsah,Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1,1);
      end else begin
        p:=Sel.Poc;d:=Sel.Len;
        if d<0 then begin p:=p+d;d:=-d;end;
        Kurzor.X:=(p-1) mod (Sloupcu*VeSloupci)*2+1;
        Kurzor.Y:=(p-1) div (Sloupcu*VeSloupci);
        Delete(Obsah,p,d);
        Sel.Len:=0;
      end;
      ResizTabs;UpravPoziceTab;
      ClrScr:=true;
      Paint;
    end;
    65:if shift=[ssCtrl] then  { Ctrl - A ... Select All }
    begin
      Sel.Poc:=1;
      Sel.Len:=Length(Obsah);
      ClrScr:=True;Paint;
    end;
    67:if shift=[ssCtrl] then TextCopy;
    Ord('X'):if shift=[ssCtrl] then TextCut;
    Ord('V'):if shift=[ssCtrl] then TextPaste;
    Ord('O'):if shift=[ssCtrl] then { Offset view }
    begin
      HScrollBar.Position:=0;
      ClrScr:=true;
      Paint;
    end;
    Ord('T'):if shift=[ssCtrl] then { Text view }
    begin
      HScrollBar.Position:=HSCrollBar.Max;
      ClrScr:=true;
      Paint;
    end;
  end;
end;

procedure THexEdit.KeyDown(var Key: Word;Shift: TShiftState);
begin
  inherited;
  DriveKey(Key,Shift);
  if Key in [Vk_Left,Vk_Right,Vk_Up,Vk_Down,Vk_Back,Vk_Delete,Vk_Prior,Vk_Next,
             Vk_Home,Vk_End] then Key:=0;
end;

procedure THexEdit.KeyPress(var Key: Char);
var x,cis,p,d:integer;
begin
  inherited;
  if Obsah='' then begin Kurzor.X:=0;Kurzor.Y:=0;end;
  x:=Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1;
  if KurCis and (UpCase(Key) in ['0'..'9','A'..'F']) then
  begin
    Cis:=StrToInt('$'+Key);
    if Sel.Len=0 then if EdMode=EdInsertMode then
    begin
      if (Kurzor.X mod 2=0)or(Obsah='') then
      begin
        Kurzor.X:=Kurzor.X and not 1;
        Insert(#0,Obsah,x);
        Obsah[x]:=char(Byte(Obsah[X])and 15 or (Cis shl 4));
        ResizTabs;UpravPoziceTab;
        Paint;
      end else Obsah[x]:=char(Byte(Obsah[X])and 240 or Cis);
      ClrScr:=false;
      if (x=Length(Obsah))and(Kurzor.X mod 2=1) then DriveKey(Vk_Left,[])
                                                else DriveKey(Vk_Right,[]);
    end else begin
      EdMode:=EdInsertMode;ClrScr:=false;
      Paint;
      EdMode:=EdOverMode;
      if Obsah='' then begin Obsah:=#0;Kurzor.X:=0;end;
      if Kurzor.X mod 2=0 then Obsah[x]:=char(Byte(Obsah[X])and 15 or (Cis shl 4))
                          else Obsah[x]:=char(Byte(Obsah[X])and 240 or Cis);
      if (x=Length(Obsah))and(Kurzor.X mod 2=1) then Obsah:=Obsah+#0;
      ClrScr:=false;
      DriveKey(Vk_Right,[]);
    end;
    if Sel.Len<>0 then
    begin
      p:=Sel.Poc;d:=Sel.Len;
      if d<0 then begin p:=p+d;d:=-d;end;
      Kurzor.X:=(p-1) mod (Sloupcu*VeSloupci)*2+1;
      Kurzor.Y:=(p-1) div (Sloupcu*VeSloupci);
      Delete(Obsah,p,d);
      Insert(char(Cis shl 4),Obsah,p);
      Sel.Len:=0;
      ResizTabs;UpravPoziceTab;
      ClrScr:=True;
      Paint;
    end;
  end;
  if not KurCis and(Key>=' ') then
  begin
    if Sel.Len=0 then
    begin
      if EdMode=EdInsertMode then
      begin
        Insert(Key,Obsah,x);
        Paint;
      end else begin
        if Obsah='' then Obsah:=Key
                    else Obsah[x]:=Key;
        if x=Length(Obsah) then
        begin
          Obsah:=Obsah+#0;UpravPoziceTab;
        end;
      end;
      ClrScr:=false;
      DriveKey(Vk_Right,[]);
    end;
    if Sel.Len<>0 then
    begin
      p:=Sel.Poc;d:=Sel.Len;
      if d<0 then begin p:=p+d;d:=-d;end;
      Kurzor.X:=(p-1) mod (Sloupcu*VeSloupci)*2+1;
      Kurzor.Y:=(p-1) div (Sloupcu*VeSloupci);
      Delete(Obsah,p,d);
      Insert(Key,Obsah,p);
      Sel.Len:=0;
      ResizTabs;UpravPoziceTab;
      DriveKey(Vk_Right,[]);
      ClrScr:=True;
      Paint;
    end;
  end;
  ResizTabs;
end;

procedure THexEdit.MouseUp(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (X+HScrollBar.Position>Delk01)and
     (X+HScrollBar.Position<Delk01+Delk03*(Sloupcu*(2*VeSloupci+1))) then
  begin
    Kurzor.X:=(X+HScrollBar.Position-Delk01) div Delk03;
    Kurzor.X:=Kurzor.X-Kurzor.X div (VeSloupci*2+1);
    Kurzor.Y:=(Y+Font.Height div 4)div (2-Font.Height)+VSCrollBar.Position;
    if Kurzor.Y>=(Length(Obsah)-1) div (Sloupcu*VeSloupci) then
    begin
       Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
       if Kurzor.X>(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1 then
          Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
    end;
    KurCis:=True;UpravPoziceTab;ClrScr:=False;Paint;
  end;
  if (X+HScrollBar.Position>Delk02)and(X+HScrollBar.Position<Delk02+Delk03*Sloupcu*VeSloupci) then
  begin
    Kurzor.X:=2*(X+HScrollBar.Position-Delk02) div Delk03;
    Kurzor.Y:=(Y+Font.Height div 4)div (2-Font.Height)+VSCrollBar.Position;
    if Kurzor.Y>=(Length(Obsah)-1) div (Sloupcu*VeSloupci) then
    begin
       Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
       if Kurzor.X>(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1 then
          Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
    end;
    KurCis:=False;UpravPoziceTab;ClrScr:=False;Paint;
  end;
end;

procedure THexEdit.MouseDown(Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetFocus;
  if (X+HScrollBar.Position>Delk01)and
     (X+HScrollBar.Position<Delk01+Delk03*(Sloupcu*(2*VeSloupci+1))) then
  begin
    Kurzor.X:=(X+HScrollBar.Position-Delk01) div Delk03;
    Kurzor.X:=Kurzor.X-Kurzor.X div (VeSloupci*2+1);
    Kurzor.Y:=(Y+Font.Height div 4)div (2-Font.Height)+VSCrollBar.Position;
    if Kurzor.Y>=(Length(Obsah)-1) div (Sloupcu*VeSloupci) then
    begin
       Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
       if Kurzor.X>(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1 then
          Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
    end;
    KurCis:=True;UpravPoziceTab;ClrScr:=False;Paint;
  end;
  if (X+HScrollBar.Position>Delk02)and(X+HScrollBar.Position<Delk02+Delk03*Sloupcu*VeSloupci) then
  begin
    Kurzor.X:=2*(X+HScrollBar.Position-Delk02) div Delk03;
    Kurzor.Y:=(Y+Font.Height div 4)div (2-Font.Height)+VSCrollBar.Position;
    if Kurzor.Y>=(Length(Obsah)-1) div (Sloupcu*VeSloupci) then
    begin
       Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
       if Kurzor.X>(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1 then
          Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
    end;
    KurCis:=False;UpravPoziceTab;ClrScr:=False;Paint;
  end;
  SetSel([]);
end;

procedure THexEdit.MouseMove(Shift: TShiftState; X,Y: Integer);
begin
  inherited;
  if Shift=[ssLeft] then
  begin
  if (X+HScrollBar.Position>Delk01)and
     (X+HScrollBar.Position<Delk01+Delk03*(Sloupcu*(2*VeSloupci+1))) then
  begin
    Kurzor.X:=(X+HScrollBar.Position-Delk01) div Delk03;
    Kurzor.X:=Kurzor.X-Kurzor.X div (VeSloupci*2+1);
    Kurzor.Y:=(Y+Font.Height div 4)div (2-Font.Height)+VSCrollBar.Position;
    if Y<5 then Dec(Kurzor.Y);
    if Kurzor.Y<0 then Kurzor.Y:=0;
    if Kurzor.Y>=(Length(Obsah)-1) div (Sloupcu*VeSloupci) then
    begin
       Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
       if Kurzor.X>(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1 then
          Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
    end;
    KurCis:=True;UpravPoziceTab;ClrScr:=False;Paint;
  end;
  if (X+HScrollBar.Position>Delk02)and(X+HScrollBar.Position<Delk02+Delk03*Sloupcu*VeSloupci) then
  begin
    Kurzor.X:=2*(X+HScrollBar.Position-Delk02) div Delk03;
    Kurzor.Y:=(Y+Font.Height div 4)div (2-Font.Height)+VSCrollBar.Position;
    if Kurzor.Y>=(Length(Obsah)-1) div (Sloupcu*VeSloupci) then
    begin
       Kurzor.Y:=(Length(Obsah)-1) div (Sloupcu*VeSloupci);
       if Kurzor.X>(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1 then
          Kurzor.X:=(Length(Obsah)-1) mod (Sloupcu*VeSloupci)*2+1;
    end;
    KurCis:=False;UpravPoziceTab;ClrScr:=False;Paint;
  end;
  SetSel([ssShift]);
  end;
end;

procedure THexEdit.Resize;
begin
  inherited Resize;
  if csDesigning in ComponentState then exit;
  ResizTabs;
  UpravPoziceTab;
  ClrScr:=True;
  Paint;
end;

procedure THexEdit.NastavObsah(NovyObsah:string);
begin
  Obsah:=NovyObsah;
  Paint;
end;

procedure THexEdit.NastavSloupce(NovyPocet:integer);
begin
  if NovyPocet<1 then NovyPocet:=1;
  Sloupcu:=NovyPocet;
  Paint;
end;

procedure THexEdit.NastavVeSloupci(NovyPocet:integer);
begin
  if NovyPocet<1 then NovyPocet:=1;
  VeSloupci:=NovyPocet;
  Paint;
end;

procedure THexEdit.NastavBO(NovaBarva:TColor);
begin
  BarvaOfsetu:=NovaBarva;
  Paint;
end;

procedure THexEdit.NastavBC(NovaBarva:TColor);
begin
  BarvaCisel:=NovaBarva;
  Paint;
end;

procedure THexEdit.NastavBT(NovaBarva:TColor);
begin
  BarvaTextu:=NovaBarva;
  Paint;
end;

procedure THexEdit.NastavBIK(NovaBarva:TColor);
begin
  BarvaIKurzoru:=NovaBarva;
  Paint;
end;

procedure THexEdit.NastavBOK(NovaBarva:TColor);
begin
  BarvaOKurzoru:=NovaBarva;
  Paint;
end;

procedure THexEdit.NastavBVP(NovaBarva:TColor);
begin
  BarvaVyberu:=NovaBarva;
  Paint;
end;

procedure THexEdit.NastavBVT(NovaBarva:TColor);
begin
  TextVyberu:=NovaBarva;
  Paint;
end;

procedure THexEdit.NastavVyber(NovyVyber:TSel);
begin
  Sel:=NovyVyber;
  Paint;
end;

function THexEdit.GetVyber:TSel;
var sll:TSel;
begin
  sll:=Sel;
  if Sll.Len<0 then begin Sll.Poc:=Sll.Poc+Sll.Len;Sll.Len:=-Sll.Len;end;
  GetVyber:=Sll;
end;

procedure THexEdit.SetEditMode(NovyMod:TEditMode);
begin
  EdMode:=NovyMod;
  ClrScr:=false;
  Paint;
end;

procedure THexEdit.SetNullChar(NewNullChar:char);
begin
  NChar:=NewNullChar;
  ClrScr:=false;
  Paint;
end;

function THexEdit.GetCursorPosition:integer;
begin
  GetCursorPosition:=Kurzor.Y*Sloupcu*VeSloupci+Kurzor.X div 2+1;
end;

procedure THexEdit.SetCursorPosition(NewCP:Integer);
begin
  Kurzor.X:=(NewCP-1) mod (Sloupcu*VeSloupci)*2;
  Kurzor.Y:=(NewCP-1) div (Sloupcu*VeSloupci);
  Paint;
end;

procedure THexEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS + DLGC_WANTCHARS + DLGC_WANTTAB;
end;

{ ***************** THexLine ******************* }

constructor THexLine.Create(AOwner: TComponent);
var Hxl:THexLine;
begin
  hxl:=(inherited Create(AOwner)) as THexLine;
  SetBounds(0,0,200,150);
  TabStop:=false;
  HexBox:=TEdit.Create(Hxl);
  TextBox:=TEdit.Create(Hxl);
  HexLabel:=TLabel.Create(Hxl);
  TextLabel:=TLabel.Create(Hxl);
  With HexLabel do
  begin
    Parent:=Hxl;
    Left:=10;
    Top:=5;
    Caption:='Hex';
    ParentFont:=false;
    ControlStyle:=ControlStyle+[csNoDesignSelectable];
  end;
  With HexBox do
  begin
    Parent:=Hxl;
    Left:=10;
    Top:=10+HexLabel.Height;
    Width:=Hxl.Width-20;
    Font.Name:='Courier New';
    Font.Size:=12;
    Font.Style:=[];
    Font.Color:=ClBlue;
    ParentFont:=false;
    ReadOnly:=True;
    CharCase:=ecUpperCase;
    OnKeyPress:=@HexBoxKeyPressed;
    OnKeyDown:=@HexBoxKeyDown;
    OnKeyUp:=@HexBoxKeyUp;
    OnMouseUp:=@HexBoxMouseUp;
    OnEnter:=@BoxesOnEnter;
    ControlStyle:=ControlStyle+[csNoDesignSelectable];
  end;
  With TextLabel do
  begin
    Parent:=Hxl;
    Left:=10;
    Top:=10+HexBox.Top+HexBox.Height;
    Caption:='Text';
    ParentFont:=false;
    ControlStyle:=ControlStyle+[csNoDesignSelectable];
  end;
  With TextBox do
  begin
    Parent:=Hxl;
    Left:=10;
    Top:=5+TextLabel.Top+TextLabel.Height;
    Width:=Hxl.Width-20;
    Font.Name:='Courier New';
    Font.Size:=12;
    Font.Style:=[];
    Font.Color:=ClPurple;
    ParentFont:=false;
    OnKeyPress:=@TextBoxKeyPressed;
    OnKeyDown:=@TextBoxKeyDown;
    OnKeyUp:=@TextBoxKeyUp;
    OnMouseUp:=@TextBoxMouseUp;
    OnEnter:=@BoxesOnEnter;
    ReadOnly:=true;
    ControlStyle:=ControlStyle+[csNoDesignSelectable];
  end;
  Self.ClientHeight:=TextBox.Top+TextBox.Height+30;
  ParentFont:=false;
  Obsah:='';
  NChar:='.';
end;

destructor THexLine.Destroy;
begin
  HexBox.Destroy;
  TextBox.Destroy;
  HexLabel.Destroy;
  TextLabel.Destroy;
  inherited destroy;
end;

procedure THexLine.UpdateBoxes;
var f:integer;
    s,c:string;
begin
  s:=Obsah;c:='';
  for f:=1 to Length(Obsah) do
  begin
    c:=c+IntToHex(byte(s[f]),2)+' ';
    if s[f]<' ' then s[f]:=NChar;
  end;
  HexBox.Text:=c;
  HexBox.SelStart:=Kurzor*3;
  TextBox.Text:=AnsiToUTF8(s);
  TextBox.SelStart:=Kurzor;
  if Assigned(fOnChange) then fOnChange(Self);
end;

procedure THexLine.TextBoxKeyPressed(Sender: TObject;var Key: Char);
begin
  if Assigned(OnKeyPress) then OnKeyPress(Sender,Key);
  if Key>=' ' then
  begin
    Kurzor:=TextBox.SelStart;
    if TextBox.SelLength>0 then Delete(Obsah,Kurzor+1,TextBox.SelLength);
    Insert(Key,Obsah,Kurzor+1);
    Inc(Kurzor);
    UpdateBoxes;
  end;
  if Key=#3 then begin TextCopy;Key:=#0;end;
  if Key=#24 then begin TextCut;Key:=#0;end;
  if Key=#22 then begin TextPaste;Key:=#0;end;
end;

procedure THexLine.TextCopy;
var p,d:integer;
    s:string;
begin
  if TextBox.SelLength<>0 then  { Ctrl - C ... Copy }
  begin
    p:=Kurzor;d:=TextBox.SelLength;
    if d<0 then begin p:=p+d;d:=-d;end;
    s:=AnsiToUTF8(Copy(Obsah,p+1,d));
    Clipboard.Open;
    Clipboard.AsText:=s;
    Clipboard.Close;
  end;
end;

procedure THexLine.TextCut;
var p,d:integer;
begin
  if TextBox.SelLength<>0 then
  begin
    TextCopy;
    p:=Kurzor;d:=TextBox.SelLength;
    if d<0 then begin p:=p+d;d:=-d;end;
    Delete(Obsah,p+1,d);
    TextBox.SelLength:=0;
    UpdateBoxes;
  end;
end;

procedure THexLine.TextPaste;
var p,d:integer;
    s:string;
begin
  if ClipBoard.HasFormat(CF_TEXT) then
  begin
    Clipboard.Open;
    s:=UTF8ToAnsi(Clipboard.AsText);
    Clipboard.Close;
    if TextBox.SelLength=0 then
    begin
      Insert(s,Obsah,Kurzor+1);
    end else begin
      p:=Kurzor;d:=TextBox.SelLength;
      if d<0 then begin p:=p+d;d:=-d;end;
      Delete(Obsah,p+1,d);
      TextBox.SelLength:=0;
      Insert(s,Obsah,p+1);
    end;
    Kurzor:=Kurzor+Length(s);
    UpdateBoxes;
  end;
end;

procedure THexLine.TextBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyDown) then OnKeyDown(Sender,Key,Shift);
  if Shift=[] then Case Key of
    Vk_Up:
    begin
      HexBox.SetFocus;Key:=0;
      HexBox.SelStart:=Kurzor*3-byte(Kurzor>0);
      HexBox.SelLength:=0;
    end;
    Vk_Down:Key:=0;
    Vk_Back:if ((Kurzor>0)or(TextBox.SelLength>0))and(Obsah>'') then
    begin
      Kurzor:=TextBox.SelStart;
      if TextBox.SelLength>0 then Delete(Obsah,Kurzor+1,TextBox.SelLength)
      else begin
        Delete(Obsah,Kurzor,1);
        Dec(Kurzor);
      end;
      UpdateBoxes;
      Key:=0;
    end;
    Vk_Delete:if (Kurzor<Length(Obsah))and(Obsah>'') then
    begin
      Kurzor:=TextBox.SelStart;
      if TextBox.SelLength>0 then Delete(Obsah,Kurzor+1,TextBox.SelLength)
                             else Delete(Obsah,Kurzor+1,1);
      UpdateBoxes;
      Key:=0;
    end;
  end;
end;

procedure THexLine.TextBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyUp) then OnKeyUp(Sender,Key,Shift);
  Case Key of
    Vk_Left,Vk_Right,Vk_Home,Vk_End:
    begin
      Kurzor:=TextBox.SelStart;
      HexBox.SelStart:=Kurzor*3;
    end;
  end;
  HexBox.SelLength:=TextBox.SelLength*3;
end;

procedure THexLine.TextBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Kurzor:=TextBox.SelStart;
  HexBox.SelStart:=Kurzor*3;
  HexBox.SelLength:=TextBox.SelLength*3;
end;

procedure THexLine.HexBoxKeyPressed(Sender: TObject;var Key: Char);
var cis:integer;
begin
  if Assigned(OnKeyPress) then OnKeyPress(Sender,Key);
  if UpCase(Key) in ['0'..'9','A'..'F'] then
  begin
    Cis:=StrToInt('$'+Key);
    Kurzor:=(HexBox.SelStart+1) div 3;
    if TextBox.SelLength>0 then Delete(Obsah,Kurzor+1,TextBox.SelLength);
    if (HexBox.SelStart mod 3=1)and(Obsah<>'') then
    begin
      Obsah[Kurzor+1]:=char(Byte(Obsah[Kurzor+1])and 240 or Cis);
      Inc(Kurzor);
      UpdateBoxes;
    end else begin
      Insert(char(Cis shl 4),Obsah,Kurzor+1);
      UpdateBoxes;
      HexBox.SelStart:=Kurzor*3+1;
    end;
  end;
  if Key=#3 then begin TextCopy;Key:=#0;end;
  if Key=#24 then begin TextCut;Key:=#0;end;
  if Key=#22 then begin TextPaste;Key:=#0;end;
end;

procedure THexLine.HexBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyDown) then OnKeyDown(Sender,Key,Shift);
  if Shift=[] then case Key of
    Vk_Down:begin TextBox.SetFocus;Key:=0;TextBox.SelStart:=Kurzor;end;
    Vk_Up:Key:=0;
    Vk_Back:if ((Kurzor>0)or(HexBox.SelLength>0))and(Obsah>'') then
    begin
      Kurzor:=(HexBox.SelStart+2) div 3;
      if HexBox.SelLength>0 then Delete(Obsah,Kurzor+1,HexBox.SelLength)
      else begin
        Delete(Obsah,Kurzor,1);
        Dec(Kurzor);
      end;
      UpdateBoxes;
      Key:=0;
    end;
    Vk_Delete:if (Kurzor<Length(Obsah))and(Obsah>'') then
    begin
      Kurzor:=(HexBox.SelStart+1) div 3;
      if HexBox.SelLength>0 then Delete(Obsah,Kurzor+1,HexBox.SelLength)
                            else Delete(Obsah,Kurzor+1,1);
      UpdateBoxes;
      Key:=0;
    end;
  end;
end;

procedure THexLine.HexBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Assigned(OnKeyUp) then OnKeyUp(Sender,Key,Shift);
  Case Key of
    Vk_Left,Vk_Right,Vk_Home,Vk_End:
    begin
      Kurzor:=(HexBox.SelStart+1) div 3;
      TextBox.SelStart:=Kurzor;
    end;
  end;
  TextBox.SelLength:=(HexBox.SelLength+2) div 3;
end;

procedure THexLine.HexBoxMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Kurzor:=(HexBox.SelStart+1) div 3;
  TextBox.SelStart:=Kurzor;
  TextBox.SelLength:=(HexBox.SelLength+1) div 3;
end;

procedure THexLine.BoxesOnEnter(Sender:TObject);
begin
  TextBox.SelLength:=0;
  HexBox.SelLength:=0;
end;

procedure THexLine.SetObsah(s: string);
begin
  Obsah:=s;
  TextBox.SelStart:=0;
  TextBox.SelLength:=0;
  HexBox.SelStart:=0;
  HexBox.SelLength:=0;
  Kurzor:=0;
  UpdateBoxes;
end;

procedure THexLine.Resize;
begin
  inherited Resize;
  if not Assigned(Self.Parent) then exit;
  HexBox.Width:=Width-20;
  TextBox.Width:=Width-20;
end;

procedure THexLine.SetWidth(x:integer);
begin
  SetBounds(Left,Top,x,Height);
  HexBox.Width:=x-20;
  TextBox.Width:=x-20;
end;

procedure Register;
begin
  RegisterComponents('Majk', [THexEdit]);
  RegisterComponents('Majk', [THexLine]);
end;

initialization
  {$I HexControls.lrs}
end.
