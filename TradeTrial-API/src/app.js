const express = require("express");
const request = require("request");
const cheerio = require("cheerio");
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


allStockIds = [];
allwatchlist1StockIds = [];
allwatchlist2StockIds = [];
allwatchlist3StockIds = [];
allwatchlist4StockIds = [];
allwatchlist5StockIds = [];
allwatchlist6StockIds = [];
allwatchlist7StockIds = [];
allHoldingStockIds = [];


app.get("/", (req, res) => {
    res.send('Wellcome to the page of the Market Trial App!');
});

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


// GET method to get the rate of a stock by ID
app.get("/stocksymbol/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        const rate = await getStockRate(stockId);
        res.status(200).send(rate);
    } catch (err) {
        res.status(500).send(err.message);
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



// entry


// for watchlist-1
// GET method to store IDs in an array
app.get("/reload-1", async (req, res) => {
    try {
        const stocksData = await newStock1.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allwatchlist1StockIds = stocksData.map(stock => stock._id);

        console.log(allwatchlist1StockIds);
        res.send(stockIds);
        updateStockRates1();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getStockRate1 = async (stockId) => {
    try {
        const stockData = await newStock1.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateStockRates1 = async () => {
    try {
        for (const stockId of allwatchlist1StockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-1/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-1/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getStockRate1(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await newStock1.findByIdAndUpdate(stockId, { rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});


// for watchlist-2
// GET method to store IDs in an array
app.get("/reload-2", async (req, res) => {
    try {
        const stocksData = await newStock2.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allwatchlist2StockIds = stocksData.map(stock => stock._id);

        console.log(allwatchlist2StockIds);
        res.send(stockIds);
        updateStockRates2();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getStockRate2 = async (stockId) => {
    try {
        const stockData = await newStock2.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateStockRates2 = async () => {
    try {
        for (const stockId of allwatchlist2StockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-2/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-2/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getStockRate2(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await newStock2.findByIdAndUpdate(stockId, { rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});



// for watchlist-3
// GET method to store IDs in an array
app.get("/reload-3", async (req, res) => {
    try {
        const stocksData = await newStock3.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allwatchlist3StockIds = stocksData.map(stock => stock._id);

        console.log(allwatchlist3StockIds);
        res.send(stockIds);
        updateStockRates3();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getStockRate3 = async (stockId) => {
    try {
        const stockData = await newStock3.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateStockRates3 = async () => {
    try {
        for (const stockId of allwatchlist3StockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-3/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-3/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getStockRate3(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await newStock3.findByIdAndUpdate(stockId, { rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});



// for watchlist-4
// GET method to store IDs in an array
app.get("/reload-4", async (req, res) => {
    try {
        const stocksData = await newStock4.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allwatchlist4StockIds = stocksData.map(stock => stock._id);

        console.log(allwatchlist4StockIds);
        res.send(stockIds);
        updateStockRates4();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getStockRate4 = async (stockId) => {
    try {
        const stockData = await newStock4.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateStockRates4 = async () => {
    try {
        for (const stockId of allwatchlist4StockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-4/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-4/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getStockRate4(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await newStock4.findByIdAndUpdate(stockId, { rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});



// for watchlist-5
// GET method to store IDs in an array
app.get("/reload-5", async (req, res) => {
    try {
        const stocksData = await newStock5.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allwatchlist5StockIds = stocksData.map(stock => stock._id);

        console.log(allwatchlist5StockIds);
        res.send(stockIds);
        updateStockRates5();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getStockRate5 = async (stockId) => {
    try {
        const stockData = await newStock5.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateStockRates5 = async () => {
    try {
        for (const stockId of allwatchlist5StockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-5/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-5/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getStockRate5(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await newStock5.findByIdAndUpdate(stockId, { rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});



// for watchlist-6
// GET method to store IDs in an array
app.get("/reload-6", async (req, res) => {
    try {
        const stocksData = await newStock6.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allwatchlist6StockIds = stocksData.map(stock => stock._id);

        console.log(allwatchlist6StockIds);
        res.send(stockIds);
        updateStockRates6();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getStockRate6 = async (stockId) => {
    try {
        const stockData = await newStock6.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateStockRates6 = async () => {
    try {
        for (const stockId of allwatchlist6StockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-6/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-6/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getStockRate6(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await newStock6.findByIdAndUpdate(stockId, { rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});



// for watchlist-7
// GET method to store IDs in an array
app.get("/reload-7", async (req, res) => {
    try {
        const stocksData = await newStock7.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allwatchlist7StockIds = stocksData.map(stock => stock._id);

        console.log(allwatchlist7StockIds);
        res.send(stockIds);
        updateStockRates7();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getStockRate7 = async (stockId) => {
    try {
        const stockData = await newStock7.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateStockRates7 = async () => {
    try {
        for (const stockId of allwatchlist7StockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-7/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-7/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getStockRate7(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await newStock7.findByIdAndUpdate(stockId, { rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});



// for holding stocks
// GET method to store IDs in an array
app.get("/reload-holdings", async (req, res) => {
    try {
        const stocksData = await holdStock.find();

        // Extracting IDs from stocksData and storing them in an array
        const stockIds = stocksData.map(stock => stock._id);
        allHoldingStockIds = stocksData.map(stock => stock._id);

        console.log(allHoldingStockIds);
        res.send(stockIds);
        updateHoldingRates();
    } catch (err) {
        res.status(500).send(err);
    }
});

// id ---> stock_name ---> rate
const getHoldingRate = async (stockId) => {
    try {
        const stockData = await holdStock.findById(stockId);

        if (!stockData) {
            throw new Error("Stock not found");
        }

        const url = `https://www.google.com/finance/quote/${stockData.stock_name}:NSE?sa=X&sqi=2&ved=2ahUKEwjuz-ix38aFAxUvRmwGHTMwC0UQ3ecFegQINRAf`;

        // Make a request function
        return new Promise((resolve, reject) => {
            request(url, (err, response, html_rate) => {
                if (!err && response.statusCode == 200) {
                    // Extract rate from HTML
                    const rate = extract_rate(html_rate);
                    resolve(rate);
                    console.log(`rate from the main function is ${rate}`);
                    return rate;
                } else {
                    reject("Error fetching stock price");
                }
            });
        });
        
    } catch (err) {
        throw new Error(err.message);
    }
}

// id ---> update(rate) in allstocks db
const updateHoldingRates = async () => {
    try {
        for (const stockId of allHoldingStockIds) {
            // Sending a PUT request to update the rate of each stock
            await request.put(`http://localhost:7000/updaterate-hold/${stockId}`);
            console.log(`Rate updated for stock with ID: ${stockId}`);
        }
    } catch (err) {
        console.error('Error updating stock rates:', err);
    }
}
// PUT method to update the rate of a stock
app.put("/updaterate-hold/:id", async (req, res) => {
    try {
        const stockId = req.params.id;
        console.log(stockId);
        
        // Get the current rate from the function
        var newRate = await getHoldingRate(stockId);
        console.log(newRate);
        
        // Update the rate of the stock in the database
        await holdStock.findByIdAndUpdate(stockId, { real_rate: newRate });
        
        // Sending a success response
        res.status(200).send("Stock rate updated successfully.");
    } catch (err) {
        // Handling errors
        res.status(500).send(err.message);
    }
});



// required by id to rate function
const extract_rate = (html_rate) => {
    const $ = cheerio.load(html_rate);
    const element = $('.YMlKec.fxKbKc');
    const rate = element.text();
    const cost = rate.replace(/[^\d.]/g, '');
    console.log(`rate of the stock is ${rate}`);
    return cost;
}


// exit




app.listen(port, () => {
    console.log(`server is listening at port number --> ${port} <--`);
});