sap.ui.define([
    "sap/m/MessageToast",
    "sap/ui/model/json/JSONModel"
], function (MessageToast, JSONModel) {
    'use strict';
    return {
        /**
         * Generated event handler.
         *
         * @param oEvent the event object provided by the event provider.
         */
        readReviews: function (oEvent) {
            let serviceURL = this.routing.getView().getModel().getServiceUrl();
            let contextPath = this.routing.getView().getBindingContext().getPath();

            fetch(serviceURL + contextPath + "/getReviews")
                .then(response => response.json())
                .then(function (data) {
                    this.routing.getView().setModel(new JSONModel({ 
                        reviews: data.value
                    }), "json");
                }.bind(this));

        },
        postReview: function (oEvent) {
            let serviceURL = this.routing.getView().getModel().getServiceUrl();
            let contextPath = this.routing.getView().getBindingContext().getPath();

            fetch(serviceURL + contextPath + "/writeReview", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    review: this.byId("reviewBoox").getValue()
                })
            }).then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                MessageToast.show("Review Posted")
                this.byId("reviewBoox").setValue("");
                return fetch(serviceURL + contextPath + "/getReviews");
            })
            .then(response => response.json())
            .then(function (data) {
                this.routing.getView().setModel(new JSONModel({ reviews: data.value }), "json");
            }.bind(this))
            .catch(error => {
                console.error('Error:', error)

            });
        }
    };
});
