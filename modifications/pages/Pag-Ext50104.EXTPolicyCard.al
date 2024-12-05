pageextension 50104 "Item Card Ext" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Policy Code"; Rec."Policy Code")
            {
                ApplicationArea = All;
                Caption = 'Policy Code';
                ToolTip = 'Select a policy type';
                TableRelation = "Policy Table"."Policy Code";
            }

            field(PolicyDescription; Rec.PolicyDescription)
            {
                ApplicationArea = All;
                Caption = 'Policy Description';
                ToolTip = 'Displays the description of the selected policy type';
            }
        }
    }
}
