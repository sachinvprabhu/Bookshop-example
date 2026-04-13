sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/core/Messaging",	
    "sap/m/Popover",
	"sap/m/List",
	"sap/m/StandardListItem",
    "sap/m/QuickViewCard",
    "sap/m/QuickViewPage"
], (Controller, Messaging,Popover,List,StandardListItem,QuickViewCard,QuickViewPage) => {
    "use strict";

    return Controller.extend("bookshop.customersgeo.controller.RootView", {
        onInit: function() {
			const oProvider = this.byId("mapProvider");
			const osm = sap.ui.require.toUrl("bookshop/customersgeo/model/map-style.json");
			setTimeout(() => {
				oProvider.setStyleUrl(osm);
			});
		},

        spotClick: function(oEvent) {
			const oTarget = oEvent.getSource();
            let customerInformation = oTarget.getBindingContext().getObject();

			const oPopover = new Popover({
				title: "Customer Information",
				content: [
					new QuickViewCard({

                        pages:[
                            new QuickViewPage({
                                pageId:"page1",
                                title:customerInformation.ContactName,
                                header:customerInformation.Country,
                                description:customerInformation.City,
                            })
                        ]
                    })
				]
			});
			oTarget.addDependent(oPopover);
			oPopover.openBy(oTarget);
		}
    });
});