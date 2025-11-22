unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, FMX.Calendar, FMX.Edit, FMX.Layouts, FMX.TabControl, FMX.Objects,
  System.Rtti, System.TypInfo, Generics.Collections, FMXTee.Engine, FMXTee.Procs, FMXTee.Chart
  ;

type
  TForm1 = class(TForm)
    IdUDPClient1: TIdUDPClient;
    TabControl1: TTabControl;
    tbiDial: TTabItem;
    tbiBar: TTabItem;
    ArcDial1: TArcDial;
    ArcDial2: TArcDial;
    ArcDial3: TArcDial;
    ArcDial4: TArcDial;
    ArcDial5: TArcDial;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar3: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    StyleBook1: TStyleBook;
    tbiConfig: TTabItem;
    Layout1: TLayout;
    edtIP: TEdit;
    btnConnect: TButton;
    Layout2: TLayout;
    mCommand: TMemo;
    btnSend: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure ArcDial1Change(Sender: TObject);
    procedure ArcDial2Change(Sender: TObject);
    procedure ArcDial3Change(Sender: TObject);
    procedure ArcDial4Change(Sender: TObject);
    procedure ArcDial5Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
  private
    procedure AtualizarTrackBarAnguloVisual(componentNumber: Integer; angulo: Double);
    procedure AtualizarArcDialAnguloVisual(componentNumber: Integer; angulo: Double);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.ArcDial1Change(Sender: TObject);
begin
  if (ArcDial1.Value > 80) and (ArcDial1.Value <= 170) then
  begin
    IdUDPClient1.Send('s1'+Format('%.3d', [Round(ArcDial1.Value)]));
    AtualizarTrackBarAnguloVisual(1, ArcDial1.Value);
  end;
end;

procedure TForm1.ArcDial2Change(Sender: TObject);
begin
  if ((ArcDial2.Value >= 0) and (ArcDial2.Value <= 180)) then
  begin
    TThread.CreateAnonymousThread(
    procedure
    begin
      IdUDPClient1.Send('s2'+Format('%.3d', [Round(ArcDial2.Value)]));
      AtualizarTrackBarAnguloVisual(2, ArcDial2.Value);
    end).Start;
  end;
end;

procedure TForm1.ArcDial3Change(Sender: TObject);
begin
  if ((ArcDial3.Value >= 0) and (ArcDial3.Value <= 180)) then
  begin
    TThread.CreateAnonymousThread(
    procedure
    begin
      IdUDPClient1.Send('s3'+Format('%.3d', [Round(ArcDial3.Value)]));
      AtualizarTrackBarAnguloVisual(3, ArcDial3.Value);
    end).Start;
  end;
end;

procedure TForm1.ArcDial4Change(Sender: TObject);
begin
  if ((ArcDial4.Value >= 0) and (ArcDial4.Value <= 180)) then
  begin
    TThread.CreateAnonymousThread(
    procedure
    begin
      IdUDPClient1.Send('s4'+Format('%.3d', [Round(ArcDial4.Value)]));
      AtualizarTrackBarAnguloVisual(4, ArcDial4.Value);
    end).Start;
  end;
end;

procedure TForm1.ArcDial5Change(Sender: TObject);
begin
  if ((ArcDial5.Value >= 0) and (ArcDial5.Value <= 180)) then
  begin
    IdUDPClient1.Send('s5'+Format('%.3d', [Round(ArcDial5.Value)]));
    AtualizarTrackBarAnguloVisual(5, ArcDial5.Value);
  end;
end;

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  IdUDPClient1.Active := false;
  IdUDPClient1.Host := edtIP.Text;
  IdUDPClient1.Active := True;
end;

procedure TForm1.btnSendClick(Sender: TObject);
begin
  IdUDPClient1.Send(mCommand.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  IdUDPClient1.Connect;
  ArcDial1.ValueRange.Min := 80;
  ArcDial1.ValueRange.Max := 170;
  ArcDial1.Value := 120;
  ArcDial2.ValueRange.Min := 0;
  ArcDial2.ValueRange.Max := 180;
  ArcDial2.Value := 60;
  ArcDial3.ValueRange.Min := 0;
  ArcDial3.ValueRange.Max := 180;
  ArcDial3.Value := 100;
  ArcDial4.ValueRange.Min := 0;
  ArcDial4.ValueRange.Max := 180;
  ArcDial4.Value := 160;
  ArcDial5.ValueRange.Min := 0;
  ArcDial5.ValueRange.Max := 180;
  ArcDial5.Value := 90;
end;

procedure TForm1.AtualizarTrackBarAnguloVisual(componentNumber: Integer; angulo: Double);
begin
  var componentName := 'TrackBar'+componentNumber.ToString;
  var componentTrack := FindComponent(componentName);
  TTrackBar(componentTrack).Value := angulo;
end;

procedure TForm1.AtualizarArcDialAnguloVisual(componentNumber: Integer; angulo: Double);
begin
  var componentName := 'ArcDial'+componentNumber.ToString;
  var componentArc := FindComponent(componentName);
  TArcDial(componentArc).Value := angulo;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ArcDial1.StylesData['Pie1Style.StartAngle'] := -80;
  ArcDial1.StylesData['Pie1Style.EndAngle'] := -175;

  ArcDial2.StylesData['Pie1Style.StartAngle'] := 0;
  ArcDial2.StylesData['Pie1Style.EndAngle'] := -180;

  ArcDial3.StylesData['Pie1Style.StartAngle'] := 0;
  ArcDial3.StylesData['Pie1Style.EndAngle'] := -180;

  ArcDial4.StylesData['Pie1Style.StartAngle'] := 0;
  ArcDial4.StylesData['Pie1Style.EndAngle'] := -180;

  ArcDial5.StylesData['Pie1Style.StartAngle'] := 0;
  ArcDial5.StylesData['Pie1Style.EndAngle'] := -180;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  if ((TrackBar1.Value >= 80) and (TrackBar1.Value <= 170)) then
  begin
    IdUDPClient1.Send('s1'+Format('%.3d', [Round(TrackBar1.Value)]));
    AtualizarArcDialAnguloVisual(1, TrackBar1.Value);
  end;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  if ((TrackBar2.Value >= 0) and (TrackBar2.Value <= 180)) then
  begin
    IdUDPClient1.Send('s2'+Format('%.3d', [Round(TrackBar2.Value)]));
    AtualizarArcDialAnguloVisual(2, TrackBar2.Value);
  end;
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
  if ((TrackBar3.Value >= 0) and (TrackBar3.Value <= 180)) then
  begin
    IdUDPClient1.Send('s3'+Format('%.3d', [Round(TrackBar3.Value)]));
    AtualizarArcDialAnguloVisual(3, TrackBar3.Value);
  end;
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
  if ((TrackBar4.Value >= 0) and (TrackBar4.Value <= 180)) then
  begin
    IdUDPClient1.Send('s4'+Format('%.3d', [Round(TrackBar4.Value)]));
    AtualizarArcDialAnguloVisual(4, TrackBar4.Value);
  end;
end;

procedure TForm1.TrackBar5Change(Sender: TObject);
begin
  if ((TrackBar5.Value >= 0) and (TrackBar5.Value <= 180)) then
  begin
    IdUDPClient1.Send('s5'+Format('%.3d', [Round(TrackBar5.Value)]));
    AtualizarArcDialAnguloVisual(5, TrackBar5.Value);
  end;
end;

end.
