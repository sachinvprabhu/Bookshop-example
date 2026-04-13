namespace bookshop;

@odata.draft.enabled
entity Authors
{
    key ID : UUID;
    name : String(100);
    books : Association to many Books on books.author = $self;
}

entity Books
{
    key ID : UUID;
    createdBy  : String      @cds.on.insert : $user;
    Description : String(100);
    Price : Integer;
    stock : Integer;
    title : String(100);
    author : Association to one Authors;
}


entity CityGeoCodes {
    city : String(128);
    country : String(128);
    geocode : LatLong;
}

type LatLong{
    lat : Decimal(11, 8);
    long : Decimal(11, 8);
}