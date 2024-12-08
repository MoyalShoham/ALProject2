codeunit 50101 "Sales Order Insurance Handler"
{
    // Subscribe to the OnAfterReleaseSalesDoc event
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    procedure OnAfterReleaseSalesOrder(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        CustomerInsurance: Record "Customer Insurance";
        Policy: Record "Policy Table";
        PolicyCode: Code[20];
        PolicyPrice: Decimal;
        CurrencyFactor: Decimal;
        CurrencyExchangeRate: Record "Currency Exchange Rate"; // Declare instance of the Currency Exchange Rate table
        Today: Date;
    begin
        Today := Today();  // Get the current date

        // Check if the Sales Header is an Order type
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            // Iterate through Sales Lines and create Customer Insurance records
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item); // Only process Item-type Sales Lines

            SalesLine.SetLoadFields("Document Type", "Document No.", "Line No.", Type, "No.", "Currency Code");
            SalesLine.ReadIsolation := IsolationLevel::ReadUncommitted;

            if SalesLine.FindSet() then
                repeat
                    // Ensure the Sales Line is an Item and fetch the Policy Code
                    if SalesLine.Type = SalesLine.Type::Item then begin
                        if Item.Get(SalesLine."No.") then begin
                            // Check if the Currency Code is defined for the Sales Line
                            if SalesLine."Currency Code" <> '' then begin
                                // Use the CurrencyExchangeRate record to call the ExchangeRate procedure
                                CurrencyFactor := CurrencyExchangeRate.ExchangeRate(Today, SalesLine."Currency Code");
                            end else begin
                                // If no Currency Code is provided, set CurrencyFactor to 1 (no conversion)
                                CurrencyFactor := 1;
                            end;

                            PolicyCode := Item."Policy Code"; // Get the Policy Code for the Item

                            // If a Policy Code is found, fetch the Policy record
                            if PolicyCode <> '' then begin
                                if Policy.Get(PolicyCode) then begin
                                    // Check if the Policy Price is valid (not zero)
                                    if Policy."Price" = 0 then
                                        Error('Policy price is zero for Policy Code: %1', PolicyCode);

                                    // If the Policy Price is valid, apply the currency conversion (if any)
                                    PolicyPrice := Policy."Price" * CurrencyFactor; // Convert the price if CurrencyFactor is greater than 1

                                    // Set the converted price or the base price
                                    Policy."Price" := PolicyPrice;

                                    // Now create the Customer Insurance record
                                    CustomerInsurance.Init();
                                    CustomerInsurance."Policy Code" := PolicyCode;
                                    CustomerInsurance."Customer No." := SalesHeader."Sell-to Customer No."; // Customer from Sales Order
                                    CustomerInsurance.Validate("Start Date", SalesHeader."Order Date"); // Validate Start Date

                                    // Insert the new Customer Insurance record
                                    CustomerInsurance.Insert(true);

                                    // Optional: Show a message confirming the creation of the insurance record
                                    Message('Created Customer Insurance record for Policy Code: %1 with price: %2', PolicyCode, PolicyPrice);
                                end else begin
                                    // Handle case where the Policy record is not found
                                    Error('Policy not found for Policy Code: %1', PolicyCode);
                                end;
                            end else begin
                                // Handle case where the Policy Code is empty
                                Error('Policy Code is empty for Item: %1', SalesLine."No.");
                            end;
                        end else begin
                            // Handle case where the Item doesn't exist
                            Error('Item %1 not found in the Item Table.', SalesLine."No.");
                        end;
                    end;
                until SalesLine.Next() = 0;
        end;
    end;
}
