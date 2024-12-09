reportextension 50102 "CustomOrderConfirmationExt" extends "Standard Sales - Order Conf."
{
    RDLCLayout = 'modifications\Layouts\StandardSalesOrderConf.rdl';

    dataset
    {
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                // Initialize variables
                PolicyStartDate := 0D;
                PolicyEndDate := 0D;
                PolicyCode := '';

                // Find Sales Lines for this Line's Document
                SalesLine.SetRange("Document Type", Line."Document Type");
                SalesLine.SetRange("Document No.", Line."Document No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);

                if SalesLine.FindFirst() then begin
                    // Process the first matching item line
                    if Item.Get(SalesLine."No.") then begin
                        if PolicyTable.Get(Item."Policy Code") then begin
                            PolicyCode := PolicyTable."Policy Code";

                            // Find Customer Insurance record linked to this Policy Table
                            CustomerInsurance.SetRange("Policy Code", PolicyCode);
                            CustomerInsurance.SetRange("Customer No.", Line."Sell-to Customer No.");

                            if CustomerInsurance.FindFirst() then begin
                                // Use exact Start and End dates from Customer Insurance
                                StrStartDate := Format(CustomerInsurance."Start Date", 0, '<Day,2><Month,2><Year,4>');
                                // PolicyStartDate := Format(CustomerInsurance."Start Date", 0, '<Day2><Month2><Year,4>');
                                StrEndDate := Format(CustomerInsurance."End Date", 0, '<Day,2><Month,2><Year,4>');
                                // PolicyEndDate := CustomerInsurance."End Date";


                                // Optional: If you want to calculate end date based on start date and duration
                                // Uncomment and adjust if needed
                                // PolicyEndDate := CalcDate('<+1Y-1D>', PolicyStartDate);
                            end;
                        end;
                    end;
                end;
            end;
        }

        add(Line)
        {
            column(PolicyCode; PolicyCode) { }
            column(StrStartDate; PolicyStartDate) { }
            column(StrEndDate; PolicyEndDate) { }
        }
    }

    // Declare variables
    var
        StrStartDate: Text[20];
        StrEndDate: Text[20];
        PolicyStartDate: Date;
        PolicyEndDate: Date;
        PolicyCode: Code[20];
        Item: Record Item;
        PolicyTable: Record "Policy Table";
        CustomerInsurance: Record "Customer Insurance";
        SalesLine: Record "Sales Line";
}