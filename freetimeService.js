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
    host: "suleiman.db.elephantsql.com",
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
router.get("/allusers",getAllData); //This is just for developer viewing of the DB, will delete later
router.post("/createuser", createUser);
router.post("/uploadtimes", uploadtimes);
router.post("/creategroup", creategroup);
router.post("/addgroupmember", addgroupmember);
router.delete("/deletedaytimes", deletedaytimes);
router.delete("/deleteweektimes", deleteweektimes);
router.delete("/deletegroup", deletegroup);
router.delete("/deletegroupmembers", deletegroupmembers);
router.get("/Interests", getInterests);
router.get("/User/Interests/:id", getUserInterests);
router.get("/User/Groups/:id", getUserGroups);
//router.get("/User/Groups/Members/:id", getUserGroupsMembers); // to be added again

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
    db.many(`SELECT id, username FROM FTUser`)
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
function getAllData(req, res, next) {
    db.many("SELECT * FROM FTUser")
      .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function getInterests(req, res, next) {
    db.many(`SELECT * FROM Interest`)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
//Creating a user
function createUser(req, res, next) {
    db.oneOrNone(`INSERT INTO FTUser (username, userPassword) VALUES ($(username), $(userPassword)) RETURNING id`, req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function getUserInterests(req, res, next) {
    db.many(`SELECT interestName, Interest.ID FROM Interest, UserInterests WHERE Interest.ID = UserInterests.interestID AND UserInterests.userID = ${req.params.id}`)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function getUserGroups(req, res, next) {
    db.many(`SELECT groupName, username FROM FTUser, Groups, GroupMembers WHERE Groups.ID = GroupMembers.groupID AND Groups.adminID = FTUser.ID AND GroupMembers.memberID = ${req.params.id}`)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function uploadtimes(req, res, next) {
    db.oneOrNone(`INSERT INTO FreeTime (userID, starttime, endtime, weekday) VALUES ($(userID), $(starttime), $(endtime), $(weekday))`, req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function creategroup(req, res, next) {
    db.oneOrNone(`INSERT INTO Groups (groupName, adminID) VALUES ($(groupName), $(adminID)) RETURNING id`, req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function addgroupmember(req, res, next) {
    db.oneOrNone(`INSERT INTO GroupMembers VALUES ($(memberID), $(groupID))`, req.body)
        .then(data => {
            res.send(data);
        })
        .catch(err => {
            next(err);
        })
}
function deletedaytimes(req, res, next) {
    db.oneOrNone(`DELETE FROM FreeTime WHERE userID=$(userID) AND weekday=$(weekday)`, req.body)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}
function deleteweektimes(req,res,next) {
    db.oneOrNone(`DELETE FROM FreeTime WHERE userID=$(userID)`, req.body)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}
function deletegroup(req, res, next) {
    db.oneOrNone(`DELETE FROM Groups WHERE groupID=$(groupID)`, req.body)
        .then(data => {
            returnDataOr404(res, data);
        })
        .catch(err => {
            next(err);
        });
}
function deletegroupmembers(req, res, next) {
    db.oneOrNone(`DELETE FROM groupmembers WHERE groupID=$(groupID)`, req.body)
    .then(data => {
        returnDataOr404(res, data);
    })
    .catch(err => {
        next(err);
    });
}
// To be added again --save
// function getUserGroupsMembers(req, res, next) {
//     db.many(`SELECT username, confirmed FROM FTUser, Groups, GroupMembers WHERE Groups.ID = GroupMembers.groupID AND GroupMembers.memberID = ${req.params.id}`)
//         .then(data => {
//             res.send(data);
//         })
//         .catch(err => {
//             next(err);
//         })
// }

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