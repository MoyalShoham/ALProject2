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
            CalcFormula = lookup("Policy Table"."Description" where("Code" = field(PolicyType)));
        }
    }

    // Trigger to handle inserting a new record
    trigger OnInsert()
    var
        LastItem: Record "Policy Table";
        NewCode: Code[20];
    begin
        // Check if the "Code" field is already populated
        if Rec."PolicyType" = '' then begin
            // Find the last record by ordering in descending order and getting the first (most recent)
            if LastItem.FindLast then begin
                // Increment the "Code" using the IncSTR function
                NewCode := IncSTR(LastItem."Code");
                // Set the incremented value to the "Code" field
                Rec."PolicyType" := NewCode;
            end else
                // If no previous record exists, initialize the "Code" as needed (e.g., "000001")
                Rec."PolicyType" := '000001'; // Or any default value you want to use
        end;
    end;
}
