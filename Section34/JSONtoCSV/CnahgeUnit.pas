unit CnahgeUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs,System.JSON;

type
  TChangeForm = class(TForm)
    ChangeBTN: TButton;
    procedure ChangeBTNClick(Sender: TObject);
  end;

var
  ChangeForm: TChangeForm;

implementation

{$R *.dfm}

procedure TChangeForm.ChangeBTNClick(Sender: TObject);
var
  OpenDialog: TOpenTextFileDialog;
  JsonText: TStringList;
  JsonValue: TJSONValue;
  JsonObject: TJSONObject;
  RatesObject: TJSONObject;
  CsvFile: TStringList;
  CsvFileName, Key, Line: string;
  Pair: TJSONPair;
begin
  OpenDialog := TOpenTextFileDialog.Create(nil);
  JsonText := TStringList.Create;
  CsvFile := TStringList.Create;
  try
    OpenDialog.Filter := 'JSON Files (*.json)|*.json';
    if OpenDialog.Execute then
      begin
        // Load JSON from the selected file
        JsonText.LoadFromFile(OpenDialog.FileName);
        // Parse JSON safely
        JsonValue := TJSONObject.ParseJSONValue(JsonText.Text);
        if not Assigned(JsonValue) or not (JsonValue is TJSONObject) then
          begin
            ShowMessage('Invalid JSON format.');
            Exit;
          end;
        // Convert to JSON object
        JsonObject := JsonValue as TJSONObject;
        // Extract "rates" object
        if not JsonObject.TryGetValue<TJSONObject>('rates', RatesObject) then
          begin
            ShowMessage('"rates" field not found in JSON.');
            Exit;
          end;
        // Add CSV headers
        CsvFile.Add('Currency;Rate');
        // Iterate over all currency rates
        for Pair in RatesObject do
          begin
            Key := Pair.JsonString.Value;     // Currency code (e.g., USD, EUR)
            Line := Format('%s;%.4f', [Key, Pair.JsonValue.AsType<Double>]); // Format as CSV
            CsvFile.Add(Line);
          end;
        // Save CSV file
        CsvFileName := ChangeFileExt(OpenDialog.FileName, '.csv');
        CsvFile.SaveToFile(CsvFileName);
        ShowMessage('CSV file saved: ' + CsvFileName);
      end;
  finally
    OpenDialog.Free;
    JsonText.Free;
    CsvFile.Free;
    JsonValue.Free;
  end;
end;


end.
