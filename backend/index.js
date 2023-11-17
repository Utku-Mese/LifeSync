const express = require('express');
const app = express();
const db = require("./db.js");
const port = 8000;

app.get('/food/:id', async (req, res) => {
    const data = await db.execute("SELECT * FROM food WHERE FoodID = ?", [req.params.id]);
    console.log(data);
    res.send(data[0]);
});



app.get('/food', async (req, res) => {
    const data = await db.execute("SELECT * FROM food");
    console.log(data);
    res.send(data[0]);
});

app.get('/', (req, res) => {
    res.send('Welcome to LifeSync API!');
});


app.listen(port, () => {
    console.log(`Listening at http://localhost:${port}`);
});
