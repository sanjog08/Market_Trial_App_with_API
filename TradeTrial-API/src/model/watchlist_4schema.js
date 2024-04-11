const mongoose = require("mongoose");
const validator = require("validator");

const watchlist4Schema = new mongoose.Schema({
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
const newStock4 = new mongoose.model("4_watchlist", watchlist4Schema);

module.exports = newStock4;