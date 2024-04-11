const mongoose = require("mongoose");
const validator = require("validator");

const watchlist1Schema = new mongoose.Schema({
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
const newStock1 = new mongoose.model("1_watchlist", watchlist1Schema);

module.exports = newStock1;