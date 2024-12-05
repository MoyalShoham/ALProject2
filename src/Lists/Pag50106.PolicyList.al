page 50106 "Policy List"
{
    ApplicationArea = All;
    Caption = 'Policy List';
    PageType = List;
    SourceTable = "Policy Table";
    UsageCategory = Lists;
    CardPageId = "Policy Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Policy Code"; Rec."Policy Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Code field.', Comment = '%';
                }

                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Category field.', Comment = '%';
                }

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Description field.', Comment = '%';
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Period field.', Comment = '%';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Price field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(OpenPolicyCard)
            {
                Caption = 'Open Policy Card';
                trigger OnAction()
                var
                    PolicyCardPage: Page "Policy Card";
                begin
                    PolicyCardPage.SetTableView(Rec);  // Pass the selected record to the card page
                    PolicyCardPage.RunModal;
                end;
            }
        }
    }
}