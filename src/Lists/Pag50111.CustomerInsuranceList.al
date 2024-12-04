page 50111 "Customer Insurance List"
{
    Caption = 'Customer Insurance List';
    PageType = ListPart;
    SourceTable = "Customer Insurance";
    // ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                // field("Description"; Rec."")
                // field("Policy Code"; Rec."Policy Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
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
                // field("Period"; Rec.Period)
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewLine)
            {
                Caption = 'New Line';
                Image = New;
                trigger OnAction()
                var
                    CustomerInsuranceRec: Record "Customer Insurance";
                begin
                    // Insert a new line and set the Line No.
                    CustomerInsuranceRec.Init();
                    CustomerInsuranceRec."Policy Code" := Rec."Policy Code"; // Set Policy Code
                    CustomerInsuranceRec.Insert();
                end;
            }
        }
    }

    // trigger OnOpenPage()
    // var
    //     CustomerInsuranceRec: Record "Customer Insurance";
    // begin
    //     // Filter Customer Insurance records by the current Policy Code
    //     CustomerInsuranceRec.SetRange("Policy Code", Rec."Policy Code");

    //     // Apply the filter dynamically on the page
    //     CurrPage.SetTableView(CustomerInsuranceRec);
    // end;
}
