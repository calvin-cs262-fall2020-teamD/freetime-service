--User(ID, username, password, freetimeID, groupAdminID)
INSERT INTO User VALUES (1, 'Bill', 'Baconstripsandbaconstrips',1, NULL);
INSERT INTO User VALUES (2, 'Dill', 'Lionsandtigersandbears', 2, 1);
INSERT INTO User VALUES (3, 'Jill', 'abc123', NULL, NULL);
INSERT INTO User VALUES (4, 'Gill', 'turducken5', NULL, NULL);

INSERT INTO User VALUES (5, 'Owen', 'fancyPants', NULL, 2);
INSERT INTO User VALUES (6, 'Josh', 'bearDown5!!', NULL, NULL);
INSERT INTO User VALUES (7, 'Donald', 'quacker5?', NULL, NULL);
INSERT INTO User VALUES (8, 'Michelange', 'fanta5ia', NULL, NULL);

--FreeTime(userID, startTime, endTime, date)
--Bill's free time
INSERT INTO FreeTime(1, 18:00, 19:00, 10/22/2020);
--Dill's free time - bigger than Bill's
INSERT INTO FreeTime(2, 17:00, 19:00, 10/22/2020);
INSERT INTO FreeTime(2, 04:30, 06:00, 10/22/2020);
--Jill's free time - same length as Dill's but offset by an hour
INSERT INTO FreeTime(3, 18:00, 20:00, 10/22/2020);
--Gill's free time - offset by half hour
INSERT INTO FreeTime(4, 17:30, 20:30, 10/22/2020);

--FreeTime(userID, startTime, endTime, date)
--Bill's free time
INSERT INTO FreeTime(5, 18:00, 19:00, 10/22/2020);
--Dill's free time - bigger than Bill's
INSERT INTO FreeTime(6, 17:00, 19:00, 10/22/2020);
INSERT INTO FreeTime(6, 04:30, 06:00, 10/22/2020);
--Jill's free time - same length as Dill's but offset by an hour
INSERT INTO FreeTime(7, 18:00, 20:00, 10/22/2020);
--Gill's free time - offset by half hour
INSERT INTO FreeTime(8, 17:30, 20:30, 10/22/2020);


--UserFriendList(userID, friendID)
--Everyone in group 1 is friends with each other
INSERT INTO UserFriendList(1, 2);
INSERT INTO UserFriendList(1, 3);
INSERT INTO UserFriendList(1, 4);
INSERT INTO UserFriendList(2, 1);
INSERT INTO UserFriendList(2, 3);
INSERT INTO UserFriendList(2, 4);
INSERT INTO UserFriendList(3, 2);
INSERT INTO UserFriendList(3, 1);
INSERT INTO UserFriendList(3, 4);
INSERT INTO UserFriendList(4, 2);
INSERT INTO UserFriendList(4, 3);
INSERT INTO UserFriendList(4, 1);
--Everyone in group 2 is friends with each other
INSERT INTO UserFriendList(5, 6);
INSERT INTO UserFriendList(5, 7);
INSERT INTO UserFriendList(5, 8);
INSERT INTO UserFriendList(6, 5);
INSERT INTO UserFriendList(6, 7);
INSERT INTO UserFriendList(6, 8);
INSERT INTO UserFriendList(7, 6);
INSERT INTO UserFriendList(7, 8);
INSERT INTO UserFriendList(7, 5);
INSERT INTO UserFriendList(8, 7);
INSERT INTO UserFriendList(8, 6);
INSERT INTO UserFriendList(8, 5);

--Interest(ID, interestName)
INSERT INTO Interest VALUES (1, "Basketball");
INSERT INTO Interest VALUES (2, "Ultimate Frisbee");
INSERT INTO Interest VALUES (3, "Gaming");
INSERT INTO Interest VALUES (4, "Movies");
INSERT INTO Interest VALUES (5, "Concerts");
INSERT INTO Interest VALUES (6, "Volleyball");
INSERT INTO Interest VALUES (7, "Backpacking");

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
INSERT INTO Group VALUES (1, "5th VanderLagerstein", 2);
INSERT INTO Group VALUES (2, "3rd Smith", 5);

--GroupMembers(groupID, memberID)
INSERT INTO GroupMembers VALUES (1, 1);
INSERT INTO GroupMembers VALUES (1, 2);
INSERT INTO GroupMembers VALUES (1, 3);
INSERT INTO GroupMembers VALUES (1, 4);

INSERT INTO GroupMembers VALUES (2, 5);
INSERT INTO GroupMembers VALUES (2, 6);
INSERT INTO GroupMembers VALUES (2, 7);
INSERT INTO GroupMembers VALUES (2, 8);

--FTEvent(ID, groupID, eventName, startTime, endTime, date)
INSERT INTO GroupEvent VALUES(1, 1, "Smash Tournament", 18:00, 20:00, 10/22/2020);