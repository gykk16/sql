-- Table: RequestAccepted
--
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) is the primary key for this table.
-- This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
--
--
-- Write an SQL query to find the people who have the most friends and the most friends number.
--
-- The test cases are generated so that only one person has the most friends.
--
-- The query result format is in the following example.
--
--
--
-- Example 1:
--
-- Input:
-- RequestAccepted table:
-- +--------------+-------------+-------------+
-- | requester_id | accepter_id | accept_date |
-- +--------------+-------------+-------------+
-- | 1            | 2           | 2016/06/03  |
-- | 1            | 3           | 2016/06/08  |
-- | 2            | 3           | 2016/06/08  |
-- | 3            | 4           | 2016/06/09  |
-- +--------------+-------------+-------------+
-- Output:
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 3  | 3   |
-- +----+-----+
-- Explanation:
-- The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.


SELECT *
  FROM REQUESTACCEPTED;

SELECT REQUESTER_ID, COUNT(1)
  FROM REQUESTACCEPTED
 GROUP BY REQUESTER_ID
 UNION ALL
SELECT ACCEPTER_ID, COUNT(1)
  FROM REQUESTACCEPTED
 GROUP BY ACCEPTER_ID;

SELECT MAX(SUM(CNT)) AS NUM
  FROM (SELECT REQUESTER_ID, COUNT(1) AS CNT
          FROM REQUESTACCEPTED
         GROUP BY REQUESTER_ID
         UNION ALL
        SELECT ACCEPTER_ID, COUNT(1) AS CNT
          FROM REQUESTACCEPTED
         GROUP BY ACCEPTER_ID) TAB_A
 GROUP BY REQUESTER_ID;

SELECT *
  FROM (SELECT REQUESTER_ID AS ID
             , SUM(CNT)     AS NUM
          FROM (SELECT REQUESTER_ID, COUNT(1) AS CNT
                  FROM REQUESTACCEPTED
                 GROUP BY REQUESTER_ID
                 UNION ALL
                SELECT ACCEPTER_ID, COUNT(1) AS CNT
                  FROM REQUESTACCEPTED
                 GROUP BY ACCEPTER_ID) TAB_A
         GROUP BY REQUESTER_ID) TAB_B
 WHERE NUM >= (SELECT MAX(SUM(CNT)) AS NUM
                 FROM (SELECT REQUESTER_ID, COUNT(1) AS CNT
                         FROM REQUESTACCEPTED
                        GROUP BY REQUESTER_ID
                        UNION ALL
                       SELECT ACCEPTER_ID, COUNT(1) AS CNT
                         FROM REQUESTACCEPTED
                        GROUP BY ACCEPTER_ID) TAB_A
                GROUP BY REQUESTER_ID);


SELECT REQUESTER_ID AS IDX
  FROM REQUESTACCEPTED
 UNION ALL
SELECT ACCEPTER_ID AS IDX
  FROM REQUESTACCEPTED;

SELECT ID, NUM
  FROM (SELECT IDX                                        AS ID
             , COUNT(1)                                   AS NUM
             , DENSE_RANK() OVER (ORDER BY COUNT(1) DESC) AS RNK
          FROM (SELECT REQUESTER_ID AS IDX
                  FROM REQUESTACCEPTED
                 UNION ALL
                SELECT ACCEPTER_ID AS IDX
                  FROM REQUESTACCEPTED) TAB_A
         GROUP BY IDX) TAB_B
 WHERE TAB_B.RNK = 1
;

