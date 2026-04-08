using bookshopService as service from '../../srv/service';
annotate service.Authors with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'name',
                Value : name,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Books by Author',
            ID : 'BooksbyAuthor',
            Target : 'books/@UI.LineItem#BooksbyAuthor',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'name',
            Value : name,
        },
    ],
    UI.SelectionFields : [
        name,
        ID,
    ],
);

annotate service.Authors with {
    name @Common.Label : 'name'
};

annotate service.Authors with {
    ID @Common.Label : 'ID'
};

annotate service.Books with @(
    UI.LineItem #BooksbyAuthor : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'title',
        },
        {
            $Type : 'UI.DataField',
            Value : stock,
            Label : 'stock',
        },
        {
            $Type : 'UI.DataField',
            Value : Price,
            Label : 'Price',
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
            Label : 'Description',
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'bookshopService.addStock',
            Label : 'addStock',
            Inline : true,
        },
    ]
);

