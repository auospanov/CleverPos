unit frmProcessFiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmMDIChild, FIBDatabase, pFIBDatabase, DB, FIBDataSet,
  pFIBDataSet, ActnList, dxBar, ExtCtrls, StdCtrls, ComCtrls, FIBQuery,
  pFIBQuery, pFIBStoredProc, dxExEdtr, dxTL, dxDBCtrl, dxDBGrid, dxCntner,
  cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, dxDBTLCl, dxGrClms, Buttons, vlFIBQuery;

type
  TProcessFilesForm = class(TMDIChildForm)
    dxBarButtonStartIn: TdxBarButton;
    dxBarButtonStartOut: TdxBarButton;
    aStartIn: TAction;
    aStartOut: TAction;
    TimerIn: TTimer;
    TimerOut: TTimer;
    PageControl: TPageControl;
    tsLog: TTabSheet;
    tsFiles: TTabSheet;
    LogRichEdit: TRichEdit;
    BottomPanel: TPanel;
    Label1: TLabel;
    ProgressBar: TProgressBar;
    aProcess: TAction;
    aOptions: TAction;
    dxBarButtonFolders: TdxBarButton;
    spInsIngoingFile: TpFIBStoredProc;
    spInsIngoingFileTran: TpFIBTransaction;
    spReadHeadMT: TpFIBDataSet;
    TranReadHeadMT: TpFIBTransaction;
    spGetReference: TpFIBDataSet;
    PanelFiles: TPanel;
    dxDBGrid: TdxDBGrid;
    dxDBGridINGOING_MT_FILE: TdxDBGridColumn;
    dxDBGridFILE_NAME: TdxDBGridColumn;
    dxDBGridPROCEED_SIGN_STR: TdxDBGridColumn;
    edDateBegin: TcxDateEdit;
    edDateEnd: TcxDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    dxDBGridIN_OUT: TdxDBGridColumn;
    dxDBGridRECV_DATE: TdxDBGridColumn;
    dxDBGridRECV_DATE_ADD: TdxDBGridDateColumn;
    aGroupColumns: TAction;
    btnGoup: TSpeedButton;
    spRead: TpFIBDataSet;
    tranSpRead: TpFIBTransaction;
    dsRead: TDataSource;
    btnRefresh: TSpeedButton;
    aRefresh: TAction;
    spGetData: TpFIBStoredProc;
    tranRead: TpFIBTransaction;
    spGet_Ingoing_MT_File: TpFIBDataSet;
    spInsIngoingMTFile: TpFIBStoredProc;
    tranInsIngoingMTFile: TpFIBTransaction;
    tranWrite: TpFIBTransaction;
    spUpd: TpFIBStoredProc;
    UpdTimer: TTimer;
    procedure aStartInExecute(Sender: TObject);
    procedure aStartOutExecute(Sender: TObject);
    procedure TimerInTimer(Sender: TObject);
    procedure aProcessExecute(Sender: TObject);
    procedure aOptionsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aGroupColumnsExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edDateBeginPropertiesChange(Sender: TObject);
    procedure edDateEndPropertiesChange(Sender: TObject);
    procedure UpdTimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FIngoingFolderIn : String;
    FIngoingFolderOk : String;
    FIngoingFolderErr : String;
    FIngoingFolderArch : String;
    //FOutgoingFolderIn : String;
    //FOutgoingFolderOut : String;
    FFieldMT50 : String;
    FMT102Format : Integer;
    FSenderStr : String;
    FSender : Integer;
    FRecieverStr : String;
    FReciever : Integer;
    FNewField50 : String;

    Procedure UpdateSetupParams;
    Procedure RefreshSetupParams(CheckNew : Integer);
    Procedure ReadList;

  public
    { Public declarations }
    Function GetDirList(var FileList : TStringList; Path : String) : Boolean;
    Function ParseFile(FileBody : TStringList; FileName_ : String;Var FileType_ : Integer) : Boolean;
    Function InsertFileIntoFB(FileBody : TStringList; FileName_, Reference_ : String) : Boolean;
    Function GetSenderReciever(Buf_Body_ : String; Var In_ : Integer; Var SENDER_, RECIVER_, OrigReference_ : String): Boolean;
    Function GetNewSenderReciever(SENDER_, RECIVER_ : String; In_ : Byte; Var NEW_SENDER_, NEW_RECIVER_ : String): Boolean;
    Function GetNewReference(Var Reference_ : String): Boolean;
    Procedure WriteLog(S: String; Err : Byte);
    Procedure DoUpdate;
  end;

