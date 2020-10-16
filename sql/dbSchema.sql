--Draft schema for FreeTime server backend
--
-- @author(s) chv5
--

CREATE TABLE User (
	ID integer PRIMARY KEY,
    username varchar(10) NOT NULL,
    freetimeID integer REFERENCES FreeTime(ID)
	);

CREATE TABLE FreeTime (
    ID integer PRIMARY KEY,
    time freetime,
    date DATE
    );

CREATE TABLE Group (
	ID integer PRIMARY KEY, 
	groupname varchar(15) NOT NULL	
	);

CREATE TABLE GroupMembers (
    ID integer PRIMARY KEY,
    adminID integer REFERENCES FreeTime(ID),
    memberID integer REFERENCES FreeTime(ID)
    );

CREATE TABLE GroupEvent (
	groupID integer REFERENCES Group(ID),
    participants integer,
    date DATE, 
	eventTime timestamp
	);

