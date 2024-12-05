pageextension 50105 "EXT Sales Order Policy" extends "Sales Order"
{
    actions
    {
        addlast(Processing)
        {
            action(AddPolicyForCustomerLine)
            {
                Caption = 'Add Policy for Customer';
                Image = Insurance;
                ApplicationArea = All;





                trigger OnAction()
                var
                    SalesLine: Record "Sales Line";
                    Item: Record Item; // Add Item record to fetch policy info from Item
                    CustomerInsurance: Record "Customer Insurance";
                    PolicyCode: Code[20];
                begin
                    // Iterate through all Sales Line items in the current Sales Order
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange(Type, SalesLine.Type::Item);

                    if SalesLine.FindSet() then
                        repeat
                            // Fetch the Policy Code from the Item record
                            if Item.Get(SalesLine."No.") then
                                PolicyCode := Item."Policy Code"; // Get the Policy Code from Item record

                            // If the item has a linked PolicyCode
                            if PolicyCode <> '' then begin
                                // Create a new Customer Insurance line
                                CustomerInsurance.Init();
                                CustomerInsurance."Policy Code" := PolicyCode;
                                CustomerInsurance."Customer No." := Rec."Sell-to Customer No."; // Customer from Sales Order
                                CustomerInsurance."Start Date" := Rec."Order Date"; // Start Date from Sales Order

                                // Ensure End Date is calculated by validating the Start Date
                                CustomerInsurance.Validate("Start Date", Rec."Order Date");

                                // Insert the new Customer Insurance record
                                CustomerInsurance.Insert(true);
                            end;
                        until SalesLine.Next() = 0;

                    Message('Policy lines added for items with policy codes.');
                end;
            }
        }

    }
}