var
  ProcessFilesForm: TProcessFilesForm;
  PExecProc : Pointer;
  PUpdate : ^Integer;

implementation

{$R *.dfm}

Uses unCommonFunc, MaskUtils, ConvUtils, frmFoldersSetup, unMessageTimer;

Procedure TProcessFilesForm.DoUpdate;
Begin
  If Assigned(MessageTimerForm) Then Begin
    If MessageTimerForm.ButtonResult = 'No' Then Begin
       PUpdate^ := 0;
       Exit;
    End;
  End;
  PUpdate^ := 1;
End;

Procedure TProcessFilesForm.UpdateSetupParams;
Begin
  With spUpd Do Begin
    Try

      If spUpd.Transaction.InTransaction Then Begin
        Transaction.Commit;
        Transaction.StartTransaction;
      End
      Else
        Transaction.StartTransaction;
      
      ParamByName('INGOING_IN').AsString := FIngoingFolderIn;
      ParamByName('INGOING_OK').AsString := FIngoingFolderOk;
      ParamByName('INGOING_ERR').AsString := FIngoingFolderErr;
      ParamByName('INGOING_ARCH').AsString := FIngoingFolderArch;
      {
      ParamByName('OUTGOING_IN').AsString := edOUTGOING_IN.Text;
      ParamByName('OUTGOING_OK').AsString := edOUTGOING_OK.Text;
      ParamByName('OUTGOING_ERR').AsString := edOUTGOING_ERR.Text;
      ParamByName('OUTGOING_ARCH').AsString := edOUTGOING_ARCH.Text;
      }
      ParamByName('FIELD_50').AsString := FFieldMT50;
      ParamByName('MT102_FORMAT').AsString := IntToStr(FMT102Format);
      ParamByName('SENDER_STR').AsString := FSenderStr;
      ParamByName('SENDER').AsString := IntToStr(FSender);
      ParamByName('RECEIVER_STR').AsString := FRecieverStr;
      ParamByName('RECEIVER').AsString := IntToStr(FReciever);

      ExecQuery;

      If Transaction.InTransaction Then Begin
        Transaction.Commit;
      End;

      WriteLog('Обновлены настройки',0);

    Except
     If Transaction.InTransaction Then Begin
       Transaction.Rollback;
     End;

    End;
  End;

End;

Procedure TProcessFilesForm.RefreshSetupParams(CheckNew : Integer);
Begin
  With spGetData Do Begin
    Try
     If Transaction.InTransaction Then Begin
       Transaction.Commit;
       Transaction.StartTransaction;
     End
     Else
       Transaction.StartTransaction;
     ExecQuery;

     FIngoingFolderIn  := ParamByName('INGOING_IN').AsString;
     FIngoingFolderOk  := ParamByName('INGOING_OK').AsString;
     FIngoingFolderErr := ParamByName('INGOING_ERR').AsString;
     FIngoingFolderArch:= ParamByName('INGOING_ARCH').AsString;
     FFieldMT50        := ParamByName('FIELD_50').AsString;
     FMT102Format      := ParamByName('MT102_FORMAT').AsInteger;
     FSender           := ParamByName('SENDER').AsInteger;
     FSenderStr        := ParamByName('SENDER_STR').AsString;
     FReciever         := ParamByName('RECEIVER').AsInteger;
     FRecieverStr      := ParamByName('RECEIVER_STR').AsString;
     FNewField50       := ParamByName('NEW_FIELD_50').AsString;
     If (ParamByName('HAVE_NEW_FIELD_50').AsInteger = 1) And
        (CheckNew = 1) Then Begin
        MessageTimerForm := TMessageTimerForm.Create(Self);
        PExecProc := @TProcessFilesForm.DoUpdate;
        MessageTimerForm.ButtonYesText := 'Да';
        MessageTimerForm.ButtonNoText  := 'Нет';
        MessageTimerForm.ExecuteProcedure := PExecProc;
        MessageTimerForm.MessageText := 'Обнаружены более новые данные поля ":50:". Хотите применить их?'+#13#10+FNewField50;
        MessageTimerForm.Seconds := 30; // 30 секунд ожидаем реакции пользователя
        UpdTimer.Enabled := True;
        MessageTimerForm.Show;

     End; // If

     If Transaction.InTransaction Then Begin
       Transaction.Commit;
     End; // If

    Except
     If Transaction.InTransaction Then Begin
       Transaction.Rollback;
     End; // If

    End; // Try

  End; // With
