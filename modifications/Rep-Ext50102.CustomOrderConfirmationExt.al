reportextension 50102 "CustomOrderConfirmationExt" extends "Standard Sales - Order Conf."
{
    RDLCLayout = 'modifications\Layouts\StandardSalesOrderConf.rdl';

    dataset
    {
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            var
                Item: Record Item;
                PolicyTable: Record "Policy Table";
                CustomerInsurance: Record "Customer Insurance";
                SalesLine: Record "Sales Line";
            begin
                // Debug: Log Sales Header details
                Message('Processing Sales Header: %1, Customer: %2',
                    Header."No.",
                    Header."Sell-to Customer No.");

                // Reset variables
                PolicyStartDate := 0D;
                PolicyEndDate := 0D;
                PolicyCode := '';

                // Find Sales Lines for this Sales Header
                SalesLine.SetRange("Document Type", "Document Type");
                SalesLine.SetRange("Document No.", Header."No.");
                SalesLine.SetRange(Type, SalesLine.Type::Item);

                // Debug: Log number of Item lines found
                Message('Item Lines found: %1', SalesLine.Count);

                if SalesLine.FindFirst() then begin
                    // If records are found, process them
                    repeat
                        if Item.Get(SalesLine."No.") then begin
                            // Debug: Log Item details
                            Message('Item No: %1, Policy Code: %2',
                                Item."No.",
                                Item."Policy Code");

                            // Find Policy Table record
                            if PolicyTable.Get(Item."Policy Code") then begin
                                PolicyCode := PolicyTable."Policy Code";

                                // Debug: Log Policy Table details
                                Message('Policy Code: %1', PolicyCode);

                                // Find Customer Insurance record linked to this Policy Table
                                CustomerInsurance.SetRange("Policy Code", PolicyCode);
                                CustomerInsurance.SetRange("Customer No.", "Sell-to Customer No.");

                                // Debug: Log Customer Insurance details
                                Message('Customer Insurance Records: %1', CustomerInsurance.Count);

                                if CustomerInsurance.FindFirst() then begin
                                    PolicyStartDate := CustomerInsurance."Start Date";
                                    PolicyEndDate := CustomerInsurance."End Date";

                                    // Debug: Log Insurance details
                                    Message('Insurance Start Date: %1, End Date: %2',
                                        PolicyStartDate,
                                        PolicyEndDate);
                                end
                                else
                                    Message('No Customer Insurance found for Policy Code %1', PolicyCode);
                            end
                            else
                                Message('No Policy Table found for Code %1', Item."Policy Code");
                        end
                        else
                            Message('Item not found for Sales Line: %1', SalesLine."No.");
                    until SalesLine.Next() = 0;
                end
                else
                    Message('No Item lines found for Sales Header: %1', "No.");
            end;
        }

        add(Line)
        {
            column(PolicyCode; PolicyCode) { }
            column(PolicyStartDate; PolicyStartDate) { }
            column(PolicyEndDate; PolicyEndDate) { }
        }
    }

    requestpage
    {
        layout
        {
            // You can add additional controls to the request page if necessary
        }
    }

    var
        PolicyStartDate: Date;
        PolicyEndDate: Date;
        PolicyCode: Code[20];
}
