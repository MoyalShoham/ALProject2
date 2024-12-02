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
                TableRelation = "Policy Table"."Code";
            }
        }
    }
}
