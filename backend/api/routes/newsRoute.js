const express = require("express");
const router = express.Router();
const db = require("../../db");
//get(hepsi)  get(byID)  get(sorting by date)

//GET : Hepsini getir
router.get("/", async (req, res, next) => {
    try {
      const result = await db.query("SELECT * FROM news");
      res.status(200).json(result[0]);
    } catch (err) {
      console.log(err);
      res.status(404).json({
        message: "Bir hata meydana geldi.",
      });
    }
  });
//GET : ID'ye göre getir
  router.get("/:NewsID", async (req,res,next)=>{
    try {
        const NewsId = req.params.NewsId;
    
        const result = await db.query("SELECT * FROM news WHERE FoodID = ?", [NewsId]);
        res.status(200).json(result[0]);
      } catch (err) {
        console.log(err);
        res.status(404).json({
          message: "Bir hata meydana geldi.",
        });
      }

  })
  router.get("/:SortBy", async (req, res, next) => {
    try {
        if(req.params.SortBy==="date"){
            const result = await db.query("SELECT * FROM News WHERE SortBy");
            res.status(200).json(result[0]);


        }
        else{
            res.status(404).json({
                message: "Böyle bir sıralama yok",
              });
        }
    
      
    } catch (err) {
      console.log(err);
      res.status(404).json({
        message: "Bir hata meydana geldi.",
      });
    }
  });
  
module.exports = router;