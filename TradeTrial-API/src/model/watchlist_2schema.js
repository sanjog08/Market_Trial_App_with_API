const mongoose = require("mongoose");
const validator = require("validator");

const watchlist2Schema = new mongoose.Schema({
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
const newStock2 = new mongoose.model("2_watchlist", watchlist2Schema);

module.exports = newStock2;
