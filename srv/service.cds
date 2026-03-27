using { bookshop as my } from '../db/schema.cds';

@path : '/service/bookshopService'
service bookshopService
{
    
    entity Books as projection on my.Books;
    entity Authors as projection on my.Authors;
}


annotate bookshopService.Books with @(
    odata.draft.enabled : true,
    fiori.draft.enabled : true,
    odata.draft.bypass : true,

    UI.LineItem : [
        {
            $type : 'UI.DataField',
            Label : 'Title',
            Value : title
        },
        {
            $type : 'UI.DataField',
            Label : 'Description',
            Value : Description
        }
    ],

    UI.SelectionFields :[
        title
    ],

    UI.HeaderInfo : {
        Title : {
            $type : 'UI.DataField',
            Value : title
        },
        TypeName : 'Book',
        TypeNamePlural : 'Books',
        Description :{
            $type : 'UI.DataField',
            Value : Description
        }
    }
);



annotate bookshopService with @requires :
[
    'authenticated-user'
];
