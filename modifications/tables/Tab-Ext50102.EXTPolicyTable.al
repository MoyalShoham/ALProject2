tableextension 50102 "EXT Item Table" extends "Item"
{
    fields
    {
        // The PolicyDescription field
        field(50104; PolicyDescription; Text[100])
        {
            Caption = 'Policy Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Policy Table"."Description" where("Policy Code" = field("Policy Code")));

        }

        field(50105; "Policy Code"; Code[20])
        {
            Caption = 'Policy Code';
            DataClassification = ToBeClassified;
            TableRelation = "Policy Table"."Policy Code";
        }

    }

    trigger OnAfterModify()
    var
        PolicyTable: Record "Policy Table";
        descriptionUpdate: Codeunit "Update Policy Description";

    begin
        descriptionUpdate.UpdatePolicyDescription("No.");
    end;

}
