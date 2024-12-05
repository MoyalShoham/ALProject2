pageextension 50104 "EXT Policy Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field(PolicyType; Rec.PolicyType)
            {
                ApplicationArea = All;
                Caption = 'Policy Type';
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
