page 50104 "Policy Card"
{
    Caption = 'Policy Card';
    PageType = Card;
    SourceTable = "Policy Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Category field.';
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Code field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Description field.';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Period field.';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Price field.';
                }
            }

            group(Lines)
            {
                Caption = 'Lines';
                part(CustomerInsurances; "Customer Insurance List")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        CustomerInsuranceListPage: Page "Customer Insurance List";
        CustomerInsuranceRec: Record "Customer Insurance";
    begin
        // Filter the Customer Insurance List by the Policy Code of the current Policy
        CustomerInsuranceRec.SetRange("Policy Code", Rec."Code");
        CustomerInsuranceListPage.SetTableView(CustomerInsuranceRec);  // Apply the filter dynamically
    end;
}
