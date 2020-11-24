/**
 * This module implements a REST-inspired webservice for the Freetime DB.
 * The database is hosted on ElephantSQL.
 *
 * Currently, the service supports the player table only.
 *
 * @author: chv5
 * @date: Fall, 2020
 */

// Set up the database connection.

const pgp = require('pg-promise')();
const db = pgp({
    host: "lallah.db.elephantsql.com",
    port: 5432,
    database: process.env.USER,
    user: process.env.USER,
    password: process.env.PASSWORD
});

// Configure the server and its routes.

const express = require('express');
const app = express();
const port = process.env.PORT || 3000;
const router = express.Router();
router.use(express.json());

router.get("/", readHelloMessage);
//router.get("/address", function);

//Authentication routes
router.get("/Users", getUsers);
router.get("/Pass/:id", authenticatePassword);

router.get("/Interests", getInterests);


app.use(router);
app.use(errorHandler);
app.listen(port, () => console.log(`Listening on port ${port}`));

// Implement the CRUD operations.
//TODO: Is this really out of order?
function errorHandler(err, req, res) {
    if (app.get('env') === "development") {
        console.log(err);
    }
    res.sendStatus(err.status || 500);
}

function returnDataOr404(res, data) {
    if (data == null) {
        res.sendStatus(404);
    } else {
        res.send(data);
    }
}

function readHelloMessage(req, res) {
    res.send('Hello, CS 262 Freetime service!');
}




//Checking login details
function getUsers(req, res, next) {
    db.many("SELECT ID, username FROM FTUser")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function authenticatePassword(req, res, next) {
    db.oneOrNone(`SELECT * FROM FTUser WHERE id = ${req.params.id}`)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function getInterests(req, res, next) {
    db.many("SELECT * FROM Interest")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

/*
function readPlayers(req, res, next) {
    db.many("SELECT * FROM Player")
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}

function readPlayer(req, res, next) {
    db.oneOrNone(`SELECT * FROM Player WHERE id=${req.params.id}`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function updatePlayer(req, res, next) {
    db.oneOrNone(`UPDATE Player SET email=$(email), name=$(name) WHERE id=${req.params.id} RETURNING id`, req.body)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function createPlayer(req, res, next) {
    db.one(`INSERT INTO Player(email, name) VALUES ($(email), $(name)) RETURNING id`, req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        });
}

function deletePlayer(req, res, next) {
    db.oneOrNone(`DELETE FROM Player WHERE id=${req.params.id} RETURNING id`)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}

function getGames(req, res, next) {
    //Perform join query of players and theri respective playergames
    db.many("Select Player.ID, Player.name, PlayerGame.playerID, PlayerGame.score FROM Player INNER JOIN PlayerGame ON Player.ID = PlayerGame.playerID")
    .then(data => {
        res.send(data);
    })

    .catch(err => {
        next(err);
    })
}

**/