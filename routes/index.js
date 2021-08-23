var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/search', function(req, res, next){
    // console.log(req.body.brands);
    // console.log(req.body.styles);
    // console.log(req.body.minPrice);
    // console.log(req.body.maxPrice);
    // console.log(req.body.size);
    req.pool.getConnection(function(err, connection){
      if(err){
          res.sendStatus(500);
          return;
      }
      //get the shoes that meet the price range and are available
      var resultPriceSize = [];
      var meetPriceSize = `
                    SELECT Shoes.itemID, Shoes.itemName, Shoes.brand, Shoes.price, ModelStock.size
                    FROM Shoes JOIN ModelStock
                    ON Shoes.itemID = ModelStock.itemID
                    WHERE Shoes.price >= ? AND Shoes.price <= ? AND ModelStock.stockNumber > 0 AND ModelStock.size >= ? && ModelStock.size <= ?;
                    `;
      connection.query(meetPriceSize, [req.body.minPrice, req.body.maxPrice, req.body.minSize, req.body.maxSize], function(err, rows, fields){
          connection.release();
          if(err){
              res.sendStatus(500);
              return;
          }
          resultPriceSize = rows;
          var resultPriceSizeBrand = [];
          if(req.body.brands[0] === ""){
              for(let index = 0; index < resultPriceSize.length; index++){
                  resultPriceSizeBrand.push(resultPriceSize[index]);
              }
          }
          //filter to get the correct brand
          else{
              for(let index = 0; index < resultPriceSize.length; index++){
                  for(let i = 0; i < req.body.brands.length; i++){
                      if(resultPriceSize[index].brand.toUpperCase() === req.body.brands[i].toUpperCase()){
                          resultPriceSizeBrand.push(resultPriceSize[index]);
                      }
                  }
              }
          }
          for(let index = 0; index < resultPriceSizeBrand.length; index++){
              resultPriceSizeBrand[index].styles = [];
          }
          var getStyles =  `SELECT ShoesStyle.itemID, Styles.styleName
                            FROM ShoesStyle JOIN Styles ON ShoesStyle.styleID = Styles.styleID`;
          //get all the styles then filter to get the styles of selected models
          connection.query(getStyles, function(err, rows, fields){
              if(err){
                  res.sendStatus(500);
                  return;
              }
              for(let index = 0; index < resultPriceSizeBrand.length; index++){
                  for(let i = 0; i < rows.length; i++){
                      if(rows[i].itemID == resultPriceSizeBrand[index].itemID){
                          resultPriceSizeBrand[index].styles.push(rows[i].styleName.toUpperCase());
                      }
                  }
              }
              for(let index = 0; index < req.body.styles.length; index++){
                  req.body.styles[index] = req.body.styles[index].toUpperCase();
              }
              var completeResult = [];
              if(req.body.styles[0] === ""){
                  completeResult = resultPriceSizeBrand;
              }
              else{
                  for(let index = 0; index < resultPriceSizeBrand.length; index++){
                      for(let i = 0; i < req.body.styles.length; i++){
                          if(resultPriceSizeBrand[index].styles.includes(req.body.styles[i])){
                              completeResult.push(resultPriceSizeBrand[index]);
                          }
                      }
                  }
              }
              for(let index = 0; index < completeResult.length; index++){
                  completeResult[index].colors = [];
              }
              var getColor = `SELECT ShoesColor.itemID, Colors.colorName
                                FROM ShoesColor JOIN Colors
                                ON ShoesColor.colorID = Colors.colorID`;
              //get the color of the shoes model
              connection.query(getColor, function(err, rows, fields){
                  if(err){
                      res.sendStatus(500);
                      return;
                  }
                  for(let index = 0; index < completeResult.length; index++){
                      for(let i = 0; i < rows.length; i++){
                          if(rows[i].itemID == completeResult[index].itemID){
                              completeResult[index].colors.push(rows[i].colorName);
                          }
                      }
                  }
                  var getStock = `SELECT recordID, itemID, size, stockNumber FROM ModelStock`;
                  //get the stock number of each size of a shoe model
                  connection.query(getStock, function(err, rows, fields){
                    if(err){
                      res.sendStatus(500);
                      return;
                    }
                    for(let index = 0; index < completeResult.length; index++){
                      completeResult[index].stockNumber = 0;
                      for(let i = 0; i < rows.length; i++){
                          if(rows[i].itemID == completeResult[index].itemID && rows[i].size == completeResult[index].size){
                              completeResult[index].stockNumber = rows[i].stockNumber;
                          }
                        }
                    }
                    res.send(completeResult);
                  });
              });

          });
      });
    });
});

module.exports = router;
