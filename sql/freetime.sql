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
DROP TABLE IF EXISTS GroupInvites;
CREATE TABLE FTUser (
	ID SERIAL PRIMARY KEY,
    username varchar(12) NOT NULL,
    userPassword varchar(64) NOT NULL
    );

CREATE TABLE Interest (
    ID integer PRIMARY KEY,
    interestName varchar(20) NOT NULL
);

-- To implement in the future
-- CREATE TABLE UserFriendsList (
--     userID integer REFERENCES FTUser(ID),
--     friendID integer NOT NULL,
--     FOREIGN KEY (friendID) REFERENCES FTUser(ID)
--     );

CREATE TABLE UserInterests (
    userID integer REFERENCES FTUser(ID),
    interestID integer REFERENCES Interest(ID)
    );

CREATE TABLE FreeTime (
    userID integer REFERENCES FTUser(ID),
    startTime varchar(4) NOT NULL,
    endTime varchar(4) NOT NULL,
    weekday varchar(9) NOT NULL
    );

CREATE TABLE Groups (
	ID SERIAL PRIMARY KEY,
	groupName varchar(20) NOT NULL,
    adminID integer REFERENCES FTUser(ID)
	);

--This keeps track of what groups a member is in
CREATE TABLE GroupMembers (
    memberID integer REFERENCES FTUser(ID),
    groupID integer REFERENCES Groups(ID)
    );

--This looks identical, but it's meant to be a middleman for a user getting entered into GroupMembers
-- To implement in the future
-- CREATE TABLE GroupInvites (
--     userID integer REFERENCES FTUser(ID),
--     groupID integer REFERENCES Groups(ID)
-- );

-- To implement in the future
-- CREATE TABLE GroupEvent (
--     ID SERIAL PRIMARY KEY,
-- 	groupID integer REFERENCES Groups(ID),
--     eventName varchar(20) NOT NULL,
--     startTime time,
--     endTime time,
--     date DATE
-- 	);

GRANT SELECT ON FTUser TO PUBLIC;
GRANT SELECT ON Interest TO PUBLIC;
--GRANT SELECT ON UserFriendsList TO PUBLIC;
GRANT SELECT ON UserInterests TO PUBLIC;
GRANT SELECT ON FreeTime TO PUBLIC;
GRANT SELECT ON Groups TO PUBLIC;
GRANT SELECT ON GroupMembers TO PUBLIC;
--GRANT SELECT ON GroupEvent TO PUBLIC;

--FTUser(ID, username, password)
INSERT INTO FTUser (username, userPassword) VALUES ('Bill', 'coin');
INSERT INTO FTUser (username, userPassword) VALUES ('Dill', 'pickle');
INSERT INTO FTUser (username, userPassword) VALUES ('Jill', 'abc123');
INSERT INTO FTUser (username, userPassword) VALUES ('Gill', 'thunder');
INSERT INTO FTUser (username, userPassword) VALUES ('David', 'password');

--FreeTime(userID, startTime, endTime, date)
--Bill's free time
INSERT INTO FreeTime VALUES (1, '8,0', '8,1', 'Sunday');
--Dill's free time
INSERT INTO FreeTime VALUES (2, '9,0', '9,1', 'Sunday');
INSERT INTO FreeTime VALUES (2, '9,1', '9,2', 'Saturday');
--Jill's free time
INSERT INTO FreeTime VALUES (3, '9,2', '9,3', 'Sunday');
INSERT INTO FreeTime VALUES (3, '9,0', '11,3', 'Monday');
INSERT INTO FreeTime VALUES (3, '9,0', '9,3', 'Tuesday');
INSERT INTO FreeTime VALUES (3, '9,0', '9,3', 'Wednesday');
INSERT INTO FreeTime VALUES (3, '9,0', '9,3', 'Thursday');
INSERT INTO FreeTime VALUES (3, '9,0', '9,3', 'Friday');
INSERT INTO FreeTime VALUES (3, '12,0', '12,2', 'Saturday');
INSERT INTO FreeTime VALUES (3, '14,0', '15,1', 'Saturday');
--Gill's free time
INSERT INTO FreeTime VALUES (4, '12,0', '14,0', 'Sunday');
--David's free time
INSERT INTO FreeTime VALUES (3, '10,0', '11,3', 'Monday');
INSERT INTO FreeTime VALUES (3, '12,0', '12,2', 'Saturday');
INSERT INTO FreeTime VALUES (3, '14,0', '15,1', 'Saturday');

-- To implement in the future
--UserFriendsList(userID, friendID)
--Everyone in group 1 is friends with each other
-- INSERT INTO UserFriendsList VALUES (1, 2);
-- INSERT INTO UserFriendsList VALUES (1, 3);
-- INSERT INTO UserFriendsList VALUES (1, 4);
-- INSERT INTO UserFriendsList VALUES (2, 1);
-- INSERT INTO UserFriendsList VALUES (2, 3);
-- INSERT INTO UserFriendsList VALUES (2, 4);
-- INSERT INTO UserFriendsList VALUES (3, 2);
-- INSERT INTO UserFriendsList VALUES (3, 1);
-- INSERT INTO UserFriendsList VALUES (3, 4);
-- INSERT INTO UserFriendsList VALUES (4, 2);
-- INSERT INTO UserFriendsList VALUES (4, 3);
-- INSERT INTO UserFriendsList VALUES (4, 1);
--Everyone in group 2 is friends with each other
-- INSERT INTO UserFriendsList VALUES (5, 6);
-- INSERT INTO UserFriendsList VALUES (5, 7);
-- INSERT INTO UserFriendsList VALUES (5, 8);
-- INSERT INTO UserFriendsList VALUES (6, 5);
-- INSERT INTO UserFriendsList VALUES (6, 7);
-- INSERT INTO UserFriendsList VALUES (6, 8);
-- INSERT INTO UserFriendsList VALUES (7, 6);
-- INSERT INTO UserFriendsList VALUES (7, 8);
-- INSERT INTO UserFriendsList VALUES (7, 5);
-- INSERT INTO UserFriendsList VALUES (8, 7);
-- INSERT INTO UserFriendsList VALUES (8, 6);
-- INSERT INTO UserFriendsList VALUES (8, 5);

--Interest(ID, interestName)
INSERT INTO Interest VALUES (1, 'Basketball');
INSERT INTO Interest VALUES (2, 'Ultimate Frisbee');
INSERT INTO Interest VALUES (3, 'Gaming');
INSERT INTO Interest VALUES (4, 'Movies');
INSERT INTO Interest VALUES (5, 'Concerts');
INSERT INTO Interest VALUES (6, 'Volleyball');
INSERT INTO Interest VALUES (7, 'Backpacking');
INSERT INTO Interest VALUES (8, 'Running');

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
INSERT INTO Groups (groupName, adminID) VALUES ('5th VanderLagerstein', 2);
INSERT INTO Groups (groupName, adminID) VALUES ('3rd Smith', 5);

--GroupMembers(groupID, memberID)
INSERT INTO GroupMembers VALUES (1, 1);
INSERT INTO GroupMembers VALUES (2, 1);
INSERT INTO GroupMembers VALUES (3, 1);
INSERT INTO GroupMembers VALUES (4, 1);
INSERT INTO GroupMembers VALUES (3, 2);

-- To be implemented in the future
--GroupEvent(ID, groupID, eventName, startTime, endTime, date)
--INSERT INTO GroupEvent (groupID, eventName, startTime, endTime, date) VALUES (1,    'Smash Tournament', '18:00:00', '20:00:00', '2020-10-22');