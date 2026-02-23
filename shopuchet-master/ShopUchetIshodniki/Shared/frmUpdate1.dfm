object UpdateForm1: TUpdateForm1
  Left = 613
  Top = 149
  Width = 525
  Height = 793
  Caption = #1048#1076#1077#1090' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object mScript: TMemo
    Left = 0
    Top = 416
    Width = 465
    Height = 468
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'CREATE OR ALTER PROCEDURE GET_SKLAD ('
      '    SKLAD_ TYPE OF COLUMN SKLAD.SKLAD)'
      'RETURNS ('
      '    G_PROD_NAME_ TYPE OF COLUMN G_PRODUCT.NAME,'
      '    DATE_RECEIPT_ TYPE OF COLUMN SKLAD.DATE_RECEIPT,'
      '    G_CLIENT_ TYPE OF COLUMN SKLAD.G_CLIENT,'
      '    G_PRODUCT_ TYPE OF COLUMN SKLAD.G_PRODUCT,'
      '    AMOUNT_ TYPE OF COLUMN SKLAD.AMOUNT,'
      '    PRICE_ TYPE OF COLUMN SKLAD.PRICE,'
      '    SUMM_ TYPE OF COLUMN SKLAD.SUMM,'
      '    G_PAYMENT_TYPE_ TYPE OF COLUMN SKLAD.G_PAYMENT_TYPE,'
      '    OSNOVANIE_ TYPE OF COLUMN SKLAD.OSNOVANIE,'
      '    NDS_ TYPE OF COLUMN SKLAD.NDS,'
      '    NDS_SUMM_ TYPE OF COLUMN SKLAD.NDS_SUMM,'
      '    CNT_T_ INTEGER,'
      '    ERR_CODE INTEGER,'
      '    ERR_MSG VARCHAR(1024))'
      'AS'
      'begin'
      '  IF (COALESCE(SKLAD_, 0) = 0) then BEGIN'
      '    -- '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1080#1093#1086#1076#1086#1074' '#1090#1086#1074#1072#1088#1072', '#1085#1091#1078#1085#1086' '#1076#1083#1103' '#1083#1080#1094#1077#1085#1079#1080#1080
      '    CNT_T_ = 0;'
      '    SELECT COUNT(*)'
      '      FROM (SELECT *'
      '              FROM SKLAD S ROWS 1 TO 10)'
      '      INTO :CNT_T_;'
      ''
      '    EXIT;'
      '  END'
      ''
      '  SELECT'
      '    T.DATE_RECEIPT,'
      '    T.G_CLIENT,'
      '    T.G_PRODUCT,'
      '    T.AMOUNT,'
      '    DECODE(T.IS_VOZVRAT, 1, T.PRICE_VOZVRAT, T.PRICE),  '
      '/* '#1045#1057#1051#1048' '#1042#1054#1047#1042#1056#1040#1058' - '
      #1041#1045#1056#1059' '
      #1062#1045#1053#1059' '#1056#1045#1040#1051#1048#1047#1040#1062#1048#1048' '#1053#1040' '#1058#1054#1058' '#1052#1054#1052#1045#1053#1058', '#1042' '#1041#1059#1044#1059#1065#1045#1052' '#1055#1054#1053#1040#1044#1054#1041#1048#1058#1057#1071' '#1042' '
      #1054#1058#1063#1045#1058#1040#1061' '#1048' '#1058#1044'*/'
      '    DECODE(T.IS_VOZVRAT, 1, T.SUMM_VOZVRAT, T.SUMM),'
      '    T.G_PAYMENT_TYPE,'
      '    T.OSNOVANIE,'
      '    T.NDS,'
      '    T.NDS_SUMM,'
      '    P.NAME'
      '  FROM SKLAD T, G_PRODUCT P'
      '  WHERE T.SKLAD = :SKLAD_'
      '    AND T.G_PRODUCT = P.G_PRODUCT'
      '  INTO'
      '    :DATE_RECEIPT_,'
      '    :G_CLIENT_,'
      '    :G_PRODUCT_,'
      '    :AMOUNT_,'
      '    :PRICE_,'
      '    :SUMM_,'
      '    :G_PAYMENT_TYPE_,'
      '    :OSNOVANIE_,'
      '    :NDS_,'
      '    :NDS_SUMM_,'
      '    :G_PROD_NAME_;'
      ''
      '  ERR_CODE = -20500;'
      '  ERR_MSG  = '#39#1054#1096#1080#1073#1082#1072#39';'
      'end;'
      'CREATE OR ALTER PROCEDURE GET_SKLAD ('
      '    SKLAD_ TYPE OF COLUMN SKLAD.SKLAD)'
      'RETURNS ('
      '    G_PROD_NAME_ TYPE OF COLUMN G_PRODUCT.NAME,'
      '    DATE_RECEIPT_ TYPE OF COLUMN SKLAD.DATE_RECEIPT,'
      '    G_CLIENT_ TYPE OF COLUMN SKLAD.G_CLIENT,'
      '    G_PRODUCT_ TYPE OF COLUMN SKLAD.G_PRODUCT,'
      '    AMOUNT_ TYPE OF COLUMN SKLAD.AMOUNT,'
      '    PRICE_ TYPE OF COLUMN SKLAD.PRICE,'
      '    SUMM_ TYPE OF COLUMN SKLAD.SUMM,'
      '    G_PAYMENT_TYPE_ TYPE OF COLUMN SKLAD.G_PAYMENT_TYPE,'
      '    OSNOVANIE_ TYPE OF COLUMN SKLAD.OSNOVANIE,'
      '    NDS_ TYPE OF COLUMN SKLAD.NDS,'
      '    NDS_SUMM_ TYPE OF COLUMN SKLAD.NDS_SUMM,'
      '    CNT_T_ INTEGER,'
      '    ERR_CODE INTEGER,'
      '    ERR_MSG VARCHAR(1024))'
      'AS'
      'begin'
      '  IF (COALESCE(SKLAD_, 0) = 0) then BEGIN'
      '    -- '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1080#1093#1086#1076#1086#1074' '#1090#1086#1074#1072#1088#1072', '#1085#1091#1078#1085#1086' '#1076#1083#1103' '#1083#1080#1094#1077#1085#1079#1080#1080
      '    CNT_T_ = 0;'
      '    SELECT COUNT(*)'
      '      FROM (SELECT *'
      '              FROM SKLAD S ROWS 1 TO 10)'
      '      INTO :CNT_T_;'
      ''
      '    EXIT;'
      '  END'
      ''
      '  SELECT'
      '    T.DATE_RECEIPT,'
      '    T.G_CLIENT,'
      '    T.G_PRODUCT,'
      '    T.AMOUNT,'
      '    DECODE(T.IS_VOZVRAT, 1, T.PRICE_VOZVRAT, T.PRICE),  '
      '/* '#1045#1057#1051#1048' '#1042#1054#1047#1042#1056#1040#1058' - '
      #1041#1045#1056#1059' '
      #1062#1045#1053#1059' '#1056#1045#1040#1051#1048#1047#1040#1062#1048#1048' '#1053#1040' '#1058#1054#1058' '#1052#1054#1052#1045#1053#1058', '#1042' '#1041#1059#1044#1059#1065#1045#1052' '#1055#1054#1053#1040#1044#1054#1041#1048#1058#1057#1071' '#1042' '
      #1054#1058#1063#1045#1058#1040#1061' '#1048' '#1058#1044'*/'
      '    DECODE(T.IS_VOZVRAT, 1, T.SUMM_VOZVRAT, T.SUMM),'
      '    T.G_PAYMENT_TYPE,'
      '    T.OSNOVANIE,'
      '    T.NDS,'
      '    T.NDS_SUMM,'
      '    P.NAME'
      '  FROM SKLAD T, G_PRODUCT P'
      '  WHERE T.SKLAD = :SKLAD_'
      '    AND T.G_PRODUCT = P.G_PRODUCT'
      '  INTO'
      '    :DATE_RECEIPT_,'
      '    :G_CLIENT_,'
      '    :G_PRODUCT_,'
      '    :AMOUNT_,'
      '    :PRICE_,'
      '    :SUMM_,'
      '    :G_PAYMENT_TYPE_,'
      '    :OSNOVANIE_,'
      '    :NDS_,'
      '    :NDS_SUMM_,'
      '    :G_PROD_NAME_;'
      ''
      '  ERR_CODE = -20500;'
      '  ERR_MSG  = '#39#1054#1096#1080#1073#1082#1072#39';'
      'end;'
      'CREATE OR ALTER PROCEDURE GET_SKLAD ('
      '    SKLAD_ TYPE OF COLUMN SKLAD.SKLAD)'
      'RETURNS ('
      '    G_PROD_NAME_ TYPE OF COLUMN G_PRODUCT.NAME,'
      '    DATE_RECEIPT_ TYPE OF COLUMN SKLAD.DATE_RECEIPT,'
      '    G_CLIENT_ TYPE OF COLUMN SKLAD.G_CLIENT,'
      '    G_PRODUCT_ TYPE OF COLUMN SKLAD.G_PRODUCT,'
      '    AMOUNT_ TYPE OF COLUMN SKLAD.AMOUNT,'
      '    PRICE_ TYPE OF COLUMN SKLAD.PRICE,'
      '    SUMM_ TYPE OF COLUMN SKLAD.SUMM,'
      '    G_PAYMENT_TYPE_ TYPE OF COLUMN SKLAD.G_PAYMENT_TYPE,'
      '    OSNOVANIE_ TYPE OF COLUMN SKLAD.OSNOVANIE,'
      '    NDS_ TYPE OF COLUMN SKLAD.NDS,'
      '    NDS_SUMM_ TYPE OF COLUMN SKLAD.NDS_SUMM,'
      '    CNT_T_ INTEGER,'
      '    ERR_CODE INTEGER,'
      '    ERR_MSG VARCHAR(1024))'
      'AS'
      'begin'
      '  IF (COALESCE(SKLAD_, 0) = 0) then BEGIN'
      '    -- '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1087#1088#1080#1093#1086#1076#1086#1074' '#1090#1086#1074#1072#1088#1072', '#1085#1091#1078#1085#1086' '#1076#1083#1103' '#1083#1080#1094#1077#1085#1079#1080#1080
      '    CNT_T_ = 0;'
      '    SELECT COUNT(*)'
      '      FROM (SELECT *'
      '              FROM SKLAD S ROWS 1 TO 10)'
      '      INTO :CNT_T_;'
      ''
      '    EXIT;'
      '  END'
      ''
      '  SELECT'
      '    T.DATE_RECEIPT,'
      '    T.G_CLIENT,'
      '    T.G_PRODUCT,'
      '    T.AMOUNT,'
      '    DECODE(T.IS_VOZVRAT, 1, T.PRICE_VOZVRAT, T.PRICE),  '
      '/* '#1045#1057#1051#1048' '#1042#1054#1047#1042#1056#1040#1058' - '
      #1041#1045#1056#1059' '
      #1062#1045#1053#1059' '#1056#1045#1040#1051#1048#1047#1040#1062#1048#1048' '#1053#1040' '#1058#1054#1058' '#1052#1054#1052#1045#1053#1058', '#1042' '#1041#1059#1044#1059#1065#1045#1052' '#1055#1054#1053#1040#1044#1054#1041#1048#1058#1057#1071' '#1042' '
      #1054#1058#1063#1045#1058#1040#1061' '#1048' '#1058#1044'*/'
      '    DECODE(T.IS_VOZVRAT, 1, T.SUMM_VOZVRAT, T.SUMM),'
      '    T.G_PAYMENT_TYPE,'
      '    T.OSNOVANIE,'
      '    T.NDS,'
      '    T.NDS_SUMM,'
      '    P.NAME'
      '  FROM SKLAD T, G_PRODUCT P'
      '  WHERE T.SKLAD = :SKLAD_'
      '    AND T.G_PRODUCT = P.G_PRODUCT'
      '  INTO'
      '    :DATE_RECEIPT_,'
      '    :G_CLIENT_,'
      '    :G_PRODUCT_,'
      '    :AMOUNT_,'
      '    :PRICE_,'
      '    :SUMM_,'
      '    :G_PAYMENT_TYPE_,'
      '    :OSNOVANIE_,'
      '    :NDS_,'
      '    :NDS_SUMM_,'
      '    :G_PROD_NAME_;'
      ''
      '  ERR_CODE = -20500;'
      '  ERR_MSG  = '#39#1054#1096#1080#1073#1082#1072#39';'
      'end;')
    ParentFont = False
    TabOrder = 0
  end
  object mLog: TMemo
    Left = -1
    Top = 216
    Width = 466
    Height = 187
    Lines.Strings = (
      '')
    TabOrder = 1
  end
  object Timer: TTimer
    Enabled = False
    Interval = 200
    OnTimer = TimerTimer
    Left = 304
    Top = 200
  end
end
