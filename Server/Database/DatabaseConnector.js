var USER_AUTH_SQL = "SELECT * FROM USER WHERE EMAIL=? AND PASSWORD=?"
var USER_REG_SQL = "INSERT INTO USER SET ?"
var GET_RESTAURANTS_SQL = "SELECT * FROM RESTAURANT"
var mysql = require('mysql')
var async = require('async')
exports.restaurants = getRestaurants
exports.auth = validateUserAuth
exports.register = registerUser
var connection = mysql.createConnection(({
    host: 'localhost',
    user: 'node',
    password: 'node',
    database: 'ibuzzer'
}))
connection.connect();


function validateUserAuth(email, pass, res) {
    connection.query(USER_AUTH_SQL, [email, pass], function (err, rows, fields) {
        if (err) throw err
        console.log(email + " " + pass)
        if (rows.length > 0) {
            res.end(JSON.stringify(rows[0]))
        } else
            res.end()
    })
}
function registerUser(username, name, surname, email, pass) {
    var values = {USERNAME: username, NAME: name, SURNAME: surname, EMAIL: email, PASSWORD: pass}
    connection.query(USER_REG_SQL, values, function (err, results) {
        if (err) throw err
    })
}
function getRestaurants(res) {
    var results = []
    connection.query(GET_RESTAURANTS_SQL, {}, function (err, rows, fields) {
        if (err) throw err
        for (var i = 0; i < rows.length; i++) {
            var result = {ID: rows[i].ID, NAME: rows[i].NAME, TYPE: rows[i].TYPE}
            results.push(result)
        }
        res.end(JSON.stringify(results))
    })
}