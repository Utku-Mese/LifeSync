const express = require("express");
const router = express.Router();
const db = require("../../db");

/*

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

//! Query'ler kontrol edilmeli tekrar
//GET : Hepsini getir
router.get("/", async (req, res, next) => {
  try {
    //! table ismi kontrol edilmeli
    const result = await db.query("SELECT * FROM foodTable");
    res.status(200).json(result);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//! localhost:port/foodRoute dizini içine gönderilir.
//! Beklenen .json() formatında 'foodID' olması beklenir.
//GET : Req'deki ID'yi getir
router.get("/", async (req, res, next) => {
  try {
    const id = req.body.foodID;
    //! table ismi kontrol edilmeli
    const result = await db.query("SELECT * FROM foodTable WHERE id = ?", [id]);
    res.status(200).json(result);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

//! localhost:port/foodRoute/'foodID' dizini içine gönderilir.
//! Beklenen .json() formatında 'foodID' olması beklenmez.
//GET : Dizindeki ID'yi getir.
router.get("/:foodID", async (req, res, next) => {
  try {
    const id = req.params.foodID;
    //! table ismi kontrol edilmeli
    const result = await db.query("SELECT * FROM foodTable WHERE id = ?", [id]);
    res.status(200).json(result);
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
    //! case kontrolu ( büyük küçük harf) yapılmalı
    const { name, calori, type, fat, carboHydrate, protein, isApproved } =
      req.body;
    const query =
      "INSERT INTO  foodTable (name, calori, type, fat, carboHydrate, protein, isApproved) VALUES(?,?,?,?,?,?,?)";
    const values = [name, calori, type, fat, carboHydrate, protein, isApproved];
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

//! localhost:port/foodRoute dizini içine gönderilir.
//! Beklenen .json() formatında 'foodID' olması beklenir.
//PATCH : ID gönderme ile
router.patch("/", async (req, res, next) => {
  try {
    const id = req.body.foodID;
    const { name, calori, type, fat, carboHydrate, protein, isApproved } =
      req.body;
    //! 2 query de kullanılabilir.
    const query1 = `UPDATE Food SET name = ${name},  calori = ${calori}, type = ${type}, fat = ${fat}, carboHydrate = ${carboHydrate}, protein = ${protein}, isApproved = ${isApproved} WHERE id =${id}`;
    const query = `UPDATE Food SET name = ?,  calori = ?, type = ?, fat = ?, carboHydrate = ?, protein = ?, isApproved = ? WHERE id = ?`;

    const values = [
      name,
      calori,
      type,
      fat,
      carboHydrate,
      protein,
      isApproved,
      id,
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

//! localhost:port/foodRoute/'foodID' dizini içine gönderilir.
//! Beklenen .json() formatında 'foodID' olması beklenmez.
//PATCH : ID dizini ile
router.patch("/:foodID", async (req, res, next) => {
  try {
    const id = req.params.foodID;
    const { name, calori, type, fat, carboHydrate, protein, isApproved } =
      req.body;
    //! 2 query de kullanılabilir.
    const query1 = `UPDATE Food SET name = ${name},  calori = ${calori}, type = ${type}, fat = ${fat}, carboHydrate = ${carboHydrate}, protein = ${protein}, isApproved = ${isApproved} WHERE id =${id}`;
    const query = `UPDATE Food SET name = ?,  calori = ?, type = ?, fat = ?, carboHydrate = ?, protein = ?, isApproved = ? WHERE id = ?`;

    const values = [
      name,
      calori,
      type,
      fat,
      carboHydrate,
      protein,
      isApproved,
      id,
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

//! localhost:port/foodRoute' dizini içine gönderilir.
//! Beklenen .json() formatında 'foodID' olması beklenir.
//DELETE : ID Gönderme ile
router.delete("/", async (req, res, next) => {
  try {
    const id = req.body.foodID;

    await db.execute("DELETE FROM foodTable WHERE id =?", [id]);

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

//! localhost:port/foodRoute/'foodID' dizini içine gönderilir.
//! Beklenen .json() formatında 'foodID' olması beklenmez.
// DELETE : ID Dizini ile
router.delete("/", async (req, res, next) => {
  try {
    const id = req.body.foodID;

    await db.execute("DELETE FROM foodTable WHERE id =?", [id]);

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

router.get("/", async (req, res, next) => {
  try {
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});
