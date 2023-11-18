const express = require("express");
const app = express();
const morgan = require("morgan");
const bodyParser = require("body-parser");

// router bağlantıları
const foodRoutes = require("./api/routes/foodRoute");

// Örnek
// const xxRoutes = require("./api/routes/xx.js");

//! middleware'lerden önce ( app.use'lar) yaz.

app.use(morgan("dev"));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

module.exports = app;
