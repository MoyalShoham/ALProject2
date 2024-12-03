table 50110 "Customer Insurance"
{
    Caption = 'Customer Insurance';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Policy Code"; Code[20])
        {
            Caption = 'Policy Code';
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }

        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }

        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Name" where("No." = field("Customer No.")));
        }

        field(5; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                PolicyRec: Record "Policy Table";
                PeriodText: Text[10];
            begin
                // Ensure Start Date is valid
                if Rec."Start Date" <> 0D then begin
                    // Find the policy record related to the given Policy Code
                    if PolicyRec.Get(Rec."Policy Code") then begin
                        // Debugging: Print the Period value from Policy Table
                        Message('Retrieved Period from Policy Table: %1', PolicyRec.Period);

                        // Ensure the Period value is greater than zero
                        if PolicyRec.Period > 0 then begin
                            // Use the Period value from the Policy Table
                            PeriodText := Format(PolicyRec.Period) + 'D';
                            // Calculate the End Date based on Start Date and Period
                            Rec."End Date" := CALCDATE(PeriodText, Rec."Start Date");
                        end else begin
                            Error('Period from Policy Table should be greater than zero.');
                        end;
                    end else begin
                        Error('Policy not found for Code: %1', Rec."Policy Code");
                    end;
                end else begin
                    Error('Start Date cannot be empty.');
                end;
            end;
        }

        field(6; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = ToBeClassified;
        }

        field(7; Period; Integer)
        {
            Caption = 'Period (in days)';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Policy Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
