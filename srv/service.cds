using { bookshop as my } from '../db/schema.cds';
using { northwind as external } from './external/northwind';

@path : '/service/bookshopService'
service bookshopService
{
    entity Customers as
        select from external.Customers as cus LEFT JOIN my.CityGeoCodes as city on cus.City = city.city and cus.Country = city.country
        {
            *,
            key cus.CustomerID
        };

    
    
    entity Books as projection on my.Books actions{
        function getStock() returns Integer;
        action addStock(quantity : Integer) returns Books;
    };
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

annotate bookshopService.Authors with @(restrict:[
    { grant: '*', to: 'Manager_Role'}
]);

annotate bookshopService.Books with @(restrict:[
    { grant: '*', to: 'Manager_Role'},
    { grant: 'WRITE', to: 'Employee_Role'},
    { grant: 'READ', where: (createdBy = $user) }
]);