End;


procedure TProcessFilesForm.FormCreate(Sender: TObject);
begin
  inherited;
  New(PUpdate);
  RefreshSetupParams(1);

end;

Procedure TProcessFilesForm.ReadList;
Var ID_ : String;
Begin

   if (edDateBegin.Text = '') or (edDateEnd.Text = '') Then Exit;

   With spRead Do Begin
     Try
        If Active Then Begin
          ID_ := FieldByName('INGOING_MT_FILE').AsString;
          Close;
        End;
        If Transaction.InTransaction Then
          Transaction.CommitRetaining;
        ParamByName('BEGIN_DATE').AsDate := edDateBegin.Date;
        ParamByName('END_DATE').AsDate := edDateEnd.Date;
        Open;
        Locate('INGOING_MT_FILE', ID_, []);

        {
        If dxDBGrid.SelectedCount > 0 Then Begin
          dxDBGrid.FocusedNode.Selected := True;
          dxDBGrid.FocusedNode.Focused := True;
        End;
        }


     Except
        If Transaction.InTransaction Then
          Transaction.RollbackRetaining;
     End;
   End;
End;

procedure TProcessFilesForm.aStartInExecute(Sender: TObject);
begin
  inherited;
  TimerIn.Enabled := dxBarButtonStartIn.Down;
end;

procedure TProcessFilesForm.aStartOutExecute(Sender: TObject);
begin
  inherited;
  TimerOut.Enabled := dxBarButtonStartOut.Down;
end;

procedure TProcessFilesForm.TimerInTimer(Sender: TObject);
begin
  inherited;
  aProcess.Execute;
end;

Function TProcessFilesForm.GetDirList(var FileList : TStringList; Path : String): Boolean;
Var
  sr : TSearchRec;//THandle;
  FileAttrs, FilesCount_ : Integer;
  s: string;
begin
  Try
      FilesCount_ := 0;
      // устанавливаем атрибуты с какими будем искать файлы
      FileAttrs := faArchive + faSysFile + faHidden;
      If FindFirst(Path+'*.*', FileAttrs, sr) = 0 Then Begin
         Repeat
           if (sr.Attr and FileAttrs) = sr.Attr then
           Begin
             FileList.Add(sr.Name);
             FilesCount_ := FilesCount_ + 1;
           End;
         Until FindNext(sr) <> 0;
      End;
      FindClose(sr);
      if FilesCount_ > 0 Then
        Result := True
      Else
        Result := False;
  Except
     Result := False;
  End;

end;

Procedure TProcessFilesForm.WriteLog(S: String; Err : Byte);
Begin
   Try
     If Err = 0 Then Begin
        With LogRichEdit.SelAttributes do Begin
          Color := clBlack;
          LogRichEdit.Lines.Add(GetDateTime + ' ' + S);
        End;
     End
     Else Begin
        With LogRichEdit.SelAttributes do Begin
          Color := clMaroon;
          LogRichEdit.Lines.Add(GetDateTime + ' ' + S);
          Color := clBlack;
        End;
     End;
   Except
     
   End;
End;

Function TProcessFilesForm.InsertFileIntoFB(FileBody : TStringList; FileName_, Reference_ : String) : Boolean;
Var TmpStrm : TMemoryStream;
    INGOING_MT_FILE_, p_m, p_a : INTEGER;
    TextPart_, MAIN_HEADER_, APP_HEADER_, FileBody_ : String;
    TextPart : TStringList;
