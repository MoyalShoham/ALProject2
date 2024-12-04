tableextension 50102 "EXT Item Table" extends "Item"
{
    fields
    {
        // The PolicyType field
        field(50103; PolicyType; Code[20])
        {
            Caption = 'Policy Type';
            DataClassification = ToBeClassified;
        }

        // The PolicyDescription field
        field(50104; PolicyDescription; Text[100])
        {
            Caption = 'Policy Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Policy Table"."Description" where("Policy Code" = field(PolicyType)));
        }
    }


}
