module.exports = function(){
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