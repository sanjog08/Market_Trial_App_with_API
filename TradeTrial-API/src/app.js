const express = require("express");
require("./db/conn");
const Stock  = require("./model/allStocksSchema");
const newStock1 = require("./model/watchlist_1schema");
const newStock2 = require("./model/watchlist_2schema");
const newStock3 = require("./model/watchlist_3schema");
const newStock4 = require("./model/watchlist_4schema");
const newStock5 = require("./model/watchlist_5schema");
const newStock6 = require("./model/watchlist_6schema");
const newStock7 = require("./model/watchlist_7schema");
const holdStock = require("./model/holdingsSchema");
const app = express();
const port = process.env.PORT  || 7000;

// to get data from the postman in our terminal
app.use(express.json());


// create a new stock_data
app.post("/stock", async (req, res) => {

    console.log(req.body);
    let user;
    try{
        user = new Stock(req.body);
        await user.save();
    }catch(err){
        console.log(err);
        res.status(404).send(err.message);
        return 
    }
    res.status(201).send(user);
});


// get method to display all stocks from stocks.all 
app.get("/stocks", async (req, res) => {

    try {
        const stocksData = await Stock.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }

});


// get method to search from the stocks.all chatgpt made
app.get("/stocks/search", async (req, res) => {
    const query = req.query.q;
    try {
      const stocks = await Stock.find({ stock_name: { $regex: new RegExp(query, "i") } });
      res.send(stocks);
    } catch (err) {
      res.status(500).json({ message: err.message });
    }
  });


