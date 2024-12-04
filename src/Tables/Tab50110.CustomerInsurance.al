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
            Editable = false;
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
                PeriodInDays: Integer;
            begin
                // Ensure Start Date is valid
                if Rec."Start Date" <> 0D then begin
                    // Find the policy record related to the given Policy Code
                    if PolicyRec.Get(Rec."Policy Code") then begin
                        // Ensure the Period value is greater than zero
                        if PolicyRec.Period > 0 then begin
                            // Convert Period (in years) to days (365 days per year)
                            PeriodInDays := PolicyRec.Period * 365;

                            // Calculate the End Date based on Start Date and Period in days
                            Rec."End Date" := CALCDATE('+' + Format(PeriodInDays) + 'D', Rec."Start Date");
                        end else begin
                            Error('Period from Policy Table should be greater than zero.');
                        end;
                    end else begin
                        Error('Policy not found for Code: %1', Rec."Policy Code");  // Improved error message
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

    trigger OnInsert()
    var
        LastCustomerInsuranceRec: Record "Customer Insurance";
        Line: Integer;
    begin
        // Filter records by the current Policy Code
        LastCustomerInsuranceRec.SetRange("Policy Code", Rec."Policy Code");

        // Find the last record for the given Policy Code
        if LastCustomerInsuranceRec.FindLast() then
            // If a record is found, set the Line No. to the last record's Line No. + 1
            Line := LastCustomerInsuranceRec."Line No." + 1
        else
            // If no records exist for this Policy Code, start from 0
            Line := 0;

        Rec."Line No." := Line;
    end;

}
