//-------- Bitmap Déformation Quadrangle

unit U_Quadrangle;

interface

uses
  Windows, Graphics, Classes, Math,Dialogs, ExtCtrls, Forms;


type
  TRVBArray = array [0..0] of TRGBTriple;
  pRVBArray = ^TRVBArray;
  TQuadrangle = record A,B,C,D : TPoint; end;

var
  Ox, Oy, Fx, Fy : integer;
  CQuadrangle:TQuadrangle;
  Image_sav_modife:Timage;
  Temps_animation: TTimer;
  entiblock:boolean;
  {renvoi la distance entre deux points}
  function DistValeurs(const A,B:integer):integer;
  {adapte un bitmap à un quadrangle}
  function Distorsion(const AQuadrangle:TQuadrangle;const  ABitmap:TBitmap;const BkColor:TColor):TBitmap;
  procedure charger_image_base(const img_base:Timage);
  procedure Render_centrer(const Fenetre:Tform;const nom_du_Timage_final:string);
  procedure Render_gauche(const Fenetre:Tform;const nom_du_Timage_final:string);
  procedure Render_droite(const Fenetre:Tform;const nom_du_Timage_final:string);
  procedure Render(const Fenetre:Tform;const nom_du_Timage_final:string;const XA,YA,XB,YB,XC,YC,XD,YD:integer);overload;
  procedure Render(const Fenetre:Tform;const nom_du_Timage_final:string;const XA,YA,XB,YB,XC,YC,XD,YD:integer;const Animation:boolean;vitesse:byte);overload;

implementation

function DistValeurs(const A,B:integer):integer;
begin
 if A > B then result := A-B else result := B-A;
end;

procedure charger_image_base(const img_base:Timage);
begin
Image_sav_modife:=img_base;
end;

procedure Render(const Fenetre:Tform;const nom_du_Timage_final:string;const XA,YA,XB,YB,XC,YC,XD,YD:integer);overload;
var
 aBMP: TBitmap;               //nom_image_de_base
 renderbuffer:tbitmap;
 Quadrangle: tquadrangle;
 nom_image_de_base:Tbitmap;
begin
if Image_sav_modife=nil then exit;
 nom_image_de_base:=TBitmap.Create;
 nom_image_de_base.Width:=Timage(fenetre.FindComponent(nom_du_Timage_final)).Width;
 nom_image_de_base.Height:=Timage(fenetre.FindComponent(nom_du_Timage_final)).Height;
 nom_image_de_base.Canvas.Brush.Color:=clblack;
 nom_image_de_base.Canvas.FillRect(nom_image_de_base.Canvas.ClipRect);
 nom_image_de_base.Canvas.StretchDraw(nom_image_de_base.Canvas.ClipRect,Image_sav_modife.Picture.Graphic);
 RenderBuffer:=TBitmap.Create;
 RenderBuffer.Width:=Timage(fenetre.FindComponent(nom_du_Timage_final)).Width;
 RenderBuffer.Height:=Timage(fenetre.FindComponent(nom_du_Timage_final)).Height;
 RenderBuffer.Canvas.Brush.Color:=clblack;
 RenderBuffer.Canvas.FillRect(RenderBuffer.Canvas.ClipRect);
 Quadrangle.A:=Point(XA,YA);
 Quadrangle.B:=Point(XB,YB);
 Quadrangle.C:=Point(XC,YC);
 Quadrangle.D:=Point(XD,YD);
  aBMP := TBitmap(Distorsion(Quadrangle,nom_image_de_base,clblack));
  try RenderBuffer.Canvas.Draw(OX,OY, aBMP);// deformation //
  finally aBMP.Free; end;//liberer aBMP //
  Timage(fenetre.FindComponent(nom_du_Timage_final)).Canvas.StretchDraw(Timage(fenetre.FindComponent(nom_du_Timage_final)).Canvas.ClipRect,RenderBuffer);
  renderbuffer.Free;
  nom_image_de_base.Free;
  CQuadrangle:=Quadrangle;
  end;

