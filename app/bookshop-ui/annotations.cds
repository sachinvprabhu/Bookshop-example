using bookshopService as service from '../../srv/service';
annotate service.Books with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'createdBy',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Description',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Price',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'stock',
                Value : stock
            },
            {
                $Type : 'UI.DataField',
                Label : 'title',
                Value : title,
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'bookshopService.addStock',
                Label : 'addStock',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Book Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Author Information',
            ID : 'AuthorInformation',
            Target : '@UI.FieldGroup#AuthorInformation',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            $type : 'UI.DataField',
            Label : 'Title',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            $type : 'UI.DataField',
            Label : 'Description',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : Price,
            Label : 'Price',
        },
        {
            $Type : 'UI.DataField',
            Value : author.name,
            Label : 'Author Name',
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#stock1',
            Label : 'Remaining Stock',
            @UI.Importance : #High,
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'bookshopService.addStock',
            Label : 'Add Stock',
        },
    ],
    UI.DataPoint #stock : {
        Value : stock,
        Visualization : #Progress,
        TargetValue : 100,
    },
    UI.DataPoint #stock1 : {
        Value : stock,
        Visualization : #Progress,
        Criticality: #VeryNegative,
        TargetValue : 100,
    },
    UI.FieldGroup #AuthorInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : author.name,
                Label : 'name',
                ![@Common.FieldControl] : #ReadOnly
            },
            {
                $Type : 'UI.DataField',
                Value : author_ID,
                Label : 'author_ID',
            },
        ],
    },
);

annotate service.Books with {
    author @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Authors',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : author_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
        ],
    }
};

