const express = require("express");
const port = 8000;
const app = require("./app");

app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}`);
});
