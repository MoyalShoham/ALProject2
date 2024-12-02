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
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Category field.', Comment = '%';
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Policy Code field.', Comment = '%';
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
                // field(SystemCreatedAt; Rec.SystemCreatedAt)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemCreatedAt field.', Comment = '%';
                // }
                // field(SystemCreatedBy; Rec.SystemCreatedBy)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemCreatedBy field.', Comment = '%';
                // }
                // field(SystemId; Rec.SystemId)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemId field.', Comment = '%';
                // }
                // field(SystemModifiedAt; Rec.SystemModifiedAt)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemModifiedAt field.', Comment = '%';
                // }
                // field(SystemModifiedBy; Rec.SystemModifiedBy)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the SystemModifiedBy field.', Comment = '%';
                // }
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
                // Image = Information;

                trigger OnAction()
                var
                    PolicyCardPage: Page "Policy Card";
                begin
                    // Run the PolicyCard page in modal mode for the selected record
                    PolicyCardPage.SetTableView(Rec);  // Pass the selected record to the card page
                    PolicyCardPage.RunModal;
                end;
            }
        }
    }
}