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

                // Process the first matching item line
                if Item.Get(Line."No.") then begin
                    if PolicyTable.Get(Item."Policy Code") then begin
                        PolicyCode := PolicyTable."Policy Code";

                        // Find Customer Insurance record linked to this Policy Table
                        CustomerInsurance.SetRange("Policy Code", PolicyCode);
                        CustomerInsurance.SetRange("Customer No.", Line."Sell-to Customer No.");

                        if CustomerInsurance.FindFirst() then begin
                            // Use exact Start and End dates from Customer Insurance
                            StrStartDate := Format(CustomerInsurance."Start Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>');
                            // PolicyStartDate := Format(CustomerInsurance."Start Date", 0, '<Day2><Month2><Year,4>');
                            StrEndDate := Format(CustomerInsurance."End Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>');

                        end;
                    end;
                end;
            end;
        }

        add(Line)
        {
            column(PolicyCode; PolicyCode) { }
            column(StrStartDate; StrStartDate) { }
            column(StrEndDate; StrEndDate) { }
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