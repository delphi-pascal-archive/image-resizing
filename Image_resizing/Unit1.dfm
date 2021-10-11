object Form1: TForm1
  Left = 231
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Image resizing'
  ClientHeight = 529
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 120
  TextHeight = 16
  object Image1: TImage
    Left = 128
    Top = 432
    Width = 57
    Height = 89
    ParentShowHint = False
    ShowHint = False
    Stretch = True
    Transparent = True
  end
  object Image2: TImage
    Left = 8
    Top = 8
    Width = 345
    Height = 385
  end
  object Button2: TButton
    Left = 200
    Top = 464
    Width = 153
    Height = 25
    Caption = 'Centrer'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 200
    Top = 432
    Width = 153
    Height = 25
    Caption = 'Rotation left'
    TabOrder = 1
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 200
    Top = 496
    Width = 153
    Height = 25
    Caption = 'Rotation right'
    TabOrder = 2
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 400
    Width = 345
    Height = 25
    Caption = 'Open image...'
    TabOrder = 3
    OnClick = Button5Click
  end
  object CheckBox1: TCheckBox
    Left = 10
    Top = 462
    Width = 111
    Height = 20
    Caption = 'Transparency'
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object OpenPictureDialog2: TOpenPictureDialog
    Left = 16
    Top = 16
  end
end