procedure Render(const Fenetre:Tform;const nom_du_Timage_final:string;const XA,YA,XB,YB,XC,YC,XD,YD:integer;const Animation:boolean;vitesse:byte);
var
i:integer;
BQuadrangle: tquadrangle;
begin
entiblock:=true;
entiblock:=false;
if Animation=false then Render(fenetre,nom_du_Timage_final,XA,YA,XB,YB,XC,YC,XD,YD);
if Image_sav_modife=nil then exit;
if( (BQuadrangle.A.X=0)and(BQuadrangle.A.Y=0)and(BQuadrangle.B.X=0)and(BQuadrangle.B.Y=0)and(BQuadrangle.C.X=0)and(BQuadrangle.C.Y=0)and(BQuadrangle.D.X=0)and(BQuadrangle.D.Y=0) ) then
Render(fenetre,nom_du_Timage_final,XA,YA,XB,YB,XC,YC,XD,YD)
else
begin
Fenetre.DoubleBuffered:=true;
BQuadrangle:=CQuadrangle;
entiblock:=false;
if vitesse=0 then
vitesse:=1;
if vitesse>10 then
vitesse:=10;
for i := 0 to (Timage(fenetre.FindComponent(nom_du_Timage_final)).Width+Timage(fenetre.FindComponent(nom_du_Timage_final)).Height)*2 do
begin
if( (BQuadrangle.A.X=XA)and(BQuadrangle.A.Y>=YA)and(BQuadrangle.B.X>=XB)and(BQuadrangle.B.Y>=YB)and(BQuadrangle.C.X=XC)and(BQuadrangle.C.Y>=YC)and(BQuadrangle.D.X>=XD)and(BQuadrangle.D.Y>=YD) ) then
break;
if entiblock=true then exit;
if  BQuadrangle.A.X>XA then dec(BQuadrangle.A.X,vitesse);if  BQuadrangle.A.X<XA then inc(BQuadrangle.A.X,vitesse);
if  BQuadrangle.A.Y>YA then dec(BQuadrangle.A.Y,vitesse);if  BQuadrangle.A.Y<YA then inc(BQuadrangle.A.Y,vitesse);
if  BQuadrangle.B.X>XB then dec(BQuadrangle.B.X,vitesse);if  BQuadrangle.B.X<XB then inc(BQuadrangle.B.X,vitesse);
if  BQuadrangle.B.Y>YB then dec(BQuadrangle.B.Y,vitesse);if  BQuadrangle.B.Y<YB then inc(BQuadrangle.B.Y,vitesse);
if  BQuadrangle.C.X>XC then dec(BQuadrangle.C.X,vitesse);if  BQuadrangle.C.X<XC then inc(BQuadrangle.C.X,vitesse);
if  BQuadrangle.C.Y>YC then dec(BQuadrangle.C.Y,vitesse);if  BQuadrangle.C.Y<YC then inc(BQuadrangle.C.Y,vitesse);
if  BQuadrangle.D.X>XD then dec(BQuadrangle.D.X,vitesse);if  BQuadrangle.D.X<XD then inc(BQuadrangle.D.X,vitesse);
if  BQuadrangle.D.Y>YD then dec(BQuadrangle.D.Y,vitesse);if  BQuadrangle.D.Y<YD then inc(BQuadrangle.D.Y,vitesse);
Render(fenetre,nom_du_Timage_final,BQuadrangle.A.X,BQuadrangle.A.Y,BQuadrangle.B.X,BQuadrangle.B.Y,BQuadrangle.C.X,BQuadrangle.C.Y,BQuadrangle.D.X,BQuadrangle.D.Y);
Fenetre.Refresh;
Application.ProcessMessages;
sleep(10);
end;
end;
end;

procedure Render_centrer(const Fenetre:Tform;const nom_du_Timage_final:string);
begin
Render(fenetre,nom_du_Timage_final,0,0,Timage(fenetre.FindComponent(nom_du_Timage_final)).Width,0,Timage(fenetre.FindComponent(nom_du_Timage_final)).Width,Timage(fenetre.FindComponent(nom_du_Timage_final)).Height,0,Timage(fenetre.FindComponent(nom_du_Timage_final)).Height,true,8);
end;

