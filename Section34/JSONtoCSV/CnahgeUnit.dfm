object ChangeForm: TChangeForm
  Left = 0
  Top = 0
  Caption = 'ChangeForm'
  ClientHeight = 44
  ClientWidth = 149
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ChangeBTN: TButton
    Left = 8
    Top = 8
    Width = 129
    Height = 25
    Caption = 'JSON -> CSV'
    TabOrder = 0
    OnClick = ChangeBTNClick
  end
end
