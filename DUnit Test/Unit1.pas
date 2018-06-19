unit Unit1;
interface
uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
 Vcl.StdCtrls, Vcl.ComCtrls, System.Generics.Collections;
type
 TForm1 = class(TForm)
 RichEdit1: TRichEdit;
 RichEdit2: TRichEdit;
 Button1: TButton;
 Button2: TButton;
 procedure FormCreate(Sender: TObject);
 procedure FormDestroy(Sender: TObject);
 procedure Button1Click(Sender: TObject);
 procedure Button2Click(Sender: TObject);
 private
 public
 //Список индексов разных строк.
 differentStrings: TList<integer>;
 //Процедура сравнения текста.
 procedure Compare(ignoreCase: boolean);
 //Процедура подкрашивания различающихся строк.
 procedure ShowDifferences;
 end;
var
 Form1: TForm1;
implementation
{$R *.dfm}
uses Math;
procedure TForm1.Button1Click(Sender: TObject);
begin
 //Вызываем процедуру сравнения текста.
 Compare(false);
 //Вызываем процедуру подкрашивания различающихся строк.
 ShowDifferences;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
 //Вызываем процедуру сравнения текста.
 Compare(true);
 //Вызываем процедуру подкрашивания различающихся строк.
 ShowDifferences;
end;
procedure TForm1.FormCreate(Sender: TObject);
begin
 differentStrings := TList<integer>.Create;
end;
procedure TForm1.FormDestroy(Sender: TObject);
begin
 differentStrings.Free;
end;
procedure TForm1.Compare(ignoreCase: boolean);
begin
end;
procedure TForm1.ShowDifferences;
 function GetSelStart(const text: TStrings; const lineIndex: integer): integer;
 var
 i: integer;
 begin
 //Вычисляем индекс первого символа указанной строки текста.
 Result := 0;
 for i := 0 to lineIndex - 1 do
 Result := Result + Length(text[i]) + 1;
 end;
 procedure ShowTextLines(const richEdit: TRichEdit);
 var
 index: integer;
 begin
 //Подкрашиваем все строки в чёрный цвет.
 richEdit.SelectAll;
 richEdit.SelAttributes.Color := clBlack;
 //Подкрашиваем разницу.
 for index in differentStrings do
 if index < richEdit.Lines.Count then
 begin
 richEdit.SelStart := GetSelStart(richEdit.Lines, index);
 richEdit.SelLength := Length(richEdit.Lines[index]);
 richEdit.SelAttributes.Color := clRed;
 end;
 end;
begin
 //Подкрашиваем разницу в текстовом поле 1.
 ShowTextLines(RichEdit1);
 //Подкрашиваем разницу в текстовом поле 2.
 ShowTextLines(RichEdit2);
 RichEdit1.PlainText := true;
 ShowMessage(RichEdit1.Lines.Text);
 RichEdit1.PlainText := false;
 RichEdit1.Lines.SaveToFile('c:\temp\tst.txt');
 ShowMessage(RichEdit1.Lines[RichEdit1.Lines.Count - 1]);
end;
end.
