sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"bookshop/manageauthors/test/integration/pages/AuthorsList",
	"bookshop/manageauthors/test/integration/pages/AuthorsObjectPage",
	"bookshop/manageauthors/test/integration/pages/BooksObjectPage"
], function (JourneyRunner, AuthorsList, AuthorsObjectPage, BooksObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('bookshop/manageauthors') + '/test/flp.html#app-preview',
        pages: {
			onTheAuthorsList: AuthorsList,
			onTheAuthorsObjectPage: AuthorsObjectPage,
			onTheBooksObjectPage: BooksObjectPage
        },
        async: true
    });

    return runner;
});