procedure Render_gauche(const Fenetre:Tform;const nom_du_Timage_final:string);
begin
Render(fenetre,nom_du_Timage_final,trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Width)*2/4),trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Height)*1/6),Timage(fenetre.FindComponent(nom_du_Timage_final)).Width,0,Timage(fenetre.FindComponent(nom_du_Timage_final)).Width,Timage(fenetre.FindComponent(nom_du_Timage_final)).Height,trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Width)*2/4),trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Height)*3/4),true,8);
end;

procedure Render_droite(const Fenetre:Tform;const nom_du_Timage_final:string);
begin
Render(fenetre,nom_du_Timage_final,0,0,trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Width)*2/4),trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Height)*1/6),trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Width)*2/4),trunc((Timage(fenetre.FindComponent(nom_du_Timage_final)).Height)*3/4),0,Timage(fenetre.FindComponent(nom_du_Timage_final)).Height,true,8);
end;

function Distorsion(const AQuadrangle:TQuadrangle;const ABitmap:TBitmap;const BkColor:TColor):TBitmap;
var
 TabScanLine, TSLFinal : array of pRVBArray;
 BmpOrigin : TBitmap;
 BmpFinal : TBitmap;
 v, u, x, y, xd, yd : integer;
 RQWidth, RQHeight : integer;
 TauxY, TauxX : real;
 DistAB, DistDC, PosXAB, PosXDC : real;
 DistAD, DistBC, PosYAD, PosYBC : real;
 TmpX, TmpY : real;
 // pour l'anti-aliasing des contours
 nbPxC, PosPxC:integer; // nombre de pixels du contour
 TPxC:array of array of integer; // tableau de la position des pixels du contour
 RVB, bkRVB : TRGBTriple;
 Mxdyd, Nx, Ny:integer; // max de xd,yd
begin
   {$R-} {$RANGECHECKS OFF}
 PosPxC:=0;
 Mxdyd:=0;
//--récupérer la couleur d'arrière plan
 bkRVB.rgbtBlue:=GetBValue(ColorToRGB(BkColor));
 bkRVB.rgbtRed:=GetRValue(ColorToRGB(BkColor));
 bkRVB.rgbtGreen:=GetGValue(ColorToRGB(BkColor));

//--calcul de la zone rectangle (rectangle maitre) contenant le quadrangle
 Ox := min(min(AQuadrangle.A.X,AQuadrangle.B.X),min(AQuadrangle.C.X,AQuadrangle.D.X));
 Oy := min(min(AQuadrangle.A.Y,AQuadrangle.B.Y),min(AQuadrangle.C.Y,AQuadrangle.D.Y));
 Fx := max(max(AQuadrangle.A.X,AQuadrangle.B.X),max(AQuadrangle.C.X,AQuadrangle.D.X));
 Fy := max(max(AQuadrangle.A.Y,AQuadrangle.B.Y),max(AQuadrangle.C.Y,AQuadrangle.D.Y));
 RQWidth := Fx-Ox;
 RQHeight := Fy-Oy;

//--création d'une copie du bitmap d'origine
 BmpOrigin := TBitmap.Create;
 BmpOrigin.HandleType := bmDIB;
 BmpOrigin.PixelFormat := pf24Bit;
 BmpOrigin.Height := RQHeight;
 BmpOrigin.Width := RQWidth;

//--création du bitmap final qui sera transféré à "result"
 BmpFinal := TBitmap.Create;
 BmpFinal.HandleType := bmDIB;
 BmpFinal.PixelFormat := pf24Bit;
 BmpFinal.Height := RQHeight;
 BmpFinal.Width := RQWidth;
 BmpFinal.Canvas.Brush.Color := BkColor;
 BmpFinal.Canvas.FillRect(rect(0,0,RQWidth,RQHeight));

//--mise à l'échelle du bitmap d'origine par rapport au rectangle maitre
 BmpOrigin.Canvas.StretchDraw(rect(0,0,RQWidth,RQHeight),ABitmap);

 nbPxC:=(RQWidth+RQHeight)*2; //nombre de pixels du contour de l'image