Begin
   Try
      TmpStrm := TMemoryStream.Create;
      Try
         FileBody.SaveToStream(TmpStrm);
         TmpStrm.Position := 0;
      Except
         Result := False;
         Exit;
      End;

       With spInsIngoingFile Do Begin
          Try
              If Transaction.InTransaction Then
                Transaction.Commit;
              Transaction.StartTransaction;
              ParamByName('FILE_NAME').AsString := FileName_;
              ParamByName('FILE_BODY').LoadFromStream(TmpStrm);
              ParamByName('PROCEED_SIGN').AsInteger := 0;
              //ParamByName('BLOCKS_COUNT').AsInteger := 1;
              ExecQuery;

              If Transaction.InTransaction Then
                Transaction.Commit;

              Result := True;
          Except
              If Transaction.InTransaction Then
                Transaction.Rollback;
              Result := False;
              Exit;
          End;
       End;

   Finally
      TmpStrm.Free;
   End;
   {
   // Вставка в распарсенную таблицу
   Try
      TmpStrm := TMemoryStream.Create;
      TextPart := TStringList.Create;
      Try
         FileBody_ := FileBody.Text;
         TextPart_ := Copy(FileBody_,Pos('{4:',FileBody_),Length(FileBody_));
         TextPart.Add(TextPart_);
         TextPart.SaveToStream(TmpStrm);
         TmpStrm.Position := 0;
      Except
         Result := False;
         Exit;
      End;

      With spGet_Ingoing_MT_File Do Begin
        Try
           If Active Then
             Close;
           If Transaction.InTransaction Then
             Transaction.CommitRetaining;
           ParamByName('FILE_NAME_').AsString := FileName_;
           Open;
           INGOING_MT_FILE_ := FieldByName('INGOING_MT_FILE').AsInteger;
           Result := True;
        Except
           If Transaction.InTransaction Then
             Transaction.RollbackRetaining;
           Result := False;
           Exit;
        End;
      End;

      p_m := Pos('{2:',FileBody_)-3;
      If p_m > 0 Then
        MAIN_HEADER_ := Trim(Copy(FileBody_,1,p_m))
      Else
        MAIN_HEADER_ := 'Не определен';

      p_a := Pos('{4:',FileBody_)-3;
      If p_a > 0 Then
        APP_HEADER_ := Trim(Copy(FileBody_,p_m+3,p_a - Length(MAIN_HEADER_)))
      Else
        APP_HEADER_ := 'Не определен';

       With spInsIngoingMTFile Do Begin
          Try
              If Transaction.InTransaction Then
                Transaction.Commit;
              Transaction.StartTransaction;

              ParamByName('INGOING_MT').AsInteger := -1;
              ParamByName('INGOING_MT_FILE').AsInteger := INGOING_MT_FILE_;
              ParamByName('MT_FORMAT').AsInteger := FMT102Format;
              ParamByName('SENDER_STR').AsString := FSenderStr;
              ParamByName('RECEIVER_STR').AsString := FRecieverStr;
              ParamByName('SENDER').AsInteger := FSender;
              ParamByName('RECEIVER').AsInteger := FReciever;
              ParamByName('MT_PRIORITY').AsString := 'U';
              ParamByName('MAIN_HEADER').AsString := MAIN_HEADER_;
              ParamByName('APP_HEADER').AsString := APP_HEADER_;
              ParamByName('TEXT_PART').AsString := TextPart_;
              ParamByName('EL_SIGN').AsVariant := Null;
              ParamByName('BLOCK_IN_MT_FILE').AsInteger := 1;
              ParamByName('PROCEED_SIGN').AsInteger := 5;
              ParamByName('PROCEED_DATE').AsDate := Date;
              ParamByName('UNIQUE_CODE').AsString := ':20:';
              ParamByName('UNIQUE_VALUE').AsString := Reference_;
              ParamByName('ERROR_CODE').AsInteger := 0;
              ParamByName('MT_TYPE').AsString := '102';


              ExecQuery;

              If Transaction.InTransaction Then
                Transaction.Commit;

              Result := True;
          Except
              If Transaction.InTransaction Then
                Transaction.Rollback;
              Result := False;
          End;
       End;
   Finally
      TextPart.Free;
      TmpStrm.Free;
   End;
   }
