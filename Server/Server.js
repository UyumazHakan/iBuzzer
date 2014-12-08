/**
 * Created by Administrator on 07.12.2014.
 */

var http = require("http")
var express = require("express")
var bodyParser = require("body-parser")
var qs = require('querystring')
var app = express();
var database = require("./Database/DatabaseConnector.js")

var port = process.env.PORT || 5000;
app.listen(port, function () {
    console.log("Listening on " + port);
});

app.get("/restaurants", function (req, res) {
    database.restaurants(res)
});
app.post("/auth", function (req, res) {
    var body = '';
    req.on('data', function (data) {
        body += data;
        if (body.length > 1e6)
            req.connection.destroy();
    });
    req.on('end', function () {
        var post = qs.parse(body);
        console.log(JSON.stringify(post))
        database.auth(post["email"], post["pass"], res)
    });

});
