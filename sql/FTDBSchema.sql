--Draft schema for FreeTime server backend
--
-- @author(s) chv5
--

--Drop previous versions of the tables if they exist
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Interest;
DROP TABLE IF EXISTS UserFriendsList;
DROP TABLE IF EXISTS UserInterests;
DROP TABLE IF EXISTS FreeTime;
DROP TABLE IF EXISTS Group;
DROP TABLE IF EXISTS GroupMembers;
DROP TABLE IF EXISTS GroupEvent;

CREATE TABLE User (
	ID integer PRIMARY KEY,
    username varchar(10) NOT NULL,
    freetimeID integer REFERENCES FreeTime(ID),
	friendListID integer REFERENCES UserFriendsList(flID),
    groupAdminID integer REFERENCES Group(ID)
    );

CREATE TABLE Interest(
    ID integer PRIMARY KEY,
    interestName varchar(20) NOT NULL
);

CREATE TABLE UserFriendsList(
    flID integer NOT NULL,
    friendID integer NOT NULL,
    FOREIGN KEY (friendID) REFERENCES User(ID)
    );

CREATE TABLE UserInterests(
    userID integer REFERENCES User(ID),
    interestID integer REFERENCES Interest(ID)
    );

CREATE TABLE FreeTime (
    ID integer PRIMARY KEY,
    time freetime,
    date DATE
    );

CREATE TABLE Group (
	ID integer PRIMARY KEY, 
	groupname varchar(15) NOT NULL,
    adminMemberID integer REFERENCES User(ID),
	groupMembersID integer REFERENCES GroupMembers(ID),
    groupEvents integer REFERENCES GroupEvent(ID)
	);

CREATE TABLE GroupMembers (
    memberID integer REFERENCES User(ID),
    groupID integer REFERENCES Group(ID)
    );

CREATE TABLE GroupEvent (
	groupID integer REFERENCES Group(ID),
    participants integer REFERENCES GroupMembers(ID),
    date DATE, 
	eventTime timestamp
	);


GRANT SELECT ON User TO PUBLIC;
GRANT SELECT ON UserFriendsList TO PUBLIC;
GRANT SELECT ON UserInterests TO PUBLIC;
GRANT SELECT ON UserFree TO PUBLIC;
GRANT SELECT ON Interest TO PUBLIC;
GRANT SELECT ON FreeTime TO PUBLIC;
GRANT SELECT ON Group TO PUBLIC;
GRANT SELECT ON GroupMembers TO PUBLIC;
GRANT SELECT ON GroupEvent TO PUBLIC;