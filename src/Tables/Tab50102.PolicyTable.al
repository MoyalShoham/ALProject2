table 50102 "Policy Table"
{
    Caption = 'Policy Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Policy Code"; Code[20])
        {
            Caption = 'Policy Code';
            DataClassification = ToBeClassified;
        }

        field(2; Description; Text[40])
        {
            Caption = 'Policy Description';
            DataClassification = ToBeClassified;
        }

        field(3; Price; Decimal)
        {
            Caption = 'Policy Price';
            DataClassification = ToBeClassified;
        }

        field(4; Period; Integer)
        {
            Caption = 'Policy Period';
            DataClassification = ToBeClassified;
        }

        field(5; Category; Enum Categories)
        {
            Caption = 'Policy Category';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Policy Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        LastItem: Record "Policy Table";
        NewCode: Code[20];
    begin
        if Rec."Policy Code" = '' then begin
            if LastItem.FindLast then begin
                NewCode := IncSTR(LastItem."Policy Code");
                Rec."Policy Code" := NewCode;
            end else
                Rec."Policy Code" := '000001';
        end;
    end;
}
