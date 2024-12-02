table 50102 PolicyTable
{
    Caption = 'Policy Table';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
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
        field(4; Period; Text[20])
        {
            Caption = 'Policy Period';
            DataClassification = ToBeClassified;
        }
        field(5; Category; Text[20])
        {
            Caption = 'Policy Category';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     // Add changes to field groups here
    // }

    // var
    //     myInt: Integer;

    // trigger OnInsert()
    // begin

    // end;

    // trigger OnModify()
    // begin

    // end;

    // trigger OnDelete()
    // begin

    // end;

    // trigger OnRename()
    // begin

    // end;

}