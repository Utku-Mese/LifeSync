const express = require("express");
const router = express.Router();
const db = require("../../db");


/*
===>TEST VERİSİ<==
Hızlı test edebilmeniz için  expected .json file sample


{
    "IsApproved": "0",
    "Type":"xxxxx",
    "Name":"xxxxx",
    "Calories":"11",
    "Fat":"22.22",
    "Protein":"22.22",
    "Carbohydrate":"22.22"
}

===> Display şekilleri <===

 Şuan kullanılan ==> res.status(200).json(result);
  Çıktı düzenli ve metadata halinde değil. 
  Çıktı bir tek bir array bile döndürmüyor olabilir.
  Daha iyi bir display için bir meta display örneği =>
  -----------------------------------------
    const docs = await db.query('...');
    const result = {
        Listelenen girdi sayısı : docs.length,
        Yemekler : docs.map((doc)=> {
            return {
                Yemek-İsmi: docs.name,
                Kalori miktar: docs.calori,
                Tip: docs.type,
                Fat: docs.fat,
                Karbonhidrat-Oranı: docs.carbohydrate,
                Protein-miktarı: docs.protein
                Doğrulanmış-Ürün-Mü: docs.isApproved,
            }
        })
    }
    --------------------------------------------
  Bu Get metodu içeriği Daha iyi bir sonuç verecektir.
*/

//GET : Hepsini getir
router.get("/", async (req, res, next) => {
  try {
    const result = await db.query("SELECT * FROM foods");
    res.status(200).json(result[0]);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//GET : Req'deki ID'yi getir
router.get("/", async (req, res, next) => {
  try {
    const id = req.body.FoodID;
    const result = await db.query("SELECT * FROM foods WHERE FoodID = ?", [id]);
    res.status(200).json(result[0]);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//GET : Dizindeki ID'yi getir.
router.get("/:FoodID", async (req, res, next) => {
  try {
    const id = req.params.FoodID;

    const result = await db.query("SELECT * FROM foods WHERE FoodID = ?", [id]);
    res.status(200).json(result[0]);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//ID self-created
//POST : Tek bir yemek
router.post("/", async (req, res, next) => {
  try {
    console.log(req.body);

    const { IsApproved, Type, Name, Calories, Fat, Protein, Carbohydrate } =
      req.body;

    const query =
      "INSERT INTO  foods (IsApproved,Type, Name, Calories, Fat, Protein, Carbohydrate) VALUES(?,?,?,?,?,?,?)";
    const values = [
      IsApproved,
      Type,
      Name,
      Calories,
      Fat,
      Protein,
      Carbohydrate,
    ];
    const nonNull = values.map((value) => (value !== undefined ? value : null));

    await db.execute(query, nonNull);
    console.log("Başarıyla oluşturuldu");
    res.status(201).json({
      message: "Başarıyla oluşturuldu.",
    });
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//PATCH : ID gönderme ile
router.patch("/", async (req, res, next) => {
  try {
    const {
      IsApproved,
      Type,
      Name,
      Calories,
      Fat,
      Protein,
      Carbohydrate,
      FoodID,
    } = req.body;

    const query =
      "UPDATE foods SET IsApproved = ?, Type = ?, Name = ?, Calories = ?, Fat = ?, Protein = ?, Carbohydrate = ? WHERE FoodID = ?";

    const values = [
      IsApproved,
      Type,
      Name,
      Calories,
      Fat,
      Protein,
      Carbohydrate,
      FoodID,
    ];
    const nonNull = values.map((value) => (value !== undefined ? value : null));
    await db.execute(query, nonNull);

    console.log("Başarıyla güncellendi");
    res.status(200).json({
      message: "Başarıyla güncelledi.",
    });
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//PATCH : ID dizini ile
router.patch("/:FoodID", async (req, res, next) => {
  try {
    const FoodID = req.params.FoodID;
    const { IsApproved, Type, Name, Calories, Fat, Protein, Carbohydrate } =
      req.body;

    const query =
      "UPDATE foods SET IsApproved = ?, Type = ?, Name = ?, Calories = ?, Fat = ?, Protein = ?, Carbohydrate = ? WHERE FoodID = ?";

    const values = [
      IsApproved,
      Type,
      Name,
      Calories,
      Fat,
      Protein,
      Carbohydrate,
      FoodID,
    ];
    const nonNull = values.map((value) => (value !== undefined ? value : null));
    await db.execute(query, nonNull);

    console.log("Başarıyla güncellendi");
    res.status(200).json({
      message: "Başarıyla güncelledi.",
    });
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//DELETE : ID Gönderme ile
router.delete("/", async (req, res, next) => {
  try {
    const FoodID = req.body.FoodID;

    await db.execute("DELETE FROM foods WHERE FoodID =?", [FoodID]);

    console.log("Başarıyla Silidi");
    res.status(200).json({
      message: "Başarıyla Silindi.",
    });
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

// DELETE : ID Dizini ile
router.delete("/:FoodID", async (req, res, next) => {
  try {
    const FoodID = req.params.FoodID;

    await db.execute("DELETE FROM foods WHERE FoodID =?", [FoodID]);

    console.log("Başarıyla Silidi");
    res.status(200).json({
      message: "Başarıyla Silindi.",
    });
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

module.exports = router;