End;

Function TProcessFilesForm.GetSenderReciever(Buf_Body_ : String; Var In_ : Integer; Var SENDER_, RECIVER_, OrigReference_ : String): Boolean;
Var p, p_b : integer;
    Str_, Str4_ : String;
Begin
   Try
     Str_ := '';
     p := Pos('{2:',Buf_Body_);
     If p > 0 Then Str4_ := Copy(Buf_Body_,p,32);
     if Str4_[4]='O' Then Begin
        // вычисляем получателя
        p_b := 18;
        For p := p_b to p_b+7 Do
             Str_ := Str_ + Str4_[p];
        RECIVER_ := Str_;
        // вычисляем отправителя
        Str_ := Copy(Buf_Body_,7,8);
        SENDER_ := Str_;
        In_ := 0;
        Result := True;
     end;
     if Str4_[4]='I' Then Begin
        If Pos('___',Copy(Buf_Body_,1,Pos('{2:',Buf_Body_)))>0 Then Begin
            // вычисляем получателя
            Str_ := Copy(Buf_Body_,10,8);
            RECIVER_ := Str_;
            // вычисляем отправителя
            Str_ := '';
            p_b := 11;
            For p := p_b to p_b+7 Do
                 Str_ := Str_ + Str4_[p];
            SENDER_ := Str_;
            In_ := 3;
        End
        Else Begin
            // вычисляем получателя
            Str_ := Copy(Buf_Body_,7,8);
            RECIVER_ := Str_;
            // вычисляем отправителя
            Str_ := '';
            p_b := 18;
            For p := p_b to p_b+7 Do
                 Str_ := Str_ + Str4_[p];
            SENDER_ := Str_;
            In_ := 1;
        End;

        Result := True;
     End;

     p := Pos('{3:',Buf_Body_);
     If p > 0 Then Begin
        p := Pos(':21:',Buf_Body_);
        If p > 0 Then Begin
           OrigReference_ := Trim(Copy(Buf_Body_, Pos(':21:',Buf_Body_)+ 4, 16))
        End;
     End;

   Except
     Result := False;
   End;
End;

Function TProcessFilesForm.GetNewSenderReciever(SENDER_, RECIVER_ : String; In_ : Byte; Var NEW_SENDER_, NEW_RECIVER_ : String): Boolean;
Begin

   With spReadHeadMT Do Begin
     Try
        If Active Then
          Close;
        If Transaction.InTransaction Then
          Transaction.CommitRetaining;

        ParamByName('SENDER_').AsString := SENDER_;
        ParamByName('RECIVER_').AsString := RECIVER_;
        Open;
        NEW_SENDER_ := FieldByName('NEW_SENDER_').AsString;
        NEW_RECIVER_ := FieldByName('NEW_RECIVER_').AsString;
        Result := True;

     Except
        If Transaction.InTransaction Then
          Transaction.RollbackRetaining;
        Result := False;
     End;
   End;
End;

Function TProcessFilesForm.GetNewReference(Var Reference_ : String): Boolean;
Begin

   With spGetReference Do Begin
     Try
        If Active Then
          Close;
        If Transaction.InTransaction Then
          Transaction.CommitRetaining;

        Open;
        Reference_ := FieldByName('REFERENCE').AsString;
        Result := True;
     Except
        If Transaction.InTransaction Then
          Transaction.RollbackRetaining;
        Result := False;
     End;
   End;

End;

Function TProcessFilesForm.ParseFile(FileBody : TStringList; FileName_ : String; Var FileType_ : Integer): Boolean;
Var i, cnt_, p_, Len_ : Integer;
    BlockArray : Array Of Integer;
    CutFile : TStringList;
    WasError_ : Boolean;
    FileName_New_, Buf_Body_, SENDER_, RECIVER_, NEW_RECIVER_, NEW_SENDER_, Header_, Str_, FirstBlock_, SecondBlock_, StrTmp_, Reference_, OrigReference_, NewBody_, NewBody_tmp_ : String;
