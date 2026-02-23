inherited UpgradeDBForm: TUpgradeDBForm
  Left = 724
  Top = 302
  BorderStyle = bsDialog
  Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 277
  ClientWidth = 451
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  ExplicitWidth = 457
  ExplicitHeight = 303
  DesignSize = (
    451
    277)
  PixelsPerInch = 96
  TextHeight = 14
  inherited Panel1: TPanel
    Width = 435
    Height = 233
    ExplicitWidth = 435
    ExplicitHeight = 233
    object Panel2: TPanel
      Left = 2
      Top = 2
      Width = 431
      Height = 63
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 431
        Height = 63
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Alignment = taCenter
        Caption = 
          #1042#1072#1096#1072' '#1073#1072#1079#1072' '#1076#1072#1085#1085#1099#1093' '#1085#1091#1078#1076#1072#1077#1090#1089#1103' '#1074' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1080'. '#1055#1088#1086#1094#1077#1089#1089' '#1079#1072#1087#1091#1097#1077#1085'. '#1053#1077' '#1079#1072#1082 +
          #1088#1099#1074#1072#1081#1090#1077' '#1080' '#1085#1077' '#1087#1099#1090#1072#1081#1090#1077#1089#1100' '#1086#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1088#1086#1094#1077#1089#1089
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clNavy
        Font.Height = -17
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 423
      end
    end
    object Panel3: TPanel
      Left = 2
      Top = 65
      Width = 431
      Height = 166
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 1
      object Panel4: TPanel
        Left = 0
        Top = 145
        Width = 431
        Height = 21
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alBottom
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object ProgressBar: TProgressBar
          Left = 0
          Top = 0
          Width = 431
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          TabOrder = 0
        end
      end
      object mLog: TcxMemo
        Left = 0
        Top = 0
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Style.StyleController = dxEditStyleController
        TabOrder = 0
        Height = 145
        Width = 431
      end
    end
  end
  inherited btnOk: TcxButton
    Left = 286
    Top = 243
    ExplicitLeft = 286
    ExplicitTop = 243
  end
  inherited btnCancel: TcxButton
    Left = 368
    Top = 243
    ExplicitLeft = 368
    ExplicitTop = 243
  end
  object mScriptIBEBlock28: TMemo [3]
    Left = -1533
    Top = 448
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_ADDRESS,G_FIRM_R' +
        'EKVIZIT,G_OFFICIAL,G_PAYMENT_TYPE,G_PRIHOD_RASHOD,G_PRODUCT,G_TO' +
        'CHKA,G_UNIT,INVOICE,INVOICE_PAY,KASSA,KASSA_BEZNAL,'
      
        'KASSA_BEZNAL_STATE,KASSA_STATE,LT_PRODUCT_TOCHKA,LT_SKLAD_PRODUC' +
        'T,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE,P_REP_PRIHOD_TABLE,P_REP_' +
        'PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE,P_REP_TOVAR_MOVE_TABLE,P' +
        '_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD,'
      
        'SKLAD_PARENT,SKLAD_TMP,SPISANIE,SPISANIE_TMP,WAYBILL,ZAKAZ,ZAKAZ' +
        '_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL,ZAKAZ_NA_REAL,' +
        'ZAKAZ_REAL_PARENT'#39','
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_ADDRESS,G_FIRM_R' +
        'EKVIZIT,G_OFFICIAL,G_PAYMENT_TYPE,G_PRIHOD_RASHOD,G_PRODUCT,G_TO' +
        'CHKA,G_UNIT,INVOICE,INVOICE_PAY,KASSA,KASSA_BEZNAL,'
      
        'KASSA_BEZNAL_STATE,KASSA_STATE,LT_PRODUCT_TOCHKA,LT_SKLAD_PRODUC' +
        'T,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE,P_REP_PRIHOD_TABLE,P_REP_' +
        'PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE,P_REP_TOVAR_MOVE_TABLE,P' +
        '_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD,'
      
        'SKLAD_PARENT,SKLAD_TMP,SPISANIE,SPISANIE_TMP,WAYBILL,ZAKAZ,ZAKAZ' +
        '_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL,ZAKAZ_NA_REAL,' +
        'ZAKAZ_REAL_PARENT'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  SELECT MAX(ZAKAZ_DETAILS)'
      '    FROM ZAKAZ_DETAILS'
      '    INTO :ZAK_;'
      ''
      '  SELECT MAX(SKLAD)'
      '    FROM SKLAD'
      '    INTO :SKL_;'
      ''
      '  MAXX = MAXVALUE(ZAK_, SKL_);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :MAXX |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;')
    ParentFont = False
    TabOrder = 4
    Visible = False
  end
  object mScriptIBEBlock37: TMemo [4]
    Left = -1525
    Top = 419
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      '                       '
      
        #39'CUR_G_OFFICIAL,G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT' +
        ',G_BANK,G_CLIENT,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,G_UNIT,INVOICE,'
      
        'INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,LT' +
        '_PRODUCT_TOCHKA,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_' +
        'TABLE,P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT' +
        '_TABLE,P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,'
      
        'REVISION,SKLAD,SKLAD_PARENT,SKLAD_TMP,SPISANIE,SPISANIE_TMP,WAYB' +
        'ILL,ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL' +
        ',ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      ''
      
        #39'CUR_G_OFFICIAL,G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT' +
        ',G_BANK,G_CLIENT,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,G_UNIT,INVOICE,'
      
        'INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,LT' +
        '_PRODUCT_TOCHKA,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_' +
        'TABLE,P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT' +
        '_TABLE,P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,'
      
        'REVISION,SKLAD,SKLAD_PARENT,SKLAD_TMP,SPISANIE,SPISANIE_TMP,WAYB' +
        'ILL,ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL' +
        ',ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  SELECT MAX(ZAKAZ_DETAILS)'
      '    FROM ZAKAZ_DETAILS'
      '    INTO :ZAK_;'
      ''
      '  SELECT MAX(SKLAD)'
      '    FROM SKLAD'
      '    INTO :SKL_;'
      ''
      '  MAXX = MAXVALUE(ZAK_, SKL_);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :MAXX |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;')
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
  object mScriptIBEBlock50: TMemo [5]
    Left = -1541
    Top = 450
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      '                       '
      
        #39'CUR_G_OFFICIAL,G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT' +
        ',G_BANK,G_CLIENT,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,G_UNIT,INVOICE,'
      
        'INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,LT' +
        '_PRODUCT_TOCHKA,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_' +
        'TABLE,P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT' +
        '_TABLE,P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,'
      
        'REVISION,SKLAD,SKLAD_PARENT,SKLAD_TMP,SPISANIE,SPISANIE_TMP,WAYB' +
        'ILL,ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL' +
        ',ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      ''
      
        #39'CUR_G_OFFICIAL,G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT' +
        ',G_BANK,G_CLIENT,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,G_UNIT,INVOICE,'
      
        'INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,LT' +
        '_PRODUCT_TOCHKA,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_' +
        'TABLE,P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT' +
        '_TABLE,P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,'
      
        'REVISION,SKLAD,SKLAD_PARENT,SKLAD_TMP,SPISANIE,SPISANIE_TMP,WAYB' +
        'ILL,ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL' +
        ',ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  SELECT MAX(ZAKAZ_DETAILS)'
      '    FROM ZAKAZ_DETAILS'
      '    INTO :ZAK_;'
      ''
      '  SELECT MAX(SKLAD)'
      '    FROM SKLAD'
      '    INTO :SKL_;'
      ''
      '  MAXX = MAXVALUE(ZAK_, SKL_);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BILL TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :MAXX |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;')
    ParentFont = False
    TabOrder = 5
    Visible = False
  end
  object mScriptIBEBlock60: TMemo [6]
    Left = -1541
    Top = 500
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      '                       '
      
        #39'CUR_G_OFFICIAL,G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT' +
        ',G_BANK,G_CLIENT,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,G_FIRM_A' +
        'CCOUNT,G_FIRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGH' +
        'T,G_PAYMENT_TYPE,G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,'
      
        'G_UNIT,INVOICE,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE' +
        ',KASSA_STATE,LT_PRODUCT_TOCHKA,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_' +
        'REP_PRICE_LIST_TABLE,P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP' +
        '_RASHODY_PROFIT_TABLE,'
      'P_REP_TOVAR_MOVE_TABLE, '
      
        'P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD,SKLAD_PARENT,SKLAD_TMP,' +
        'SYSTEM_SETUP,UPLOAD_TABLE_TMP,WAYBILL,ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_' +
        'DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARE' +
        'NT'#39','
      ''
      
        #39'CUR_G_OFFICIAL,G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT' +
        ',G_BANK,G_CLIENT,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,G_FIRM_A' +
        'CCOUNT,G_FIRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGH' +
        'T,G_PAYMENT_TYPE,G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,'
      
        'G_UNIT,INVOICE,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE' +
        ',KASSA_STATE,LT_PRODUCT_TOCHKA,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_' +
        'REP_PRICE_LIST_TABLE,P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP' +
        '_RASHODY_PROFIT_TABLE,'
      'P_REP_TOVAR_MOVE_TABLE,'
      
        'P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD,SKLAD_PARENT,SKLAD_TMP,' +
        'SYSTEM_SETUP,UPLOAD_TABLE_TMP,WAYBILL,ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_' +
        'DETAILS_TMP,ZAKAZ_DETAILS_TMP_REAL,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARE' +
        'NT'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  SELECT MAX(ZAKAZ_DETAILS)'
      '    FROM ZAKAZ_DETAILS'
      '    INTO :ZAK_;'
      ''
      '  SELECT MAX(SKLAD)'
      '    FROM SKLAD'
      '    INTO :SKL_;'
      ''
      '  MAXX = MAXVALUE(ZAK_, SKL_);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BILL TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCONT_CARD, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCONT_CARD TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_UPLOAD_TABLE_TMP, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_UPLOAD_TABLE_TMP TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :MAXX |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;')
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object mScriptiBEBlock: TMemo [7]
    Left = 10
    Top = 520
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=AIDYN; Password=osjadf09; Nam' +
        'es=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_etalon.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=AIDYN; Password=osjadf09; Nam' +
        'es=; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      '                       '
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_ADDRESS,G_FIRM_R' +
        'EKVIZIT,G_OFFICIAL,G_PRIHOD_RASHOD,G_PRODUCT,G_UNIT,INVOICE,INVO' +
        'ICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE'
      
        ',LT_SKLAD_PRODUCT,SKLAD,SKLAD_PARENT,SPISANIE,ZAKAZ,ZAKAZ_DETAIL' +
        'S,ZAKAZ_NA_REAL'#39','
      '                       '
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_ADDRESS,G_FIRM_R' +
        'EKVIZIT,G_OFFICIAL,G_PRIHOD_RASHOD,G_PRODUCT,G_UNIT,INVOICE,INVO' +
        'ICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE'
      
        ',LT_SKLAD_PRODUCT,SKLAD,SKLAD_PARENT,SPISANIE,ZAKAZ,ZAKAZ_DETAIL' +
        'S,ZAKAZ_NA_REAL'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  SELECT MAX(ZAKAZ_DETAILS)'
      '    FROM ZAKAZ_DETAILS'
      '    INTO :ZAK_;'
      ''
      '  SELECT MAX(SKLAD)'
      '    FROM SKLAD'
      '    INTO :SKL_;'
      ''
      '  MAXX = MAXVALUE(ZAK_, SKL_);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :MAXX |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;')
    ParentFont = False
    TabOrder = 8
  end
  object mScriptIBEBlock104: TMemo [8]
    Left = -1549
    Top = 500
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,G_UNIT,INVOICE,INVOICE_PAY,KA' +
        'SSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,LT_BARCODE,LT_BA' +
        'RCODE_TMP,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE,'
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SKLAD_TMP,SYSTEM_SETUP,UPLOAD_TABLE_TMP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP1,ZAKAZ_D' +
        'ETAILS_TMP_REAL,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_TOCHKA,G_UNIT,INVOICE,INVOICE_PAY,KA' +
        'SSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,LT_BARCODE,LT_BA' +
        'RCODE_TMP,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE,'
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SKLAD_TMP,SYSTEM_SETUP,UPLOAD_TABLE_TMP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_DETAILS_TMP,ZAKAZ_DETAILS_TMP1,ZAKAZ_D' +
        'ETAILS_TMP_REAL,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BILL TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_DETAILS_TMP, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCONT_CARD, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCONT_CARD TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_TOCHKA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_TOCHKA TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_BARCODE, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_BARCODE TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_SKLAD_TRANS, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_SKLAD_TRANS TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_TRANS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_TRANS_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_UPLOAD_TABLE_TMP, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_UPLOAD_TABLE_TMP TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;')
    ParentFont = False
    TabOrder = 6
    Visible = False
  end
  object mScriptIBEBlockUpdCost: TMemo [9]
    Left = -1549
    Top = 550
    Width = 2000
    Height = 64
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      
        '  SELECT S_VALUE FROM SYSTEM_SETUP S WHERE S.SYSTEM_SETUP = 1 IN' +
        'TO :FORMULA_;'
      ''
      '  FOR SELECT ZD.ZAKAZ_DETAILS,'
      '             Z.Z_DATE,'
      '             Z.G_TOCHKA,'
      '             ZD.G_PRODUCT'
      '        FROM ZAKAZ_DETAILS ZD,'
      '             ZAKAZ Z'
      '       WHERE Z.ZAKAZ = ZD.ZAKAZ'
      '       ORDER BY ZAKAZ_DETAILS'
      '        INTO :ZAKAZ_DETAILS_,'
      '             :Z_DATE_,'
      '             :G_TOCHKA_,'
      '             :G_PRODUCT_'
      '  DO BEGIN'
      '    IF (FORMULA_ = 0) THEN BEGIN'
      '        SELECT ROUND(SUM(T.AMOUNT * T.PRICE)/SUM(T.AMOUNT), 2)'
      '        FROM (SELECT S.AMOUNT, S.PRICE'
      '                FROM SKLAD_PARENT SP,'
      '                     SKLAD S'
      '               WHERE SP.G_TOCHKA = :G_TOCHKA_'
      '                 AND SP.DATE_RECEIPT <= :Z_DATE_'
      '                 AND SP.SKLAD = S.SKLAD_PARENT'
      '                 AND S.G_PRODUCT = :G_PRODUCT_'
      '                 AND SP.IS_VOZVRAT IN (0, 3)'
      '                ORDER BY S.DATE_RECEIPT DESC ROWS 1 TO 5) T'
      '          INTO :COST_PRICE_;'
      '    END ELSE BEGIN'
      '        SELECT S.PRICE'
      '          FROM SKLAD S'
      '         WHERE S.SKLAD = (SELECT MAX(SS.SKLAD)'
      '                            FROM SKLAD SS'
      '                           WHERE SS.G_TOCHKA = :G_TOCHKA_'
      '                             AND SS.G_PRODUCT = :G_PRODUCT_'
      
        '                             AND SS.DATE_RECEIPT = (SELECT MAX(S' +
        'SS.DATE_RECEIPT)'
      
        '                                                      FROM SKLAD' +
        ' SSS'
      
        '                                                     WHERE SSS.G' +
        '_TOCHKA = :G_TOCHKA_'
      
        '                                                       AND SSS.G' +
        '_PRODUCT = :G_PRODUCT_'
      
        '                                                       AND SSS.D' +
        'ATE_RECEIPT <= :Z_DATE_)'
      '                         )'
      '          INTO :COST_PRICE_;'
      '    END;'
      ''
      '    UPDATE ZAKAZ_DETAILS ZD'
      '       SET ZD.COST_PRICE = :COST_PRICE_'
      '     WHERE ZD.ZAKAZ_DETAILS = :ZAKAZ_DETAILS_;'
      '  END')
    ParentFont = False
    TabOrder = 12
    Visible = False
  end
  object mScriptIBEBlock136: TMemo [10]
    Left = -1549
    Top = 550
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,G_FIRM_ACCOUNT,G_FIRM_A' +
        'DDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMENT_TYP' +
        'E,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BILL TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_DETAILS_TMP, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCONT_CARD, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCONT_CARD TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT_IMAGE, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT_IMAGE TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_TOCHKA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_TOCHKA TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_BARCODE, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_BARCODE TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_SKLAD_TRANS, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_SKLAD_TRANS TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_TRANS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_TRANS_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_UPLOAD_TABLE_TMP, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_UPLOAD_TABLE_TMP TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;'
      ' ')
    ParentFont = False
    TabOrder = 13
    Visible = False
  end
  object mScriptIBEBlock137GDB: TMemo [11]
    Left = -1549
    Top = 550
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.GDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,DOCS,G_FIRM_ACCOUNT,G_F' +
        'IRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMEN' +
        'T_TYPE,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT, G_PRODUCT_K' +
        'IT, OTHER, OTHER_DETAILS'#39','
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,DOCS,G_FIRM_ACCOUNT,G_F' +
        'IRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMEN' +
        'T_TYPE,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT, G_PRODUCT_K' +
        'IT, OTHER, OTHER_DETAILS'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BILL TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_DETAILS_TMP, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCONT_CARD, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCONT_CARD TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT_IMAGE, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT_IMAGE TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_TOCHKA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_TOCHKA TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  --************************************************************' +
        '*******'
      '  -- '#1042' '#1042#1045#1056#1057#1048#1048' 154 '#1059#1041#1056#1040#1053' '#1043#1045#1053#1045#1056#1040#1058#1054#1056
      
        '  --************************************************************' +
        '*******'
      
        '  --select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :g' +
        'enval;'
      
        '  --sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  --ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      
        '  --select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database i' +
        'nto :genval;'
      
        '  --sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  --ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_BARCODE, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_BARCODE TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_SKLAD_TRANS, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_SKLAD_TRANS TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_TRANS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_TRANS_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_UPLOAD_TABLE_TMP, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_UPLOAD_TABLE_TMP TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  --*************************************************'
      '  -- '#1042#1045#1056#1057#1048#1071' 137'
      '  --*************************************************'
      
        '  select gen_id(GEN_G_PRODUCT_KIT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT_KIT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_OTHER_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_OTHER_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_OTHER_OPERATION, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_OTHER_OPERATION TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_DOCS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DOCS TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  -- '#1042#1045#1056#1057#1048#1071' 137 '#1050#1054#1053#1045#1062
      '  --*************************************************'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;'
      ' '
      ' '
      ' '
      ' '
      ' '
      ' ')
    ParentFont = False
    TabOrder = 11
    Visible = False
  end
  object mScriptIBEBlockUpdKassaId: TMemo [12]
    Left = -1549
    Top = 550
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '  FOR SELECT KB.KASSA_BEZNAL'
      '        FROM KASSA_BEZNAL KB'
      '       ORDER BY KB.KASSA_BEZNAL'
      '        INTO :KASSA_'
      '  DO BEGIN'
      '    UPDATE KASSA_BEZNAL K'
      '       SET K.KASSA_BEZNAL = GEN_ID(GEN_KASSA, 1)'
      '     WHERE K.KASSA_BEZNAL = :KASSA_;'
      '  END'
      ''
      '  FOR SELECT KB.KASSA_BEZNAL_STATE'
      '        FROM KASSA_BEZNAL_STATE KB'
      '       ORDER BY KB.KASSA_BEZNAL_STATE'
      '        INTO :KASSA_'
      '  DO BEGIN'
      '    UPDATE KASSA_BEZNAL_STATE K'
      '       SET K.KASSA_BEZNAL_STATE = GEN_ID(GEN_KASSA_STATE, 1)'
      '     WHERE K.KASSA_BEZNAL_STATE = :KASSA_;'
      '  END')
    ParentFont = False
    TabOrder = 9
    Visible = False
  end
  object mScriptIBEBlockUpdFirm: TMemo [13]
    Left = -1549
    Top = 550
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '  SELECT COUNT(G.G_FIRM_REKVIZIT)'
      '    FROM G_FIRM_REKVIZIT G'
      '    INTO :CNT_;'
      ''
      '  IF (CNT_ = 1) THEN'
      '    UPDATE G_FIRM_REKVIZIT G'
      '       SET G.IS_DEFAULT = 1;')
    ParentFont = False
    TabOrder = 10
    Visible = False
  end
  object mScriptCDisabled: TMemo [14]
    Left = -1549
    Top = 500
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock (LogMessage variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogMessage);'
      '         end'#39';'
      '  SourceDB = ibec_CreateConnection(__ctInterBase, '
      
        '                                   '#39'DBName="SHOPUCHET_ETALON.FDB' +
        '";'
      '                                   ClientLib=fbclient.dll;'
      
        '                                   User=SYSDBA; Password=masterk' +
        'ey; Names=WIN1251; SqlDialect=3'#39');'
      ''
      '  ibec_UseConnection(SourceDB);'
      ''
      
        '  for select LIST('#39'ALTER TABLE '#39' ||TRIM (rdb$relation_name) || '#39 +
        ' DROP CONSTRAINT '#39' || TRIM(rdb$constraint_name) || '#39';'#39', '#39
      #39')'
      '       from rdb$relation_constraints r'
      '      where rdb$constraint_type = '#39'FOREIGN KEY'#39
      '      into :str'
      '  do begin'
      '    ibec_SaveToFile('#39'1.sql'#39', str, __stfAppend);'
      '  end'
      ''
      '  ibec_CloseConnection(SourceDB);'
      'end;')
    ParentFont = False
    TabOrder = 14
  end
  object mScriptCEnabled: TMemo [15]
    Left = -1549
    Top = 500
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock (LogMessage variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogMessage);'
      '         end'#39';'
      '  SourceDB = ibec_CreateConnection(__ctInterBase, '
      
        '                                   '#39'DBName="SHOPUCHET_ETALON.FDB' +
        '";'
      '                                   ClientLib=fbclient.dll;'
      
        '                                   User=SYSDBA; Password=masterk' +
        'ey; Names=WIN1251; SqlDialect=3'#39');'
      ''
      '  ibec_UseConnection(SourceDB);'
      ''
      
        '  for SELECT LIST('#39'ALTER TABLE '#39' ||trim(RI.RDB$RELATION_NAME) ||' +
        #39' ADD CONSTRAINT '#39'|| trim(RI.RDB$INDEX_NAME)||'#39' FOREIGN KEY ('#39'||' +
        ' trim(RS.RDB$FIELD_NAME) ||'
      
        '               '#39') REFERENCES '#39'|| trim(RI1.RDB$RELATION_NAME) ||'#39 +
        '('#39'||trim(RS1.RDB$FIELD_NAME)||'#39');'#39', '#39
      #39')'
      '        FROM RDB$INDICES RI,'
      '             RDB$INDICES RI1,'
      '             RDB$INDEX_SEGMENTS RS,'
      '             RDB$INDEX_SEGMENTS RS1'
      '        WHERE RI.RDB$FOREIGN_KEY = RI1.RDB$INDEX_NAME'
      '          AND RI.RDB$INDEX_NAME = RS.RDB$INDEX_NAME'
      '          AND RI.RDB$FOREIGN_KEY = RS1.RDB$INDEX_NAME'
      '        into :str'
      '  do begin'
      '    ibec_SaveToFile('#39'2.sql'#39', str, __stfAppend);'
      '  end'
      ''
      '  ibec_CloseConnection(SourceDB);'
      'end;'
      '')
    ParentFont = False
    TabOrder = 15
  end
  object mScriptIBEBlock137: TMemo [16]
    Left = -1549
    Top = 500
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,DOCS,G_FIRM_ACCOUNT,G_F' +
        'IRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMEN' +
        'T_TYPE,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT, G_PRODUCT_K' +
        'IT, OTHER, OTHER_DETAILS'#39','
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,DOCS,G_FIRM_ACCOUNT,G_F' +
        'IRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMEN' +
        'T_TYPE,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT, G_PRODUCT_K' +
        'IT, OTHER, OTHER_DETAILS'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BILL TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_DETAILS_TMP, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCONT_CARD, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCONT_CARD TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT_IMAGE, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT_IMAGE TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_TOCHKA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_TOCHKA TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  --************************************************************' +
        '*******'
      '  -- '#1042' '#1042#1045#1056#1057#1048#1048' 154 '#1059#1041#1056#1040#1053' '#1043#1045#1053#1045#1056#1040#1058#1054#1056
      
        '  --************************************************************' +
        '*******'
      
        '  --select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :g' +
        'enval;'
      
        '  --sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  --ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      
        '  --select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database i' +
        'nto :genval;'
      
        '  --sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  --ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_BARCODE, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_BARCODE TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_SKLAD_TRANS, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_SKLAD_TRANS TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_TRANS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_TRANS_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_UPLOAD_TABLE_TMP, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_UPLOAD_TABLE_TMP TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  --*************************************************'
      '  -- '#1042#1045#1056#1057#1048#1071' 137'
      '  --*************************************************'
      
        '  select gen_id(GEN_G_PRODUCT_KIT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT_KIT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_OTHER_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_OTHER_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_OTHER_OPERATION, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_OTHER_OPERATION TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_DOCS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DOCS TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  -- '#1042#1045#1056#1057#1048#1071' 137 '#1050#1054#1053#1045#1062
      '  --*************************************************'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;'
      ' '
      ' '
      ' '
      ' '
      ' '
      ' ')
    ParentFont = False
    TabOrder = 16
    Visible = False
  end
  object mScript: TcxMemo [17]
    Left = 0
    Top = 500
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Style.StyleController = dxEditStyleController
    TabOrder = 17
    Height = 145
    Width = 2000
  end
  object mScriptIBEBlock11017: TMemo [18]
    Left = -1549
    Top = 500
    Width = 2000
    Height = 65
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'execute ibeblock'
      'as'
      'begin'
      '  cbb = '#39'execute ibeblock ('
      '           LogLine variant)'
      '         as'
      '         begin'
      '           ibec_progress(LogLine);'
      '         end'#39';'
      ''
      '  sFileName = '#39'ibe_comp.sql'#39';'
      ''
      '  MasterDB = ibec_CreateConnection(__ctInterBase, '
      '                             '#39'DBName="SHOPUCHET.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  TargetDB = ibec_CreateConnection(__ctInterBase,'
      '                             '#39'DBName="SHOPUCHET_ETALON.FDB";'
      '                              ClientLib=fbclient.dll;'
      
        '                              User=sysdba; Password=masterkey; N' +
        'ames=WIN1251; SqlDialect=3'#39');'
      '  try'
      '    ibec_CompareTables(MasterDB, TargetDB,'
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,DOCS,G_FIRM_ACCOUNT,G_F' +
        'IRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMEN' +
        'T_TYPE,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT, G_PRODUCT_K' +
        'IT, OTHER, OTHER_DETAILS, G_PROMOTION'#39','
      
        #39'G_ACCOUNT,G_ADDRESS,G_ADDRESS_TYPE,G_APPOINTMENT,G_BANK,G_CLIEN' +
        'T,G_CONTRAGENT,G_DISCONT_CARD,G_DISCOUNT,DOCS,G_FIRM_ACCOUNT,G_F' +
        'IRM_ADDRESS,G_FIRM_REKVIZIT,G_OFFICIAL,G_OFFICIAL_RIGHT,G_PAYMEN' +
        'T_TYPE,'
      
        'G_PRIHOD_RASHOD,G_PRODUCT,G_PRODUCT_IMAGE,G_TOCHKA,G_UNIT,INVOIC' +
        'E,INVOICE_PAY,KASSA,KASSA_BEZNAL,KASSA_BEZNAL_STATE,KASSA_STATE,' +
        'LT_BARCODE,LT_SKLAD_PRODUCT,LT_ZAKAZ_REAL,P_REP_PRICE_LIST_TABLE' +
        ','
      
        'P_REP_PRIHOD_TABLE,P_REP_PROFIT_TABLE,P_REP_RASHODY_PROFIT_TABLE' +
        ',P_REP_TOVAR_MOVE_TABLE,P_REP_ZAKAZ_NA_REAL_TABLE,REVISION,SKLAD' +
        ',SKLAD_PARENT,SYSTEM_SETUP,WAYBILL,'
      
        'ZAKAZ,ZAKAZ_DETAILS,ZAKAZ_NA_REAL,ZAKAZ_REAL_PARENT, G_PRODUCT_K' +
        'IT, OTHER, OTHER_DETAILS, G_PROMOTION'#39','
      '                       :sFileName,'
      
        '                       '#39'OmitDeletes;IncludeMilliseconds;UpdateOr' +
        'Insert;'#39','
      '                       cbb);'
      ''
      '  ibec_UseConnection(MasterDB);'
      ''
      '  select gen_id(GEN_ARTICUL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ARTICUL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BARCODE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BARCODE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_BILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_BILL TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_DETAILS_TMP, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DETAILS_TMP TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ACCOUNT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ACCOUNT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_ADDRESS_TYPE, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_ADDRESS_TYPE TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_APPOINTMENT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_APPOINTMENT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_BANK, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_BANK TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_CLIENT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CLIENT TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_CONTRAGENT, 0) from rdb$database into :gen' +
        'val;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_CONTRAGENT TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCONT_CARD, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCONT_CARD TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_DISCOUNT, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_DISCOUNT TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_ADDRESS, 0) from rdb$database into :g' +
        'enval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_ADDRESS TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_FIRM_REKVIZIT, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_FIRM_REKVIZIT TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_OFFICIAL_RIGHT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_OFFICIAL_RIGHT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRIHOD_RASHOD, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRIHOD_RASHOD TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT, 0) from rdb$database into :genval' +
        ';'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT TO '#39' || :genval |' +
        '| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_G_PRODUCT_IMAGE, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT_IMAGE TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_TOCHKA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_TOCHKA TO '#39' || :genval ||' +
        ' '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_G_UNIT, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_UNIT TO '#39' || :genval || '#39 +
        ';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_INVOICE, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_INVOICE_PAY, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_INVOICE_PAY TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_KASSA, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  --************************************************************' +
        '*******'
      '  -- '#1042' '#1042#1045#1056#1057#1048#1048' 154 '#1059#1041#1056#1040#1053' '#1043#1045#1053#1045#1056#1040#1058#1054#1056
      
        '  --************************************************************' +
        '*******'
      
        '  --select gen_id(GEN_KASSA_BEZNAL, 0) from rdb$database into :g' +
        'enval;'
      
        '  --sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL TO '#39' || :gen' +
        'val || '#39';'#39' || ibec_CRLF();'
      '  --ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      
        '  --select gen_id(GEN_KASSA_BEZNAL_STATE, 0) from rdb$database i' +
        'nto :genval;'
      
        '  --sSetGenerator = '#39'SET GENERATOR GEN_KASSA_BEZNAL_STATE TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  --ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_KASSA_STATE, 0) from rdb$database into :genv' +
        'al;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_KASSA_STATE TO '#39' || :genval' +
        ' || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_BARCODE, 0) from rdb$database into :genva' +
        'l;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_BARCODE TO '#39' || :genval ' +
        '|| '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_POSTAVKA_PRODAZHA, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_POSTAVKA_PRODAZHA TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_SKLAD_PRODUCT, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_SKLAD_PRODUCT TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_SKLAD_TRANS, 0) from rdb$database i' +
        'nto :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_SKLAD_TRANS TO '#39' |' +
        '| :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_LT_ZAKAZ_ZAKAZ_NA_REAL, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_LT_ZAKAZ_ZAKAZ_NA_REAL TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PRICE_LIST_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PRICE_LIST_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_PROFIT_TABLE, 0) from rdb$database int' +
        'o :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_PROFIT_TABLE TO '#39' || ' +
        ':genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_TOVAR_MOVE_TABLE, 0) from rdb$database' +
        ' into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_TOVAR_MOVE_TABLE TO '#39 +
        ' || :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_P_REP_ZAKAZ_NA_REAL, 0) from rdb$database in' +
        'to :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_P_REP_ZAKAZ_NA_REAL TO '#39' ||' +
        ' :genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_SKLAD, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_SKLAD TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_TRANS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_TRANS_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_TRANS_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_UPLOAD_TABLE_TMP, 0) from rdb$database into ' +
        ':genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_UPLOAD_TABLE_TMP TO '#39' || :g' +
        'enval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_WAYBILL, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_WAYBILL TO '#39' || :genval || ' +
        #39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_ZAKAZ, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ TO '#39' || :genval || '#39';' +
        #39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_NA_REAL, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_NA_REAL TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_ZAKAZ_REAL_PARENT, 0) from rdb$database into' +
        ' :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_ZAKAZ_REAL_PARENT TO '#39' || :' +
        'genval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  --*************************************************'
      '  -- '#1042#1045#1056#1057#1048#1071' 137'
      '  --*************************************************'
      
        '  select gen_id(GEN_G_PRODUCT_KIT, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_G_PRODUCT_KIT TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_OTHER_DETAILS, 0) from rdb$database into :ge' +
        'nval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_OTHER_DETAILS TO '#39' || :genv' +
        'al || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      
        '  select gen_id(GEN_OTHER_OPERATION, 0) from rdb$database into :' +
        'genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_OTHER_OPERATION TO '#39' || :ge' +
        'nval || '#39';'#39' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  select gen_id(GEN_DOCS, 0) from rdb$database into :genval;'
      
        '  sSetGenerator = '#39'SET GENERATOR GEN_DOCS TO '#39' || :genval || '#39';'#39 +
        ' || ibec_CRLF();'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  -- '#1042#1045#1056#1057#1048#1071' 137 '#1050#1054#1053#1045#1062
      '  --*************************************************'
      ''
      '  select count(*)'
      '    from RDB$GENERATORS'
      '   where RDB$GENERATOR_NAME = '#39'GEN_UNIVERSAL'#39
      '      into :gen_exists_;'
      ''
      '  if (gen_exists_ > 0) then begin'
      
        '     select gen_id(GEN_UNIVERSAL, 0) from rdb$database into :gen' +
        'val;'
      
        '     sSetGenerator = '#39'SET GENERATOR GEN_UNIVERSAL TO '#39' || :genva' +
        'l || '#39';'#39' || ibec_CRLF();'
      '  end'
      '  ibec_SaveToFile(:sFileName, :sSetGenerator, __stfAppend);'
      ''
      '  finally'
      '    ibec_CloseConnection(MasterDB);'
      '    ibec_CloseConnection(TargetDB);'
      '  end;'
      'end;'
      ' '
      ' '
      ' '
      ' '
      ' '
      ' ')
    ParentFont = False
    TabOrder = 18
    Visible = False
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 304
    Top = 96
  end
  inherited dxEditStyleController: TcxEditStyleController
    PixelsPerInch = 96
  end
  object Timer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerTimer
    Left = 304
    Top = 200
  end
end
