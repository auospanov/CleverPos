object MDIChildForm: TMDIChildForm
  Left = 293
  Top = 62
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MDI Child Form'
  ClientHeight = 296
  ClientWidth = 435
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clNavy
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poDefault
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object dxBarManagerChild: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = MainDM.imMain
    LookAndFeel.SkinName = ''
    NotDocking = [dsNone, dsLeft, dsRight, dsBottom]
    PopupMenuLinks = <>
    UseFullReset = True
    UseSystemFont = True
    Left = 48
    Top = 112
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManagerChildBar1: TdxBar
      AllowClose = False
      Caption = 'Main'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 271
      FloatTop = 138
      FloatClientWidth = 23
      FloatClientHeight = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButtonEnableAutoSize'
        end>
      OldName = 'Main'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButtonEnableAutoSize: TdxBarButton
      Caption = #1040#1074#1090#1086#1087#1086#1076#1075#1086#1085#1082#1072' '#1086#1082#1085#1072
      Category = 0
      Hint = #1040#1074#1090#1086#1087#1086#1076#1075#1086#1085#1082#1072' '#1086#1082#1085#1072
      Visible = ivAlways
      ImageIndex = 89
    end
  end
  object dxBarPopupMenuChild: TdxBarPopupMenu
    BarManager = dxBarManagerChild
    ItemLinks = <>
    UseOwnFont = False
    Left = 48
    Top = 144
  end
  object alChild: TActionList
    Images = MainDM.imMain
    Left = 16
    Top = 112
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 176
    Top = 120
    PixelsPerInch = 96
    object stlHeader: TcxStyle
    end
  end
end
