const mongoose = require("mongoose");
const validator = require("validator");

const watchlist5Schema = new mongoose.Schema({
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
const newStock5 = new mongoose.model("5_watchlist", watchlist5Schema);

module.exports = newStock5;