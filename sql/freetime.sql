--Draft schema for FreeTime server backend
--
-- @author(s) chv5, das43
--

--Drop previous versions of the tables if they exist
DROP TABLE IF EXISTS FTUser CASCADE;
DROP TABLE IF EXISTS Interest CASCADE;
DROP TABLE IF EXISTS UserFriendsList;
DROP TABLE IF EXISTS UserInterests;
DROP TABLE IF EXISTS FreeTime;
DROP TABLE IF EXISTS Groups CASCADE;
DROP TABLE IF EXISTS GroupMembers;
DROP TABLE IF EXISTS GroupEvent;

CREATE TABLE FTUser (
	ID integer PRIMARY KEY,
    username varchar(12) NOT NULL,
    userPassword varchar(64) NOT NULL
    );

CREATE TABLE Interest (
    ID integer PRIMARY KEY,
    interestName varchar(20) NOT NULL
);

CREATE TABLE UserFriendsList (
    userID integer REFERENCES FTUser(ID),
    friendID integer NOT NULL,
    FOREIGN KEY (friendID) REFERENCES FTUser(ID)
    );

CREATE TABLE UserInterests (
    userID integer REFERENCES FTUser(ID),
    interestID integer REFERENCES Interest(ID)
    );

CREATE TABLE FreeTime (
    userID integer REFERENCES FTUser(ID),
    startTime time,
    endTime time,
    date DATE
    );

CREATE TABLE Groups (
	ID integer PRIMARY KEY, 
	groupName varchar(20) NOT NULL,
    adminID integer REFERENCES FTUser(ID)
	);

CREATE TABLE GroupMembers (
    memberID integer REFERENCES FTUser(ID),
    groupID integer REFERENCES Groups(ID),
    confirmed BOOLEAN 
    );

CREATE TABLE GroupEvent (
    ID integer PRIMARY KEY,
	groupID integer REFERENCES Groups(ID),
    eventName varchar(20) NOT NULL,
    startTime time,
    endTime time,
    date DATE
	);

GRANT SELECT ON FTUser TO PUBLIC;
GRANT SELECT ON Interest TO PUBLIC;
GRANT SELECT ON UserFriendsList TO PUBLIC;
GRANT SELECT ON UserInterests TO PUBLIC;
GRANT SELECT ON FreeTime TO PUBLIC;
GRANT SELECT ON Groups TO PUBLIC;
GRANT SELECT ON GroupMembers TO PUBLIC;
GRANT SELECT ON GroupEvent TO PUBLIC;

--FTUser(ID, username, password)
INSERT INTO FTUser VALUES (1, 'Bill', 'Baconstripsandbaconstrips');
INSERT INTO FTUser VALUES (2, 'Dill', 'Lionsandtigersandbears');
INSERT INTO FTUser VALUES (3, 'Jill', 'abc123');
INSERT INTO FTUser VALUES (4, 'Gill', 'turducken5');

INSERT INTO FTUser VALUES (5, 'Owen', 'fancyPants');
INSERT INTO FTUser VALUES (6, 'Josh', 'bearDown5!!');
INSERT INTO FTUser VALUES (7, 'Donald', 'quacker5?');
INSERT INTO FTUser VALUES (8, 'Michelange', 'fanta5ia');

--FreeTime(userID, startTime, endTime, date)
--Bill's free time
INSERT INTO FreeTime VALUES (1, '18:00:00', '19:00:00', '2020-10-22');
--Dill's free time - bigger than Bill's
INSERT INTO FreeTime VALUES (2, '17:00:00', '19:00:00', '2020-10-22');
INSERT INTO FreeTime VALUES (2, '04:30:00', '06:00:00', '2020-10-22');
--Jill's free time - same length as Dill's but offset by an hour
INSERT INTO FreeTime VALUES (3, '18:00:00', '20:00:00', '2020-10-22');
--Gill's free time - offset by half hour
INSERT INTO FreeTime VALUES (4, '17:30:00', '20:30:00', '2020-10-22');

