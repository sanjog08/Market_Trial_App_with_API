const mongoose = require("mongoose");
const validator = require("validator");

const stocksSchema = new mongoose.Schema({
    stock_name: {
        type: String,
        required: true,
    },
    company_name: {
        type: String,
        required: true,
    },
    rate: {
        type: Number,
        required: true,
    }
});


// we will create a model
const Stock = new mongoose.model("stocks.all", stocksSchema);
// const newStock = new mongoose.model("1_watchlist", stocksSchema);

module.exports = Stock;