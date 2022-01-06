-- 180. Consecutive Numbers

-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- id is the primary key for this table.


-- Write an SQL query to find all numbers that appear at least three times consecutively.

-- Return the result table in any order.


SELECT DISTINCT(L1.NUM) AS CONSECUTIVENUMS
  FROM LOGS L1
      ,LOGS L2
      ,LOGS L3
 WHERE L1.ID = L2.ID(+) + 1
       AND L1.ID = L3.ID(+) + 2
       AND L1.NUM = L2.NUM
       AND L1.NUM = L3.NUM;



SELECT DISTINCT(L1.NUM) AS CONSECUTIVENUMS
  FROM LOGS L1
      ,LOGS L2
      ,LOGS L3
 WHERE L1.ID = L2.ID + 1
       AND L1.ID = L3.ID + 2
       AND L1.NUM = L2.NUM
       AND L1.NUM = L3.NUM;



ID	NUM	ID	NUM	ID	NUM
1	1	 - 	 - 	 - 	 -
2	1	1	1	 - 	 -
3	1	2	1	1	1
4	2	3	1	2	1
5	1	4	2	3	1
6	2	5	1	4	2
7	2	6	2	5	1
