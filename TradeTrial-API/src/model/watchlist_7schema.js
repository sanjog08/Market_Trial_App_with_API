const mongoose = require("mongoose");
const validator = require("validator");

const watchlist7Schema = new mongoose.Schema({
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
const newStock7 = new mongoose.model("7_watchlist", watchlist7Schema);

module.exports = newStock7;