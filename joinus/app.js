var express = require('express');
var mysql = require('mysql')
var app = express();
var bodyParser = require("body-parser");
<link href="https://fonts.googleapis.com/css?family=Roboto:100,300,400" rel="stylesheet">
app.use(express.static(__dirname + "/public"))
app.set("view engine", 'ejs');
app.use(bodyParser.urlencoded({extended: true}));

var connection = mysql.createConnection(
    {
        host    :   'localhost',
        user    :   'root',
        database:   'join_us',
        password:   'Nl12345678'
    }
)
app.get("/", function(req, res){
    //find count of users in DB
    //respond with that count
    var q = "SELECT COUNT(*) AS count FROM users"
    connection.query(q, function(err, results){
        if (err) throw err;
        var count = results[0].count;
        console.log(results[0].count);
        res.send("we have "+ count+" users in our db");
    })
});

app.get("/count", function(req, res){
 var q = 'SELECT COUNT(*) as count FROM users';
 connection.query(q, function (error, results) {
 if (error) throw error;
 var msg = "We have " + results[0].count + " users";
 res.send(msg);
 });
});

app.get("/ejs", function(req, res){
 var q = 'SELECT COUNT(*) as count FROM users';
 connection.query(q, function (error, results) {
 if (error) throw error;
 var msg = "We have " + results[0].count + " users";
 var count = results[0].count;
 res.render("home", {data:count});

 //res.send(msg);

 });
});

app.post("/register", function(req, res){
    var email = req.body.email;
    var person = {
        email: email
    }
    connection.query("INSERT INTO users SET ?", person, function(err, result){
        if (err) throw err;
        res.redirect("/ejs")

    })
    //var person = {email: req.body.email}
});


app.listen({
    host: 'localhost',
    port:80
    },
    function () {
    console.log('App listening on port 80!');
});

