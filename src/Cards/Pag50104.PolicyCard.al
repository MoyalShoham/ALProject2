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
                field("Policy Code"; Rec."Policy Code")
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
                    SubPageLink = "Policy Code" = field("Policy Code");
                }
            }
        }
    }

}
