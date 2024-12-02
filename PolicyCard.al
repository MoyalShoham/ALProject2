page 50104 PolicyCard
{
    PageType = Card;
    // ApplicationArea = All;
    // UsageCategory = Administration;
    SourceTable = PolicyTable;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Description; 'Description ')
                {
                    ApplicationArea = All;

                }
                field(Price; 'Price ')
                {
                    ApplicationArea = All;

                }
                field(Period; 'Period ')
                {
                    ApplicationArea = All;

                }
                field(Category; 'Category ')
                {
                    ApplicationArea = All;

                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}