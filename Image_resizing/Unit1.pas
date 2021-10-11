unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Math, U_Quadrangle, ExtDlgs, Buttons,
  Jpeg;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    OpenPictureDialog2: TOpenPictureDialog;
    CheckBox1: TCheckBox;
    Image2: TImage;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;
implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
begin
Render_centrer(form1,'Image2');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
render_droite(form1,'Image2');
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
render_gauche(form1,'Image2');
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 if OpenPictureDialog2.Execute then begin
  Image1.Picture.LoadFromFile(OpenPictureDialog2.FileName);
  charger_image_base(image1);
  Render_centrer(form1,'Image2');
 end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked=true then
image2.Transparent:=true else image2.Transparent:=false;
end;


procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
entiblock:=true;
end;

end.
