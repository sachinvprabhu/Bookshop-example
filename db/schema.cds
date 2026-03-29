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
