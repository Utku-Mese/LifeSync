const express = require("express");
const router = express.Router();
const db = require("../../db");

router.get("/", async (req, res, next) => {
  try {
    const result = await db.query("SELECT * FROM sports");
    res.status(200).json(result[0]);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

router.get("/SportsID", async (req, res, next) => {
  try {
    const SportsID = req.params.SportsID;
    const result = await db.query(
      `SELECT * FROM sports WHERE SportsID =${SportsID}`
    );
    res.status(200).json(result[0]);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

router.get("/:Type", async (req, res, next) => {
  try {
    const Type = req.params.Type;
    const result = await db.query(`SELECT * FROM sports WHERE Type =${Type}`);
    res.status(200).json(result[0]);
  } catch (err) {
    console.log(err);
    res.status(404).json({
      message: "Bir hata meydana geldi.",
    });
  }
});

module.exports = router;
