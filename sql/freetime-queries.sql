---
--- SQL Script implements sample queries on the freetime.sql database
---
--- @author(s): chv5
---

-- Get a list of all the users
SELECT *
FROM FTUser
;

-- Get a user password
SELECT userPassword
FROM FTUser
;

-- Get all times for a user
SELECT username, startTime, endTime, date
FROM FTUser, FreeTime
WHERE ID = userID
;

-- Get the groups a user is in
SELECT *
FROM FTUser, Groups, GroupMembers
WHERE FTUser.ID = memberID
AND Groups.ID = groupID
;

-- Get a user's friends
SELECT friendID
FROM FTUser U1, UserFriendsList, FTUser U2
WHERE U1.ID = userID
AND U2.ID = friendID
;

-- Get all of the interests options
SELECT *
FROM Interest
;