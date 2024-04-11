const mongoose = require("mongoose");
const validator = require("validator");

const watchlist3Schema = new mongoose.Schema({
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
const newStock3 = new mongoose.model("3_watchlist", watchlist3Schema);

module.exports = newStock3;