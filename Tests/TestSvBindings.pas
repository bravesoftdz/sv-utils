unit TestSvBindings;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit 
  being tested.

}

interface

uses
  TestFramework, SvDesignPatterns, Classes, SvBindings, DSharp.Bindings, Rtti, SysUtils, DataObject,
  ViewTestBindings, Forms;

type
  // Test methods for class TDataBindManager

  TestTDataBindManager = class(TTestCase)
  private
    FForm: TfrmTest;
    FData: TData;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestBindView;
  end;

implementation

uses
  DateUtils,
  Graphics;

procedure TestTDataBindManager.SetUp;
begin
  FForm := TfrmTest.Create(Application);
  FData := TData.Create;
end;

procedure TestTDataBindManager.TearDown;
begin
  FForm.Free;
  FData.Free;
end;

procedure TestTDataBindManager.TestBindView;
begin
  FData.SetDefaults;

  TDataBindManager.BindView(FForm, FData, FForm.Binder);

  FForm.Show;

  CheckEqualsString(FData.Name, FForm.edt1.Text);
  CheckTrue(FForm.CheckBox1.Checked);
  CheckEquals(FData.ID, FForm.SpinEdit1.Value);
  CheckTrue(SameDate(FData.Date, FForm.DateTimePicker1.Date));
  CheckEquals(FData.Points, FForm.TrackBar1.Position);
  CheckEquals(FData.Color, FForm.ColorBox1.Selected);
  FData.Color := clGreen;
  CheckEquals(FData.Color, FForm.ColorBox1.Selected);
  CheckFalse(FForm.Button1.Enabled);
  FData.IsEnabled := True;
  CheckTrue(FForm.Button1.Enabled, 'Button Enabled hasnt changed');
  {TODO -oLinas -cGeneral : fix bindings for lists}
 // CheckEquals(3, FForm.ListBox1.Items.Count);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTDataBindManager.Suite);
end.

