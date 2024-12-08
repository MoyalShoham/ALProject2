codeunit 50101 "Sales Order Insurance Handler"
{
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

        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item); // Only process Item-type Sales Lines

            SalesLine.SetLoadFields("Document Type", "Document No.", "Line No.", Type, "No.", "Currency Code");
            SalesLine.ReadIsolation := IsolationLevel::ReadUncommitted;

            if SalesLine.FindSet() then
                repeat
                    if SalesLine.Type = SalesLine.Type::Item then begin
                        if Item.Get(SalesLine."No.") then begin
                            if SalesLine."Currency Code" <> '' then begin
                                CurrencyFactor := CurrencyExchangeRate.ExchangeRate(Today, SalesLine."Currency Code");
                            end else begin

                                CurrencyFactor := 1;
                            end;

                            PolicyCode := Item."Policy Code";

                            if PolicyCode <> '' then begin
                                if Policy.Get(PolicyCode) then begin
                                    if Policy."Price" = 0 then
                                        Error('Policy price is zero for Policy Code: %1', PolicyCode);

                                    PolicyPrice := Policy."Price" * CurrencyFactor;

                                    Policy."Price" := PolicyPrice;

                                    CustomerInsurance.Init();
                                    CustomerInsurance."Policy Code" := PolicyCode;
                                    CustomerInsurance."Customer No." := SalesHeader."Sell-to Customer No."; // Customer from Sales Order
                                    CustomerInsurance.Validate("Start Date", SalesHeader."Order Date"); // Validate Start Date

                                    CustomerInsurance.Insert(true);
                                    Message('Created Customer Insurance record for Policy Code: %1 with price: %2', PolicyCode, PolicyPrice);
                                end else begin
                                    Error('Policy not found for Policy Code: %1', PolicyCode);
                                end;
                            end else begin
                                Error('Policy Code is empty for Item: %1', SalesLine."No.");
                            end;
                        end else begin
                            Error('Item %1 not found in the Item Table.', SalesLine."No.");
                        end;
                    end;
                until SalesLine.Next() = 0;
        end;
    end;
}
