const cds = require("@sap/cds");
const { SELECT } = require("@sap/cds/lib/ql/cds-ql");
module.exports = async function(){
    const northwind = await cds.connect.to('northwind');

    this.on('READ', 'Customers', req => {
        return Promise.all([northwind.run(SELECT.from("Customers")),SELECT.from("bookshop.CityGeoCodes")])
            .then(([customers,geoCodes])=>{
                return customers.map(customer=>{
                    let geoCode = geoCodes.find((entry)=>entry.city === customer.City && entry.country === customer.Country )
                    customer.geocode_lat = geoCode.geocode_lat;
                    customer.geocode_long = geoCode.geocode_long;
                    return customer;
                })
            });
    });

    this.on("getStock","Books",function(){
        return 100;
    });

    this.on("addStock","Books",async function(req){
        let book = await SELECT.one.from("Books").where({ID:req.params[0].ID});
        if(!book){
            req.error("Book not found");
            return;
        }
        console.log("Updating quanitity for ", book);
        book.stock += req.data.quantity;
        await UPDATE("Books").set({stock:book.stock}).where({ID:req.params[0].ID});
        return book;
    });

    this.before("CREATE","Books",function(req){
        if(req.data.stock < 100){
            req.notify("Low Stock");
        }
    })

    this.before("PATCH","Books.drafts",function(req){
        req.notify("Low Stock");
    })

    // this.on("CREATE","Books",function(req){
    //     if(req.data.stock > 25){
    //         req.data.title += " --10% Discount"
    //         req.data.Price =  req.data.Price * 0.9
    //     }
    //     return req.data
    // })

    this.after("READ","Books",function(data){
        for(let index in data){
            if(data[index].stock > 25){
                data[index].title += " --10% Discount"
                data[index].Price =  data[index].Price * 0.9
            }
        }
    })

    this.before("READ","Authors",function(){
        console.log("Read Authors Triggered")
    })
}