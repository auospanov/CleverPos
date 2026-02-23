inherited SmsRecipsForm: TSmsRecipsForm
  Caption = #1042#1099#1073#1086#1088' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1077#1081
  ClientHeight = 501
  ClientWidth = 669
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 675
  ExplicitHeight = 527
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 656
    Height = 459
    ExplicitWidth = 656
    ExplicitHeight = 459
    object Panel3: TPanel
      Left = 2
      Top = 49
      Width = 652
      Height = 408
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Caption = 'Panel3'
      ParentColor = True
      TabOrder = 0
      object Panel4: TPanel
        Left = 313
        Top = 1
        Width = 338
        Height = 406
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel4'
        ParentColor = True
        TabOrder = 2
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 338
          Height = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelKind = bkTile
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object Image1: TImage
            Left = 123
            Top = 11
            Width = 25
            Height = 20
            Picture.Data = {
              0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
              0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
              4D410000B18F0BFC61050000000B744558745469746C65005A6F6F6D3BCF09FE
              BC0000037949444154384F75935D4C534918860734A289AEDE98EC8D1ABDD068
              5CBDC185AC8A4140226EB4E05F1A5C08016503A8093536422962819E0D5A8145
              4111B5D8020BA54B0B2BEB4A487FE0D0160BB5FC28086214818AB5C2024291BC
              CE69D13B27F9329973BEF79977BEF98600205CD0B1E4EA4D8DFFDD2AB656AEB2
              8CC86B9FE07E8DC551AA346AB3F29441F4FF321A3E5FF3C57FD4721AE2118745
              9CF4BBA53064A91EDADDCF07DF616A7A8E7E86677E36E080426DF99C2D53E7FB
              0786ADA1125F4E73214BE905703B973CD067FF67E8837B7E01FFB2AF212E6E47
              7C960E19746E687985E919372AEBCC104A1495347F05E7244958E6555F2B6EF8
              B9BADEE6FE343B0FE65E2752656D60AD0EFCD3E6C4A57B8338CD98905DD68171
              D734A47FD6831F7F258ACA96C69DBBE90514CB8D75DD7DA368A43BA7E69B30E9
              726378740E5D8333D09A26C0FC3D8E149919D58F07D0A8EB426C724113E7827F
              46E605DC901B46B8B35E286261B48E61786C0EF697333074FF0F6DFB47C81AC7
              51D8F816A905ADE81B1A477462FE072A5B1519C310EDE90042F2EFE8F0796101
              B1D2663CEA74C23E340D7DEF241A3A27A0609D28D5BF4785C985C43C1D864626
              702C2E8FBBB2D5BFF225E461CA3E4298A2478EC9A959084ADA20AC79891AAB0B
              1ADB47C8CD4EDC66DFE3AF4E1714660784A52674F48E800A273840F8B14CD290
              B4979074A95A65EE1842959E16ACC40C49F31818A303C516272ABB5CA8EB9B84
              54D3838AE6172857B5228427D453C0CAD04811D124EE2124E17C61848851537B
              2E882AAC482EB7E2AAE10DCA7B9CB86B1DC5154D1718B50D969E511C8D65E0BF
              37268102FC427869449DB0DB5347BFDF928B2A98C27AD8FA1D90EBFA9156D58E
              33A52D10573F81D23000D6FE1649176F4398240073685B0ED5FC40C3B726EE17
              0FC067D396803587F9928298941B0B72150BF6E930EC834EB4DA5EE3965207DE
              A91C8893CF61B6BB04EDB268E4846FCDE66E82837C7D07BE74B13C3034F100B5
              D6141695391B1A9549CF9BE10E8A10E877069EE48BF66D941A724F0036066DB9
              9110076F66B8627A008B8FC987EB30AE4916E9AB3D09B460DC3139DB828075B9
              4DA208A04500A3E80024E1DB73C87EDE6512CCCB24C14732688848F0E1F4C548
              A3EB34B2FFC8254F78EC52C8EF3B7E64B467F7604E138DB2E3FE53DE76FCCE50
              46EF22D2A00D44B27B3DB91CB8FE1B2466F35AC9F5B06DF3CCC19F945F004BAC
              201E7CD0E8350000000049454E44AE426082}
          end
          object cbClientAll: TCheckBox
            Left = 9
            Top = 12
            Width = 96
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1089#1077' '#1082#1083#1080#1077#1085#1090#1099
            Checked = True
            Enabled = False
            State = cbChecked
            TabOrder = 1
            OnClick = cbClientAllClick
          end
          object edSearch: TEdit
            Left = 145
            Top = 10
            Width = 184
            Height = 22
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            CharCase = ecLowerCase
            TabOrder = 0
            OnChange = edSearchChange
          end
        end
        inline frmClientFrame: TGridFrame
          Left = 0
          Top = 41
          Width = 338
          Height = 365
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          ExplicitTop = 41
          ExplicitWidth = 338
          ExplicitHeight = 365
          inherited grMain: TcxGrid
            Width = 338
            Height = 365
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Enabled = False
            ExplicitWidth = 338
            ExplicitHeight = 365
            inherited tvMain: TcxGridDBTableView
              DataController.KeyFieldNames = 'ID'
              inherited clmMainColumn2: TcxGridDBColumn
                DataBinding.FieldName = 'NAME'
                Width = 397
              end
              inherited clmMainColumn3: TcxGridDBColumn
                DataBinding.FieldName = 'ID'
              end
            end
          end
          inherited spReadFrame: TpFIBDataSet
            SelectSQL.Strings = (
              'SELECT G_CLIENT ID,'
              '       NAME||'#39', '#39'||COALESCE(PHONE, '#39#39') NAME'
              '  FROM G_CLIENT'
              'WHERE IS_CATEGORY = 0'
              'AND IS_SUPPLIER = 0'
              
                'AND (CAST(:G_CATEGORY_ AS VARCHAR(1000)) CONTAINING '#39'~'#39'||G_CLIEN' +
                'T_PARENT ||'#39'~'#39
              '     OR '
              '     CAST(:G_CATEGORY_ AS VARCHAR(1000)) = '#39'~'#39')'
              'ORDER BY 2')
          end
        end
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 304
        Height = 406
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel4'
        ParentColor = True
        TabOrder = 0
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 304
          Height = 41
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelKind = bkTile
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          object cbCatAll: TCheckBox
            Left = 8
            Top = 12
            Width = 89
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = #1042#1089#1077' '#1075#1088#1091#1087#1087#1099
            Checked = True
            State = cbChecked
            TabOrder = 0
            OnClick = cbCatAllClick
          end
        end
        inline ClientCatFrame: TTreeFrame
          Left = 0
          Top = 41
          Width = 304
          Height = 365
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 1
          ExplicitTop = 41
          ExplicitWidth = 304
          ExplicitHeight = 365
          inherited tlCommon: TcxDBTreeList
            Width = 304
            Height = 365
            Margins.Left = 3
            Margins.Top = 3
            Margins.Right = 3
            Margins.Bottom = 3
            DataController.ParentField = 'ID_PAR'
            DataController.KeyField = 'ID'
            Enabled = False
            Styles.Inactive = MainDM.stGridSelectedRow
            OnMouseDown = ClientCatFrametlCommonMouseDown
            ExplicitWidth = 304
            ExplicitHeight = 365
            inherited cxDBTreeListColumn2: TcxDBTreeListColumn
              DataBinding.FieldName = 'NAME'
            end
            inherited tlSkladcxDBTreeListColumn1: TcxDBTreeListColumn
              DataBinding.FieldName = 'ID'
            end
          end
          inherited spReadFrame: TpFIBDataSet
            SelectSQL.Strings = (
              'SELECT G_CLIENT ID,'
              '            G_CLIENT_PARENT ID_PAR,'
              '            NAME'
              '  FROM G_CLIENT'
              'WHERE IS_CATEGORY = 1'
              'AND IS_SUPPLIER = 0')
          end
        end
      end
      object splMenu: TcxSplitter
        Left = 305
        Top = 1
        Width = 8
        Height = 406
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        HotZoneClassName = 'TcxSimpleStyle'
        HotZone.SizePercent = 32
        AutoPosition = False
        PositionAfterOpen = 150
        AutoSnap = True
        ResizeUpdate = True
        Control = Panel4
        Color = clBtnFace
        ParentColor = False
      end
    end
    object pn1: TPanel
      Left = 2
      Top = 2
      Width = 652
      Height = 47
      Align = alTop
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 1
      object cbChoice: TcxComboBox
        Left = 16
        Top = 13
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          
            #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077#1093', '#1082#1090#1086' '#1089#1086#1075#1083#1072#1089#1080#1083#1089#1103' '#1087#1086#1083#1091#1095#1072#1090#1100' '#1091#1074#1077#1076#1086#1084#1083#1077#1085#1080#1103' '#1086#1073' '#1072#1082#1094#1080#1103#1093' '#1080' '#1089#1082 +
            #1080#1076#1082#1072#1093
          #1042#1099#1073#1088#1072#1090#1100' '#1074#1089#1077#1093', '#1091' '#1082#1086#1075#1086' '#1089#1077#1075#1086#1076#1085#1103' '#1076#1077#1085#1100' '#1088#1086#1078#1076#1077#1085#1080#1103
          #1042#1099#1073#1088#1072#1090#1100' '#1074#1088#1091#1095#1085#1091#1102)
        Properties.OnChange = cb1PropertiesChange
        Style.StyleController = dxEditStyleController
        TabOrder = 0
        Width = 625
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 497
    Top = 470
    ExplicitLeft = 497
    ExplicitTop = 470
  end
  inherited btnCancel: TcxButton
    Left = 584
    Top = 470
    ExplicitLeft = 584
    ExplicitTop = 470
  end
  inherited btHelp: TcxButton
    Top = 470
    ExplicitTop = 470
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object tmrClient: TTimer
    Enabled = False
    Interval = 400
    OnTimer = tmrClientTimer
    Left = 360
    Top = 312
  end
end
