// app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('DevOps labs');
});

app.get('/name/:name', (req, res) => {
  res.send(`Hello, ${req.params.name}!`);
});

app.get('/add/:a/:b', (req, res) => {
  const a = parseFloat(req.params.a);
  const b = parseFloat(req.params.b);
  
  if (isNaN(a) || isNaN(b)) {
    return res.status(400).send('Invalid numbers');
  }
  
  res.send(`${a + b}`);
});

module.exports = app;  