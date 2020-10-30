---
--- SQL Script implements sample queries on the freetime.sql database
---
--- @author(s): chv5
---

-- Get a list of all the users
SELECT *
FROM User
;

-- Get a user password
SELECT userPassword
FROM User
;

-- Get all times for a user
SELECT *
FROM User, FreeTime
WHERE ID = userID
;

-- Get the groups a user is in
SELECT *
FROM User, Groups, GroupMembers
WHERE User.ID = memberID
AND Groups.ID = groupID
;

-- Get a user's friends
SELECT friendID
FROM User U1, UserFriendsList, User U2
WHERE U1.ID = userID
AND U2.ID = friendID
;