-- Table: Players
--
-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | player_id      | int     |
-- | player_name    | varchar |
-- +----------------+---------+
-- player_id is the primary key for this table.
-- Each row in this table contains the name and the ID of a tennis player.
--
--
-- Table: Championships
--
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | year          | int     |
-- | Wimbledon     | int     |
-- | Fr_open       | int     |
-- | US_open       | int     |
-- | Au_open       | int     |
-- +---------------+---------+
-- year is the primary key for this table.
-- Each row of this table contains the IDs of the players who won one each tennis tournament of the grand slam.
--
--
-- Write an SQL query to report the number of grand slam tournaments won by each player. Do not include the players who did not win any tournament.
--
-- Return the result table in any order.
--
-- The query result format is in the following example.
--
--
--
-- Example 1:
--
-- Input:
-- Players table:
-- +-----------+-------------+
-- | player_id | player_name |
-- +-----------+-------------+
-- | 1         | Nadal       |
-- | 2         | Federer     |
-- | 3         | Novak       |
-- +-----------+-------------+
-- Championships table:
-- +------+-----------+---------+---------+---------+
-- | year | Wimbledon | Fr_open | US_open | Au_open |
-- +------+-----------+---------+---------+---------+
-- | 2018 | 1         | 1       | 1       | 1       |
-- | 2019 | 1         | 1       | 2       | 2       |
-- | 2020 | 2         | 1       | 2       | 2       |
-- +------+-----------+---------+---------+---------+
-- Output:
-- +-----------+-------------+-------------------+
-- | player_id | player_name | grand_slams_count |
-- +-----------+-------------+-------------------+
-- | 2         | Federer     | 5                 |
-- | 1         | Nadal       | 7                 |
-- +-----------+-------------+-------------------+
-- Explanation:
-- Player 1 (Nadal) won 7 titles: Wimbledon (2018, 2019), Fr_open (2018, 2019, 2020), US_open (2018), and Au_open (2018).
-- Player 2 (Federer) won 5 titles: Wimbledon (2020), US_open (2019, 2020), and Au_open (2019, 2020).
-- Player 3 (Novak) did not win anything, we did not include them in the result table.


SELECT TAB_A.PLAYER_ID
     , P.PLAYER_NAME
     , SUM(TAB_A.CNT) AS GRAND_SLAMS_COUNT
  FROM (
      SELECT WIMBLEDON AS PLAYER_ID, COUNT(1) AS CNT
        FROM CHAMPIONSHIPS
       GROUP BY WIMBLEDON
       UNION ALL
      SELECT FR_OPEN AS PLAYER_ID, COUNT(1) AS CNT
        FROM CHAMPIONSHIPS
       GROUP BY FR_OPEN
       UNION ALL
      SELECT US_OPEN AS PLAYER_ID, COUNT(1) AS CNT
        FROM CHAMPIONSHIPS
       GROUP BY US_OPEN
       UNION ALL
      SELECT AU_OPEN AS PLAYER_ID, COUNT(1) AS CNT
        FROM CHAMPIONSHIPS
       GROUP BY AU_OPEN) TAB_A
     , PLAYERS P
 WHERE TAB_A.PLAYER_ID = P.PLAYER_ID
 GROUP BY P.PLAYER_NAME, TAB_A.PLAYER_ID;

-- +---------+---+
-- |PLAYER_ID|CNT|
-- +---------+---+
-- |1        |2  |
-- |2        |1  |
-- |1        |3  |
-- |1        |1  |
-- |2        |2  |
-- |1        |1  |
-- |2        |2  |
-- +---------+---+

SELECT WIMBLEDON AS PLAYER_ID
  FROM CHAMPIONSHIPS
 UNION ALL
SELECT FR_OPEN AS PLAYER_ID
  FROM CHAMPIONSHIPS
 UNION ALL
SELECT US_OPEN AS PLAYER_ID
  FROM CHAMPIONSHIPS
 UNION ALL
SELECT AU_OPEN AS PLAYER_ID
  FROM CHAMPIONSHIPS
;

-- +---------+
-- |PLAYER_ID|
-- +---------+
-- |1        |
-- |1        |
-- |2        |
-- |1        |
-- |1        |
-- |1        |
-- |1        |
-- |2        |
-- |2        |
-- |1        |
-- |2        |
-- |2        |
-- +---------+

SELECT TAB_A.PLAYER_ID
     , P.PLAYER_NAME
     , COUNT(TAB_A.PLAYER_ID) AS GRAND_SLAMS_COUNT
  FROM (SELECT WIMBLEDON AS PLAYER_ID
          FROM CHAMPIONSHIPS
         UNION ALL
        SELECT FR_OPEN AS PLAYER_ID
          FROM CHAMPIONSHIPS
         UNION ALL
        SELECT US_OPEN AS PLAYER_ID
          FROM CHAMPIONSHIPS
         UNION ALL
        SELECT AU_OPEN AS PLAYER_ID
          FROM CHAMPIONSHIPS) TAB_A
     , PLAYERS P
 WHERE TAB_A.PLAYER_ID = P.PLAYER_ID
 GROUP BY P.PLAYER_NAME, TAB_A.PLAYER_ID;