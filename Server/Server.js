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
process.on('uncaughtException', function (err) {
    console.log(err);
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
app.get("/menu", function (req, res) {
    var body = '';
    req.on('data', function (data) {
        body += data;
        if (body.length > 1e6)
            req.connection.destroy();
    });
    req.on('end', function () {
        var get = qs.parse(body);
        database.menu(get["restaurant"], res)
    });
});
app.get("/section", function (req, res) {
    var body = '';
    req.on('data', function (data) {
        body += data;
        if (body.length > 1e6)
            req.connection.destroy();
    });
    req.on('end', function () {
        var get = qs.parse(body);
        database.menuSection(get["menu"], res)
    });
});
app.get("/items", function (req, res) {
    var body = '';
    req.on('data', function (data) {
        body += data;
        if (body.length > 1e6)
            req.connection.destroy();
    });
    req.on('end', function () {
        var get = qs.parse(body);
        database.items(get["section"], res)
    });
});
app.post("/new_request", function (req, res) {
    var body = '';
    req.on('data', function (data) {
        body += data;
        if (body.length > 1e6)
            req.connection.destroy();
    });
    req.on('end', function () {
        var post = qs.parse(body);
        console.log(JSON.stringify(post))
        database.request(post["user"], post["restaurant"], res)
    });
})