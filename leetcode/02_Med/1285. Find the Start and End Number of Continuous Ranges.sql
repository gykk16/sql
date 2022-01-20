-- Table: Logs
--
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | log_id        | int     |
-- +---------------+---------+
-- log_id is the primary key for this table.
-- Each row of this table contains the ID in a log Table.
--
--
-- Write an SQL query to find the start and end number of continuous ranges in the table Logs.
--
-- Return the result table ordered by start_id.
--
-- The query result format is in the following example.
--
--
--
-- Example 1:
--
-- Input:
-- Logs table:
-- +------------+
-- | log_id     |
-- +------------+
-- | 1          |
-- | 2          |
-- | 3          |
-- | 7          |
-- | 8          |
-- | 10         |
-- +------------+
-- Output:
-- +------------+--------------+
-- | start_id   | end_id       |
-- +------------+--------------+
-- | 1          | 3            |
-- | 7          | 8            |
-- | 10         | 10           |
-- +------------+--------------+
-- Explanation:
-- The result table should contain all ranges in table Logs.
-- From 1 to 3 is contained in the table.
-- From 4 to 6 is missing in the table
-- From 7 to 8 is contained in the table.
-- Number 9 is missing from the table.
-- Number 10 is contained in the table.


SELECT ROWNUM
     , L.LOG_ID
     , L.LOG_ID - ROWNUM AS ID
  FROM LOGS L
;

-- +------+------+--+
-- |ROWNUM|LOG_ID|ID|
-- +------+------+--+
-- |1     |1     |0 |
-- |2     |2     |0 |
-- |3     |3     |0 |
-- |4     |7     |3 |
-- |5     |8     |3 |
-- |6     |10    |4 |
-- +------+------+--+


SELECT DISTINCT MIN(TAB_A.LOG_ID) OVER (PARTITION BY TAB_A.ID) AS START_ID
     , MAX(TAB_A.LOG_ID) OVER (PARTITION BY TAB_A.ID) AS END_ID
  FROM (SELECT ROWNUM
             , L.LOG_ID
             , L.LOG_ID - ROWNUM AS ID
          FROM LOGS L) TAB_A
 ORDER BY START_ID
;


SELECT MIN(TAB_A.LOG_ID) AS START_ID
     , MAX(TAB_A.LOG_ID) AS END_ID
  FROM (SELECT ROWNUM
             , L.LOG_ID
             , L.LOG_ID - ROWNUM AS ID
          FROM LOGS L) TAB_A
 GROUP BY TAB_A.ID
 ORDER BY START_ID
;
