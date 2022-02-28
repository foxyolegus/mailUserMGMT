const express = require('express');
const exphbs = require('express-handlebars');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const Connection = require('mysql/lib/Connection');
const req = require('express/lib/request');

require('dotenv').config();

const app = express();
const port = process.env.PORT || 5000;

// Parsing middleware
// Parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: false }));
//app.use(express.urlencoded({extended: true})); // New

// Parse application/json
app.use(bodyParser.json());
//app.use(express.json()); // New

// Static Files
app.use(express.static('public'));

// Templating engine
//app.engine('hbs', exphbs({ extname: '.hbs' }));
//app.set('view engine', 'hbs');
// Update to 6.0.X
const handlebars = exphbs.create({ extname: '.hbs',});
app.engine('.hbs', handlebars.engine);
app.set('view engine', '.hbs');

const pool = mysql.createPool({
    connectionLimit: 100,
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

// Connect to DB
pool.getConnection((err, connection) => {
    if (err) throw err;
    console.log('Connected as ID ' + connection.threadId);
});

const routes = require('./server/routes/user');
app.use('/', routes);


// Connection Pool
// You don't need the connection here as we have it in userController
// let connection = mysql.createConnection({
//   host: process.env.DB_HOST,
//   user: process.env.DB_USER,
//   password: process.env.DB_PASS,
//   database: process.env.DB_NAME
// });

//const routes = require('./server/routes/user');
//app.use('/', routes);

app.listen(port, () => console.log(`Listening on port ${port}`));