//--définir la taille des tableaux dynamiques
 SetLength(TabScanLine,BmpOrigin.Height);

 SetLength(TSLFinal,BmpFinal.Height);

 SetLength(TPxC,nbPxC,2);

// transférer les données (pixels) dans chaque tableau
 For v:=0  to  RQHeight-1  do begin
  // transférer les information de l'image dans les tableaux
  TabScanLine[v] := BmpOrigin.ScanLine[v];
  TSLFinal[v] := BmpFinal.ScanLine[v];
 end;

//--Transférer les pixels au bon endroit
  DistAD := AQuadrangle.D.Y-AQuadrangle.A.Y;
  DistBC := AQuadrangle.C.Y-AQuadrangle.B.Y;
  DistAB := AQuadrangle.B.X-AQuadrangle.A.X;
  DistDC := AQuadrangle.C.X-AQuadrangle.D.X;

 {Pour chaque pixel, calcule le taux de positionnement de x et y
  et transfère les pixels au bon emplacement}
 For v:=1 to BmpOrigin.Height-1 do begin
  TauxY := v / BmpOrigin.Height;
  PosYAD := AQuadrangle.A.Y-OY+(DistAD*TauxY);
  PosYBC := AQuadrangle.B.Y-OY+(DistBC*TauxY);

  For u := 1 to BmpOrigin.Width-1 do begin
   TauxX := u / BmpOrigin.Width;
   PosXAB := AQuadrangle.A.X-OX+(DistAB*TauxX);
   PosXDC := AQuadrangle.D.X-OX+(DistDC*TauxX);

   TmpX := PosXAB+(PosXDC-PosXAB)*TauxY;
   TmpY := PosYAD+(PosYBC-PosYAD)*TauxX;

   x := round(Int(TmpX));
   y := Round(Int(TmpY));

   xd := Round(Frac(TmpX)*10);
   yd := Round(Frac(TmpY)*10);

   {Si c'est un pixel du contour, on applique un anti-aliasing}
   if (v=1) or (v=BmpOrigin.Height-1) or (u=1) or (u=BmpOrigin.Width-1) then begin
    if (v=1) or (u=1) then Mxdyd:=(xd+yd);
    if (v=BmpOrigin.Height-1) or (u=BmpOrigin.Width-1) then Mxdyd:=20-(xd+yd);
    RVB.rgbtBlue:=TabScanLine[v,u].rgbtBlue+((bkRVB.rgbtBlue-TabScanLine[v,u].rgbtBlue)*(Mxdyd) div 20);
    RVB.rgbtGreen:=TabScanLine[v,u].rgbtGreen+((bkRVB.rgbtGreen-TabScanLine[v,u].rgbtGreen)*(Mxdyd) div 20);
    RVB.rgbtRed:=TabScanLine[v,u].rgbtRed+((bkRVB.rgbtRed-TabScanLine[v,u].rgbtRed)*(Mxdyd) div 20);
    if RVB.rgbtBlue>254 then RVB.rgbtBlue:=255;
    if RVB.rgbtGreen>254 then RVB.rgbtGreen:=255;
    if RVB.rgbtRed>254 then RVB.rgbtRed:=255;

    TSLFinal[y,x].rgbtBlue:=RVB.rgbtBlue;
    TSLFinal[y,x].rgbtGreen:=RVB.rgbtGreen;
    TSLFinal[y,x].rgbtRed:=RVB.rgbtRed;

   end else begin

   {[Modification proposé par CIREC Administrateur CS]
    valeurs RGB des pixels inchangées, pas utile de les affecter individuellement}

   TSLFinal[y,x] := TabScanLine[v,u];
   //pour lever les "trous..."
   If (xd<5) then x:=x-1;  if x<0 then x:=0;
   If (yd<5) then y:=y-1;  if y<0 then y:=0;
   TSLFinal[y,x] := TabScanLine[v,u];

   end;

  end;
 end;

//--assigne le bitmap final au "result"
 result := TBitmap.create;
 Result.Assign(bmpFinal);
 bmpFinal.Free;
 BmpOrigin.free;
   {$R-} {$RANGECHECKS ON}

 end;

end.
