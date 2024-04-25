const mongoose = require('mongoose');
const validator = require('validator');


const holdingSchema = new mongoose.Schema({
    stock_name: {
        type: String,
        require: true
    },
    company_name: {
        type: String,
        require: false
    },
    rate: {
        type: Number,
        require: true
    },
    se: {
        type: String,
        require: true
    },
    quantity: {
        type: Number,
        require: true
    },
    real_rate: {
        type: Number,
        require: false
    }
});

// we will add a new stock in the holdings page
const holdingStock = new mongoose.model('holding', holdingSchema);
module.exports = holdingStock;