var USER_AUTH_SQL = "SELECT * FROM USER WHERE EMAIL=? AND PASSWORD=?"
var USER_REG_SQL = "INSERT INTO USER SET ?"
var GET_RESTAURANTS_SQL = "SELECT * FROM RESTAURANT"
var GET_MENU_SQL = "SELECT * FROM MENU WHERE RESTAURANT=?"
var GET_MENU_SECTION_SQL = "SELECT * FROM MENU_SECTION WHERE MENU=?"
var GET_ITEMS_SQL = "SELECT * FROM SECTION_ITEM WHERE MENU_SECTION=?"
var ADD_REQUEST_SQL = "INSERT INTO REQUEST SET ?"
var DONE_REQUEST_SQL = "UPDATE REQUEST SET IS_DONE=1 WHERE ID=?"
var mysql = require('mysql')
exports.restaurants = getRestaurants
exports.auth = validateUserAuth
exports.register = registerUser
exports.menu = getMenu
exports.menuSection = getMenuSection
exports.items = getItems
exports.request = addRequest
exports.doneRequest = doneRequest
var connection = mysql.createConnection(({
    host: 'localhost',
    port: 8889,
    user: 'root',
    password: '123',
    database: 'ibuzzer'
}))
connection.connect();


function validateUserAuth(email, pass, res) {
    connection.query(USER_AUTH_SQL, [email, pass], function (err, rows, fields) {
        if (err) throw err
        console.log(email + " " + pass)
        if (rows.length > 0) {
            res.end(JSON.stringify(rows[0]))
            console.log(JSON.stringify(rows[0]))
        } else
            res.end(JSON.stringify([200]))
    })
}
function registerUser(username, name, surname, email, pass) {
    var values = {USERNAME: username, NAME: name, SURNAME: surname, EMAIL: email, PASSWORD: pass}
    connection.query(USER_REG_SQL, values, function (err, results) {
        if (err) throw err
    })
}
function getRestaurants(res) {
    console.log("getRestaurants(res)")
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
function getMenu(restaurantID, res) {
    var results = []
    connection.query(GET_MENU_SQL, [restaurantID], function (err, rows, fields) {
        if (err) throw err
        for (var i = 0; i < rows.length; i++) {
            var result = {ID: rows[i].ID, NAME: rows[i].NAME}
            results.push(result)
        }
        res.end(JSON.stringify(results))
    })
}
function getMenuSection(menuID, res) {
    var results = []
    connection.query(GET_MENU_SECTION_SQL, [menuID], function (err, rows, fields) {
        if (err) throw err
        for (var i = 0; i < rows.length; i++) {
            var result = {ID: rows[i].ID, NAME: rows[i].NAME}
            results.push(result)
        }
        res.end(JSON.stringify(results))
    })
}
function getItems(sectionID, res) {
    var results = []
    connection.query(GET_ITEMS_SQL, [sectionID], function (err, rows, fields) {
        if (err) throw err
        for (var i = 0; i < rows.length; i++) {
            var result = {ID: rows[i].ID, NAME: rows[i].NAME, PRICE: rows[i].PRICE}
            results.push(result)
        }
        res.end(JSON.stringify(results))
    })
}
function addRequest(userID, restaurantID, res) {
    var values = {USER: userID, RESTAURANT: restaurantID, TIME: new Date(), IS_DONE: 0}
    connection.query(ADD_REQUEST_SQL, values, function (err, results) {
        if (err) throw err
        res.end(JSON.stringify(results.insertId))
    })
}
function doneRequest(id) {
    var values = [id]
    connection.query(DONE_REQUEST_SQL, values, function (err, results) {
        if (err) throw err
    })
}