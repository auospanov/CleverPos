inherited InspectorForm: TInspectorForm
  Left = 219
  Top = 104
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'InspectorForm'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  inherited btnOk: TBitBtn
    Anchors = [akRight, akBottom]
  end
  inherited btnCancel: TBitBtn
    Anchors = [akRight, akBottom]
  end
  inherited Panel1: TPanel
    Anchors = [akLeft, akTop, akRight, akBottom]
    object Splitter: TSplitter
      Left = 257
      Top = 2
      Height = 389
    end
    object ListView: TListView
      Left = 2
      Top = 2
      Width = 255
      Height = 389
      Align = alLeft
      Columns = <
        item
          Caption = #1050#1086#1084#1087#1086#1085#1077#1085#1090
          Width = 130
        end
        item
          Caption = #1058#1080#1087
          Width = 120
        end>
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnClick = ListViewClick
    end
    object dxRTTIInspector: TdxRTTIInspector
      Left = 260
      Top = 2
      Width = 291
      Height = 389
      Align = alClient
      TabOrder = 1
      DividerPos = 146
      PaintStyle = ipsExtended
      ShowRowHint = True
    end
  end
end
