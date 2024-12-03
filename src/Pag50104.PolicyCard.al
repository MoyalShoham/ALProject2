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
            }
        }
    }
}
