codeunit 50100 "Update Policy Description"
{
    procedure UpdatePolicyDescription(ItemNo: Code[20])
    var
        Item: Record Item;
        Policy: Record "Policy Table";
    begin
        if Item.Get(ItemNo) then begin
            if Policy.Get(Item."Policy Code") then begin
                Policy.Validate("Description", Item.Description);
                Policy.Modify(true);
            end;
        end;
    end;
}
