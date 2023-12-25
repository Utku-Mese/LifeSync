const express = require("express");
const router = express.Router();
const db = require("../../db");

// Get all recipes
router.get("/", async (req, res, next) => {
    try {
        const result = await db.query("SELECT * FROM recipes");
        res.status(200).json(result[0]);
    } catch (err) {
        console.log(err);
        res.status(404).json({
            message: "Bir hata meydana geldi.",
        });
    }
});

// Get recipe by ID
router.get("/:RecipeID", async (req, res, next) => {
    try {
        const RecipeId = req.params.RecipeId;

        const result = await db.query("SELECT * FROM recipe WHERE recipeID = ?", [
            RecipeId,
        ]);
        res.status(200).json(result[0]);
    } catch (err) {
        console.log(err);
        res.status(404).json({
            message: "Bir hata meydana geldi.",
        });
    }
});

module.exports = router;