Begin
   LogRichEdit.SetFocus;
   cnt_ := 0;
   Buf_Body_ := FileBody.Text;

   // Определяем это МТ-подобный файл от ГЦВП, который надо разрезать, либо обычная МТ-шка
   If Pos('{3:',Buf_Body_) = 0 Then Begin
      FileType_ := 0;
      Result := True;
      Exit;
   End;

   FileType_ := 1;

   // получаем из файла отправителя и получателя
   If GetSenderReciever(Buf_Body_, i, SENDER_,RECIVER_, OrigReference_) Then Begin
       // определяем какой должен быть отправитель и получатель
       If GetNewSenderReciever(SENDER_,RECIVER_,1,NEW_SENDER_,NEW_RECIVER_) Then Begin
          If i = 3 Then Begin
              // В файлах встречаются переносы не #13#10, а просто #13
              // Формируем первый блок
              p_ := Pos(#13,Buf_Body_);
              FirstBlock_ := '';
              Str_ := Copy(Buf_Body_,1,p_);
              FirstBlock_ := FirstBlock_ + Copy(Str_, 1, 6);
              StrTmp_ := Trim(Copy(Str_, Pos(RECIVER_,Str_) + Length(RECIVER_) + 6 + 3, p_- Pos(RECIVER_,Str_) + Length(RECIVER_) + 6 + 1));
              FirstBlock_ := FirstBlock_ + NEW_RECIVER_ + '00000000000000}';

              // Формируем второй блок
              p_ := Pos('{2:',Buf_Body_);
              Len_ := Pos('{3:',Buf_Body_) - 2 - p_;
              SecondBlock_ := '';
              Str_ := Copy(Buf_Body_,p_,Len_);
              SecondBlock_ := SecondBlock_ + Copy(Str_, 1, 7);
              StrTmp_ := Trim(Copy(Str_, Pos(SENDER_,Str_) + Length(SENDER_)-3, p_- Pos(SENDER_,Str_) + Length(SENDER_) + 5));
              SecondBlock_ := SecondBlock_ + NEW_SENDER_ + StrTmp_;

              Header_ := Trim(FirstBlock_ + #13#10 + SecondBlock_) + #13#10;
          End
          Else If i = 0 Then Begin
          End;

       End
       Else Begin
          WasError_ := True;
          WriteLog('Ошибка во время копирования в базу данных терминала (Блок №1) не определен новый отправитель и получатель', 1);
          Result := False;
          Exit;
       End;
   End
   Else Begin
      WasError_ := True;
      WriteLog('Ошибка во время копирования в базу данных терминала (Блок №2) не определен отправитель и получатель', 1);
      Result := False;
      Exit;
   End;

   Len_ := Length(Buf_Body_);
   For i := 1 To Len_-2 Do Begin
      // Ищем 4-ый блок
      If (Buf_Body_[i]   = '{') And
         (Buf_Body_[i+1] = '4') And
         (Buf_Body_[i+2] = ':') Then Begin
         cnt_ := cnt_ + 1;
         SetLength(BlockArray, cnt_);
         BlockArray[cnt_-1] := i;
      End;
   End;
   // запоминаем позицию конца файл
   SetLength(BlockArray, cnt_+1);
   BlockArray[cnt_] := Len_;

   If (cnt_ > 1) or (pos('{3:',Buf_Body_)>0) Then Begin
      WriteLog('Файл ГЦВП содержит ' + IntToStr(cnt_) + ' сообщение(ий), идет нарезка', 0);

      // Если в процессе нарезки возникнет ошибка, то файл не надо перемещать в каталог обработанных файлов
      // а надо его будет переместить в папку ошибочных. WasError_ означает были ли ошибки во время нарезки.
      // Перенос файла осуществляется во внешнем процедуре, а здесь возвращается только
      // нормально ли прошла нарезка (Result = TRUE) либо с ошибкой (Result = FALSE)
      WasError_ := False;

      ProgressBar.Max := cnt_-1;
      // Пробегаем по всем точкам нахождения последовательности символов "{4:"
      For i := 0 To cnt_-1 Do Begin
        CutFile := TStringList.Create;
        Try
           // Получаем новый референс
           If Not GetNewReference(Reference_) Then Begin
              WasError_ := True;
              Result := False;
              Break;
           End;
           // Добавляем заголовок МТ-шки
           CutFile.Append(Trim(Header_));
           // Добавляем тело(детали) МТ-шки
           NewBody_tmp_ := Trim(Copy(Buf_Body_, BlockArray[i], BlockArray[i+1]-BlockArray[i]));
           NewBody_ := '{4:' + #13#10 +
                        ':20:' + Reference_ +'/' + OrigReference_ + #13#10 +
                        Trim( FFieldMT50 ) + #13#10 +
                        Trim(  Copy(NewBody_tmp_, 4, Length(NewBody_tmp_) )  ) ;
           CutFile.Append(Trim(NewBody_));
           Try
               // Собираем новое имя файла для нарезанной МТ-шки
               FileName_New_ := Copy(FileName_,1, Length(FileName_) - Length(ExtractFileExt(FileName_)) )+'-'+IntToStr(i+1)+ExtractFileExt(FileName_);
               // копируем файл в базу фаирбёрд
               If Not InsertFileIntoFB(CutFile, FileName_New_, Reference_ +'/' + OrigReference_) Then Begin
                  WasError_ := True;
                  WriteLog('Ошибка во время копирования в базу данных терминала файла ' + FileName_New_, 1);
               End
               Else Begin
                  WriteLog('Файл скопирован в БД шлюза с именем ' + FileName_New_, 0);

                  // проверяем существует ли папка
                  If not CreateDirEx(FIngoingFolderArch + 'PARSED\' + CurDate) then
                    WriteLog('Не удалось создать каталог ' + FIngoingFolderArch + 'PARSED\' + CurDate, 1)
                  Else
                    // записываем файл в папку файловой системы
                    CutFile.SaveToFile(FIngoingFolderArch + 'PARSED\' + CurDate + '\' + FileName_New_);
               End;
               ProgressBar.Position := i;
           Except
              WasError_ := True;
           End;
        Except
           CutFile.Free;
        End;
      End;

      // Если не было ошибок при копировании файлов в базу данных,
      // то результатом функции будет True
      If Not WasError_ Then Begin
         Result := True;
      End Else
         Result := False;
   End;

   If cnt_ = 1 Then Begin
      WriteLog('Файл КЦМР', 0);
      Result := True;
   End;

   If cnt_ = 0 Then Begin
      WriteLog('Файл ' + FileName_ + ' не поддерживаемого формата', 1);
      Result := True;
   End;

End;

procedure TProcessFilesForm.aProcessExecute(Sender: TObject);
Var FF : TextFile;
    FileList, FileBody : TStringList;
    i, cnt_, FileType_ : Integer;
begin
  inherited;
  FileList := TStringList.Create;
  Try
      If GetDirList(FileList, FIngoingFolderIn ) Then Begin
         cnt_ := FileList.Count;
         // Вывод на экран списка файлов
         WriteLog('Всего: ' + IntToStr(cnt_), 0);
         For i := 0 to FileList.Count-1 Do Begin
           WriteLog(IntToStr(i+1) + ' ' + FileList[i], 0);
         End;

         // Обработка
         For i := 0 to FileList.Count-1 Do Begin
           WriteLog('Обрабатывается файл №' + IntToStr(i+1) + ' ' + FileList[i], 0);
           FileBody := TStringList.Create;
           Try
             FileBody.LoadFromFile(FIngoingFolderIn + FileList[i]);
             If ParseFile(FileBody, FileList[i], FileType_) Then Begin
                // Если это МТ-подобный файл от ГЦВП, то перенести в папку Архивных 
                If FileType_ = 1 Then Begin
                    If CopyFile(PAnsiChar(FIngoingFolderIn + FileList[i]), PAnsiChar(FIngoingFolderArch + FileList[i]), False) Then Begin
                      WriteLog('Обработан успешно, перенесен в папку: ' + FIngoingFolderArch, 0);
                      If Not DeleteFile(PAnsiChar(FIngoingFolderIn + FileList[i])) Then Begin
                        WriteLog('Не возможно удалить файл ' + FIngoingFolderIn + FileList[i], 1);
                      End;
                    End
                    Else Begin
                      WriteLog('Обработан успешно, перенести в папку не удалось: ' + FIngoingFolderArch, 1);
                      // Останавливаем процесс
                      TimerIn.Enabled := False;
                      dxBarButtonStartIn.Down := False;
                    End;
                End
                // иначе это обычная МТ-шка, и её нужно скопировать в папку и для XML-Терминала, и в папку для Архивных сообщений
                Else Begin
                    If //CopyFile(PAnsiChar(FIngoingFolderIn + FileList[i]), PAnsiChar(FIngoingFolderOk + FileList[i]), False) And
                       CopyFile(PAnsiChar(FIngoingFolderIn + FileList[i]), PAnsiChar(FIngoingFolderArch + FileList[i]), False) Then Begin
                      WriteLog('Обработан успешно, перенесен в папку: ' + FIngoingFolderOk, 0);
                      If Not DeleteFile(PAnsiChar(FIngoingFolderIn + FileList[i])) Then Begin
                        WriteLog('Не возможно удалить файл ' + FIngoingFolderIn + FileList[i], 1);
                      End;
                    End
                    Else Begin
                      WriteLog('Обработан успешно, перенести в папку не удалось: ' + FIngoingFolderOk, 1);
                      // Останавливаем процесс
                      TimerIn.Enabled := False;
                      dxBarButtonStartIn.Down := False;
                    End;
                End;
             End
             Else Begin
                If CopyFile(PAnsiChar(FIngoingFolderIn + FileList[i]), PAnsiChar(FIngoingFolderErr + FileList[i]), False) Then Begin
                  WriteLog('Ошибки при обработке, перенесен в папку: ' + FIngoingFolderErr, 1);
                  If Not DeleteFile(PAnsiChar(FIngoingFolderIn + FileList[i])) Then Begin
                    WriteLog('Не возможно удалить файл ' + FIngoingFolderIn + FileList[i], 1);
                  End;
                End
                Else Begin
                  WriteLog('Ошибки при обработке, перенести в папку не удалось: ' + FIngoingFolderErr, 1);
                  TimerIn.Enabled := False;
                  dxBarButtonStartIn.Down := False;
                End;
             End;
           Except
             FileBody.Free;
           End;
         End;

      End
      Else Begin
         //LogRichEdit.Lines.Add('Нет файлов');
      End;
  Finally
     FileList.Free;
  End;

end;

procedure TProcessFilesForm.aOptionsExecute(Sender: TObject);
begin
  inherited;
  //
  Try
    FoldersSetupForm := TFoldersSetupForm.Create(Self);
    If FoldersSetupForm.ShowModal = mrOk Then Begin
      RefreshSetupParams(0);
    End;
  Finally
    FoldersSetupForm.Free;
  End;
end;


procedure TProcessFilesForm.aGroupColumnsExecute(Sender: TObject);
begin
  inherited;
  aGroupColumns.Checked := Not aGroupColumns.Checked;
  dxDBGrid.ShowGroupPanel := Not dxDBGrid.ShowGroupPanel;
end;

procedure TProcessFilesForm.aRefreshExecute(Sender: TObject);
begin
  inherited;
  ReadList;
end;

procedure TProcessFilesForm.PageControlChange(Sender: TObject);
begin
  inherited;
  if edDateBegin.Text = '' Then
    edDateBegin.Date := Date;
  if edDateEnd.Text = '' Then
    edDateEnd.Date := Date;

end;

procedure TProcessFilesForm.FormShow(Sender: TObject);
begin
  inherited;
  PageControl.ActivePageIndex := 0;
end;

procedure TProcessFilesForm.edDateBeginPropertiesChange(Sender: TObject);
begin
  inherited;
  ReadList;
end;

procedure TProcessFilesForm.edDateEndPropertiesChange(Sender: TObject);
begin
  inherited;
  ReadList;
end;

procedure TProcessFilesForm.UpdTimerTimer(Sender: TObject);
begin
  inherited;
  // На открытии окна надо переменной "PUpdate" выделить память,
  // а на закрытии - очистить
  If PUpdate^ = 1 Then Begin
    FFieldMT50 := FNewField50;
    UpdateSetupParams;
    PUpdate^ := 0;
    UpdTimer.Enabled := False;
  End;
end;

procedure TProcessFilesForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Dispose(PUpdate);
end;

end.
