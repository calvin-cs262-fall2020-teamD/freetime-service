--Draft schema for FreeTime server backend
--
-- @author(s) chv5, das43
--

--Drop previous versions of the tables if they exist
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Interest;
DROP TABLE IF EXISTS UserFriendsList;
DROP TABLE IF EXISTS UserInterests;
DROP TABLE IF EXISTS FreeTime;
DROP TABLE IF EXISTS Groups;
DROP TABLE IF EXISTS GroupMembers;
DROP TABLE IF EXISTS GroupEvent;

CREATE TABLE User (
	ID integer PRIMARY KEY,
    username varchar(12) NOT NULL,
    userPassword varchar(64) NOT NULL
    );

CREATE TABLE Interest (
    ID integer PRIMARY KEY,
    interestName varchar(20) NOT NULL
);

CREATE TABLE UserFriendsList (
    userID integer REFERENCES User(ID),
    friendID integer NOT NULL,
    FOREIGN KEY (friendID) REFERENCES User(ID)
    );

CREATE TABLE UserInterests (
    userID integer REFERENCES User(ID),
    interestID integer REFERENCES Interest(ID)
    );

CREATE TABLE FreeTime (
    userID integer REFERENCES User(ID),
    startTime time,
    endTime time,
    date DATE
    );

CREATE TABLE Groups (
	ID integer PRIMARY KEY, 
	groupName varchar(15) NOT NULL,
    adminID integer REFERENCES User(ID)
	);

CREATE TABLE GroupMembers (
    memberID integer REFERENCES User(ID),
    groupID integer REFERENCES Groups(ID)
    );

CREATE TABLE GroupEvent (
    ID integer PRIMARY KEY,
	groupID integer REFERENCES Groups(ID),
    eventName varchar(20) NOT NULL,
    startTime time,
    endTime time,
    date DATE
	);

GRANT SELECT ON User TO PUBLIC;
GRANT SELECT ON Interest TO PUBLIC;
GRANT SELECT ON UserFriendsList TO PUBLIC;
GRANT SELECT ON UserInterests TO PUBLIC;
GRANT SELECT ON FreeTime TO PUBLIC;
GRANT SELECT ON Groups TO PUBLIC;
GRANT SELECT ON GroupMembers TO PUBLIC;
GRANT SELECT ON GroupEvent TO PUBLIC;