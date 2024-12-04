page 50111 "Customer Insurance List"
{
    PageType = ListPart;
    SourceTable = "Customer Insurance";
    Caption = 'Customer Insurances';
    AutoSplitKey = true;
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;

    // The SourceTableView is removed, as it will be applied dynamically.
    // This was causing the issue as the Policy Code filter cannot be set like this directly.

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    // Trigger to apply dynamic filtering based on Policy Code from the Parent Page
    trigger OnOpenPage()
    var
        ParentPolicyCardPage: Page "Policy Card";
        CustomerInsuranceRec: Record "Customer Insurance";
    begin
        // Set the filter for Customer Insurance records based on the Policy Code of the Parent Policy
        CustomerInsuranceRec.SetRange("Policy Code", Rec."Policy Code"); // Apply the filter dynamically
        CurrPage.SetTableView(CustomerInsuranceRec); // Apply the filtered table view to the list part
    end;
}
