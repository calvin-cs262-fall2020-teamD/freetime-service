--User(ID, username, freetimeID, groupAdminID)
INSERT INTO User VALUES (1, 'Bill', 1, NULL);
INSERT INTO User VALUES (2, 'Dill', 2, 1);

--FreeTime(userID, startTime, endTime, date)
INSERT INTO FreeTime(1, 18:00, 19:00, 10/22/2020);

--UserFriendList(userID, friendID)
INSERT INTO UserFriendList(1, 2);

--Interest(ID, interestName)
INSERT INTO Interest VALUES (1, "Basketball");
INSERT INTO Interest VALUES (2, "Ultimate Frisbee");
INSERT INTO Interest VALUES (3, "Gaming");

--UserInterests(userID, interestID)
INSERT INTO UserInterests VALUES (1, 1);

--Group(ID, groupName, adminID)
INSERT INTO Group VALUES (1, "5th VanderLagerstein", 2);

--GroupMembers(groupID, memberID)
INSERT INTO GroupMembers VALUES (1, 1);
INSERT INTO GroupMembers VALUES (1, 2);

--FTEvent(ID, eventName, time, date)
INSERT INTO FTEvent VALUES(1, "Smash Tournament", 18:00, 10/22/2020);

--GroupEvent(groupID, eventIT)
INSERT INTO GroupEvent(1, 1);