// to get a particular stock to display
app.get("/stock/:id", async (req, res) => {

    try {
        const _id = req.params.id;
        const stockData = await Stock.findById(_id);
        console.log(stockData);

        if (!stockData) {
            return res.status(404).send();
        }
        else {
            res.send(stockData);
        }
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from stocks.all
app.delete("/delstocks/:id", async (req, res) => {
    try {
        const deleteStock = await Stock.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});



// POST route to upload data to 1_watchlist collection by ID of the data from stocks.all collection
app.post('/watchlist_1/:id', async (req, res) => {
    try {
      const _id = req.params.id;
      const upload = await Stock.findById(_id);
  
      if (!upload) {
        return res.status(404).json({ message: 'Source _id for stock not found' });
      }
  
      // Create a new document in the target collection using data from the source document
      const newStockUpload = new newStock1({
        // Assuming Stock has fields that match the schema of newStock
        stock_name: upload.stock_name,
        company_name: upload.company_name,
        rate: upload.rate,
        // All the fields are coping from stocks.all to 1_watchlist
      });
  
      // Save the new document to the target collection
      await newStockUpload.save();
      res.status(201).json(newStockUpload);

    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
});


// POST route to upload data to 2_watchlist collection by ID of the data from stocks.all collection
app.post('/watchlist_2/:id', async (req, res) => {
    try {
      const _id = req.params.id;
      const upload = await Stock.findById(_id);
  
      if (!upload) {
        return res.status(404).json({ message: 'Source _id for stock not found' });
      }
  
      // Create a new document in the target collection using data from the source document
      const newStockUpload = new newStock2({
        // Assuming Stock has fields that match the schema of newStock
        stock_name: upload.stock_name,
        company_name: upload.company_name,
        rate: upload.rate,
        // All the fields are coping from stocks.all to 1_watchlist
      });
  
      // Save the new document to the target collection
      await newStockUpload.save();
      res.status(201).json(newStockUpload);

    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
});


// POST route to upload data to 3_watchlist collection by ID of the data from stocks.all collection
app.post('/watchlist_3/:id', async (req, res) => {
    try {
      const _id = req.params.id;
      const upload = await Stock.findById(_id);
  
      if (!upload) {
        return res.status(404).json({ message: 'Source _id for stock not found' });
      }
  
      // Create a new document in the target collection using data from the source document
      const newStockUpload = new newStock3({
        // Assuming Stock has fields that match the schema of newStock
        stock_name: upload.stock_name,
        company_name: upload.company_name,
        rate: upload.rate,
        // All the fields are coping from stocks.all to 1_watchlist
      });
  
      // Save the new document to the target collection
      await newStockUpload.save();
      res.status(201).json(newStockUpload);

    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
});


// POST route to upload data to 4_watchlist collection by ID of the data from stocks.all collection
app.post('/watchlist_4/:id', async (req, res) => {
    try {
      const _id = req.params.id;
      const upload = await Stock.findById(_id);
  
      if (!upload) {
        return res.status(404).json({ message: 'Source _id for stock not found' });
      }
  
      // Create a new document in the target collection using data from the source document
      const newStockUpload = new newStock4({
        // Assuming Stock has fields that match the schema of newStock
        stock_name: upload.stock_name,
        company_name: upload.company_name,
        rate: upload.rate,
        // All the fields are coping from stocks.all to 1_watchlist
      });
  
      // Save the new document to the target collection
      await newStockUpload.save();
      res.status(201).json(newStockUpload);

    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
});


// POST route to upload data to 5_watchlist collection by ID of the data from stocks.all collection
app.post('/watchlist_5/:id', async (req, res) => {
    try {
      const _id = req.params.id;
      const upload = await Stock.findById(_id);
  
      if (!upload) {
        return res.status(404).json({ message: 'Source _id for stock not found' });
      }
  
      // Create a new document in the target collection using data from the source document
      const newStockUpload = new newStock5({
        // Assuming Stock has fields that match the schema of newStock
        stock_name: upload.stock_name,
        company_name: upload.company_name,
        rate: upload.rate,
        // All the fields are coping from stocks.all to 1_watchlist
      });
  
      // Save the new document to the target collection
      await newStockUpload.save();
      res.status(201).json(newStockUpload);

    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
});


// POST route to upload data to 6_watchlist collection by ID of the data from stocks.all collection
app.post('/watchlist_6/:id', async (req, res) => {
    try {
      const _id = req.params.id;
      const upload = await Stock.findById(_id);
  
      if (!upload) {
        return res.status(404).json({ message: 'Source _id for stock not found' });
      }
  
      // Create a new document in the target collection using data from the source document
      const newStockUpload = new newStock6({
        // Assuming Stock has fields that match the schema of newStock
        stock_name: upload.stock_name,
        company_name: upload.company_name,
        rate: upload.rate,
        // All the fields are coping from stocks.all to 1_watchlist
      });
  
      // Save the new document to the target collection
      await newStockUpload.save();
      res.status(201).json(newStockUpload);

    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
});


// POST route to upload data to 7_watchlist collection by ID of the data from stocks.all collection
app.post('/watchlist_7/:id', async (req, res) => {
    try {
      const _id = req.params.id;
      const upload = await Stock.findById(_id);
  
      if (!upload) {
        return res.status(404).json({ message: 'Source _id for stock not found' });
      }
  
      // Create a new document in the target collection using data from the source document
      const newStockUpload = new newStock7({
        // Assuming Stock has fields that match the schema of newStock
        stock_name: upload.stock_name,
        company_name: upload.company_name,
        rate: upload.rate,
        // All the fields are coping from stocks.all to 1_watchlist
      });
  
      // Save the new document to the target collection
      await newStockUpload.save();
      res.status(201).json(newStockUpload);

    } catch (err) {
      console.error(err);
      res.status(500).json({ message: 'Server error' });
    }
});



// to delete a stock by id from 1_watchlist
app.delete("/delwatchlist_1/:id", async (req, res) => {
    try {
        const deleteStock = await newStock1.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from 2_watchlist
app.delete("/delwatchlist_2/:id", async (req, res) => {
    try {
        const deleteStock = await newStock2.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from 3_watchlist
app.delete("/delwatchlist_3/:id", async (req, res) => {
    try {
        const deleteStock = await newStock3.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from 4_watchlist
app.delete("/delwatchlist_4/:id", async (req, res) => {
    try {
        const deleteStock = await newStock4.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from 5_watchlist
app.delete("/delwatchlist_5/:id", async (req, res) => {
    try {
        const deleteStock = await newStock5.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from 6_watchlist
app.delete("/delwatchlist_6/:id", async (req, res) => {
    try {
        const deleteStock = await newStock6.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from 7_watchlist
app.delete("/delwatchlist_7/:id", async (req, res) => {
    try {
        const deleteStock = await newStock7.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});



// get method to display all stocks from watchlist_1
app.get("/getwatchlist_1", async (req, res) => {
    
    try {
        const stocksData = await newStock1.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }
    
});


// get method to display all stocks from watchlist_2
app.get("/getwatchlist_2", async (req, res) => {
    
    try {
        const stocksData = await newStock2.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }
    
});


// get method to display all stocks from watchlist_3
app.get("/getwatchlist_3", async (req, res) => {
    
    try {
        const stocksData = await newStock3.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }
    
});


// get method to display all stocks from watchlist_4
app.get("/getwatchlist_4", async (req, res) => {
    
    try {
        const stocksData = await newStock4.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }

});


// get method to display all stocks from watchlist_5
app.get("/getwatchlist_5", async (req, res) => {
    
    try {
        const stocksData = await newStock5.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }
    
});


// get method to display all stocks from watchlist_6
app.get("/getwatchlist_6", async (req, res) => {
    
    try {
        const stocksData = await newStock6.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }
    
});


// get method to display all stocks from watchlist_7
app.get("/getwatchlist_7", async (req, res) => {

    try {
        const stocksData = await newStock7.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }

});


// create a new holding_stock
app.post("/holding", async (req, res) => {

    console.log(req.body);
    let user;
    try{
        user = new holdStock(req.body);
        await user.save();
    }catch(err){
        console.log(err);
        res.status(404).send(err.message);
        return 
    }
    res.status(201).send(user);
});


// get method to display all stocks from holdings
app.get("/holdings", async (req, res) => {

    try {
        const stocksData = await holdStock.find();
        res.send(stocksData);
    }catch (err) {
        res.send(err);
    }

});


// to get a particular stock to display from holding
app.get("/holding/:id", async (req, res) => {

    try {
        const _id = req.params.id;
        const stockData = await holdStock.findById(_id);
        console.log(stockData);

        if (!stockData) {
            return res.status(404).send();
        }
        else {
            res.send(stockData);
        }
    } catch (err) {
        res.status(500).send(err);
    }
});


// to delete a stock by id from holding
app.delete("/delholding/:id", async (req, res) => {
    try {
        const deleteStock = await holdStock.findByIdAndDelete(req.params.id);
        if (!req.params.id) {
            return res.status(400).send();
        }
        res.send(deleteStock);
    } catch (err) {
        res.status(500).send(err);
    }
});


// to update a stock after selling from holding list
app.patch("/sellholding/:id", async (req, res) => {
    try {
        const _id = req.params.id;
        const updatedStock = await holdStock.findByIdAndUpdate(_id, req.body, {
            new : true
        });
        if (!updatedStock) {
            res.status(404).send("Stock not found!");
            return;
        }
        res.send(updatedStock);
    } catch (err) {
        res.status(400).send(err);
    }
});


app.listen(port, () => {
    console.log(`server is listening at port number --> ${port} <--`);
});