--FreeTime(userID, startTime, endTime, date)
--Bill's free time
INSERT INTO FreeTime VALUES (5, '18:00:00', '19:00:00', '2020-10-22');
--Dill's free time - bigger than Bill's
INSERT INTO FreeTime VALUES (6, '17:00:00', '19:00:00', '2020-10-22');
INSERT INTO FreeTime VALUES (6, '04:30:00', '06:00:00', '2020-10-22');
--Jill's free time - same length as Dill's but offset by an hour
INSERT INTO FreeTime VALUES (7, '18:00:00', '20:00:00', '2020-10-22');
--Gill's free time - offset by half hour
INSERT INTO FreeTime VALUES (8, '17:30:00', '20:30:00', '2020-10-22');


--UserFriendsList(userID, friendID)
--Everyone in group 1 is friends with each other
INSERT INTO UserFriendsList VALUES (1, 2);
INSERT INTO UserFriendsList VALUES (1, 3);
INSERT INTO UserFriendsList VALUES (1, 4);
INSERT INTO UserFriendsList VALUES (2, 1);
INSERT INTO UserFriendsList VALUES (2, 3);
INSERT INTO UserFriendsList VALUES (2, 4);
INSERT INTO UserFriendsList VALUES (3, 2);
INSERT INTO UserFriendsList VALUES (3, 1);
INSERT INTO UserFriendsList VALUES (3, 4);
INSERT INTO UserFriendsList VALUES (4, 2);
INSERT INTO UserFriendsList VALUES (4, 3);
INSERT INTO UserFriendsList VALUES (4, 1);
--Everyone in group 2 is friends with each other
INSERT INTO UserFriendsList VALUES (5, 6);
INSERT INTO UserFriendsList VALUES (5, 7);
INSERT INTO UserFriendsList VALUES (5, 8);
INSERT INTO UserFriendsList VALUES (6, 5);
INSERT INTO UserFriendsList VALUES (6, 7);
INSERT INTO UserFriendsList VALUES (6, 8);
INSERT INTO UserFriendsList VALUES (7, 6);
INSERT INTO UserFriendsList VALUES (7, 8);
INSERT INTO UserFriendsList VALUES (7, 5);
INSERT INTO UserFriendsList VALUES (8, 7);
INSERT INTO UserFriendsList VALUES (8, 6);
INSERT INTO UserFriendsList VALUES (8, 5);

--Interest(ID, interestName)
INSERT INTO Interest VALUES (1, 'Basketball');
INSERT INTO Interest VALUES (2, 'Ultimate Frisbee');
INSERT INTO Interest VALUES (3, 'Gaming');
INSERT INTO Interest VALUES (4, 'Movies');
INSERT INTO Interest VALUES (5, 'Concerts');
INSERT INTO Interest VALUES (6, 'Volleyball');
INSERT INTO Interest VALUES (7, 'Backpacking');

--UserInterests(userID, interestID)
--Bill's interests
INSERT INTO UserInterests VALUES (1, 6);
INSERT INTO UserInterests VALUES (1, 1);
INSERT INTO UserInterests VALUES (1, 7);
INSERT INTO UserInterests VALUES (1, 2);
--Dill's interests
INSERT INTO UserInterests VALUES (2, 2);
INSERT INTO UserInterests VALUES (2, 3);
--Gill's interests
INSERT INTO UserInterests VALUES (3, 3);
INSERT INTO UserInterests VALUES (3, 7);
--Jill's interests
INSERT INTO UserInterests VALUES (4, 2);
INSERT INTO UserInterests VALUES (4, 7);

--Group(ID, groupName, adminID)
INSERT INTO Groups VALUES (1, '5th VanderLagerstein', 2);
INSERT INTO Groups VALUES (2, '3rd Smith', 5);

--GroupMembers(groupID, memberID)
INSERT INTO GroupMembers VALUES (1, 1, TRUE);
INSERT INTO GroupMembers VALUES (2, 1, TRUE);
INSERT INTO GroupMembers VALUES (3, 1, TRUE);
INSERT INTO GroupMembers VALUES (4, 1, TRUE);

INSERT INTO GroupMembers VALUES (5, 2, TRUE);
INSERT INTO GroupMembers VALUES (6, 2, TRUE);
INSERT INTO GroupMembers VALUES (7, 2, TRUE);
INSERT INTO GroupMembers VALUES (8, 2, TRUE);

--GroupEvent(ID, groupID, eventName, startTime, endTime, date)
INSERT INTO GroupEvent VALUES (1, 1,    'Smash Tournament', '18:00:00', '20:00:00', '2020-10-22');