var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var mysql = require('mysql');

var dbConnectionPool = mysql.createPool({
    host: 'localhost',
    database: 'ShoesStore', //database name: ShoesStore
});

var session = require('express-session'); //install session for login function
var sanitizeHtml = require('sanitize-html'); //sanitize html for xss injection

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use(session({
    secret: 'a string of your choice',
    resave: false,
    saveUninitialized: true,
    cookie: {secure: false}
}));

//install mysql for database
app.use(function(req, res, next){ //session setting
   req.pool = dbConnectionPool;
   next();
});
app.use(express.static(path.join(__dirname, 'public')));

// sanitize  html in post requests
app.post('/search', function(req, res, next){
    for(let index = 0; index < req.body.brands.length; index++){
        req.body.brands[index] = sanitizeHtml(req.body.brands[index]);
    }
    for(let index = 0; index < req.body.styles.length; index++){
        req.body.styles[index] = sanitizeHtml(req.body.styles[index]);
    }

    next();
});

//middeware in here

app.use('/', indexRouter);
app.use('/users', usersRouter);

module.exports = app;
