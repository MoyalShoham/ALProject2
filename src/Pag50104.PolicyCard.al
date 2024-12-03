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
        }
    }

    actions
    {
        area(Navigation)
        {
            action(OpenCustomerInsurances)
            {
                Caption = 'View Customer Insurances';
                trigger OnAction()
                var
                    CustomerInsuranceListPage: Page "Customer Insurance List";
                    CustomerInsuranceRec: Record "Customer Insurance";
                begin
                    // Set filter on the "Customer Insurance" record before opening the page
                    CustomerInsuranceRec.SetRange("Policy Code", Rec."Code");  // Filter on Policy Code
                    CustomerInsuranceListPage.SetTableView(CustomerInsuranceRec);  // Set the table view for the list page
                    CustomerInsuranceListPage.RunModal();  // Open the page
                end;
            }
        }
    }
}
