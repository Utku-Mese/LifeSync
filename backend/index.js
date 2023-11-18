const express = require("express");
const port = process.env.PORT || 8000;
const app = require("./app");

//HTTP serveri eklenmek istenirse; 2 türlüde çalışıyor kontrol edildi.
//const http = require("http");
//const server = http.createServer(app);
//server.listen olacak aşağısı
app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}`);
});
