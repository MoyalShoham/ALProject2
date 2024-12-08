codeunit 50101 "Sales Order Insurance Handler"
{
    // Subscribe to the OnAfterReleaseSalesDoc event
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterReleaseSalesDoc, '', false, false)]
    procedure OnAfterReleaseSalesOrder(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var LinesWereModified: Boolean)
    var
        SalesLine: Record "Sales Line";
        Item: Record Item;
        CustomerInsurance: Record "Customer Insurance";
        PolicyCode: Code[20];
    begin
        // Check if the Sales Header is an Order type
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            // Iterate through Sales Lines and create Customer Insurance records
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.SetRange(Type, SalesLine.Type::Item); // Only process Item-type Sales Lines

            SalesLine.SetLoadFields("Document Type", "Document No.", "Line No.", Type, "No.");
            SalesLine.ReadIsolation := IsolationLevel::ReadUncommitted;

            if SalesLine.FindSet() then
                repeat
                    // Ensure the Sales Line is an Item and fetch the Policy Code
                    if SalesLine.Type = SalesLine.Type::Item then begin
                        if Item.Get(SalesLine."No.") then begin
                            PolicyCode := Item."Policy Code"; // Get the Policy Code for the Item

                            // If a Policy Code is found, create a Customer Insurance record
                            if PolicyCode <> '' then begin
                                CustomerInsurance.Init();
                                CustomerInsurance."Policy Code" := PolicyCode;
                                CustomerInsurance."Customer No." := SalesHeader."Sell-to Customer No."; // Customer from Sales Order
                                CustomerInsurance.Validate("Start Date", SalesHeader."Order Date"); // Validate Start Date

                                // Insert the new Customer Insurance record
                                CustomerInsurance.Insert(true);

                                // Optional: Show a message confirming the creation of the insurance record
                                Message('Created Customer Insurance record for Policy Code: %1', PolicyCode);
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
