const mongoose = require("mongoose");
const validator = require("validator");

const watchlist6Schema = new mongoose.Schema({
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
const newStock6 = new mongoose.model("6_watchlist", watchlist6Schema);

module.exports = newStock6;