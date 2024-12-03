tableextension 50102 "EXT Item Table" extends "Item"
{
    fields
    {
        field(50103; PolicyType; Code[20])
        {
            Caption = 'Policy Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Policy Table"."Description" where("Code" = field(PolicyType)));
        }
    }
}
