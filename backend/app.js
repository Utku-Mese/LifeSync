const express = require("express");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");

// router bağlantıları
const foodRoutes = require("./api/routes/foodRoute");
const sportsRoutes = require("./api/routes/sportsRoute");
const newsRoutes = require("./api/routes/newsRoute")
const recipeRoutes = require("./api/routes/recipeRoute");

// Örnek
// const xxRoutes = require("./api/routes/xx.js");

//! middleware'lerden önce ( app.use'lar) yaz.

app.use(morgan("dev"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use("/foods", foodRoutes);
app.use("/sports", sportsRoutes);
app.use("/news", newsRoutes);
app.use("/recipes", recipeRoutes);

module.exports = app;