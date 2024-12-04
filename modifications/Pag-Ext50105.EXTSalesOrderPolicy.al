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
                    PolicyTable: Record "Policy Table";
                    CustomerInsurance: Record "Customer Insurance";
                    PolicyType: Code[20];
                begin
                    // Iterate through all Sales Line items in the current Sales Order
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("Document No.", Rec."No.");
                    SalesLine.SetRange(Type, SalesLine.Type::Item);

                    if SalesLine.FindSet() then
                        repeat
                            // Check if the item has a PolicyType (policy linked)
                            PolicyType := ReturnPolicyTypeForItem(SalesLine."No.");

                            // If the item has a linked PolicyType
                            if PolicyType <> '' then begin
                                // Create a new Customer Insurance line
                                CustomerInsurance.Init();
                                CustomerInsurance."Policy Code" := PolicyType;
                                CustomerInsurance."Customer No." := Rec."Sell-to Customer No."; // Customer from Sales Order
                                CustomerInsurance."Start Date" := Rec."Order Date"; // Start Date from Sales Order

                                // Ensure End Date is calculated by validating the Start Date
                                CustomerInsurance.Validate("Start Date", Rec."Order Date");

                                // Insert the new Customer Insurance record
                                CustomerInsurance.Insert(true);
                            end;
                        until SalesLine.Next() = 0;

                    Message('Policy lines added for items with policy types.');
                end;
            }
        }
    }

    // Local function to return the Policy Type for an Item
    local procedure ReturnPolicyTypeForItem(ItemNo: Code[20]): Code[20]
    var
        Item: Record Item;
    begin
        // Check if the Item has a linked PolicyType
        if Item.Get(ItemNo) then
            exit(Item.PolicyType); // Return the Policy Type linked to the Item
        exit(''); // Return an empty string if no Policy Type is linked
    end;
}
