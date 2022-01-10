-- 601. Human Traffic of Stadium

-- Table: Stadium

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | visit_date    | date    |
-- | people        | int     |
-- +---------------+---------+
-- visit_date is the primary key for this table.
-- Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
-- No two rows will have the same visit_date, and as the id increases, the dates increase as well.
 

-- Write an SQL query to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

-- Return the result table ordered by visit_date in ascending order.

-- The query result format is in the following example.

 

-- Example 1:

-- Input: 
-- Stadium table:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Output: 
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-09 | 188       |
-- +------+------------+-----------+
-- Explanation: 
-- The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has >= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
-- The rows with ids 2 and 3 are not included because we need at least three consecutive ids.



SELECT S1.ID AS "ID"
       ,TO_CHAR(S1.VISIT_DATE, 'YYYY-MM-DD') AS "VISIT_DATE"
       ,S1.PEOPLE AS "PEOPLE"
  FROM STADIUM S1
      ,STADIUM S2
      ,STADIUM S3
 WHERE (
       (S1.ID = S2.ID + 1 AND S1.ID = S3.ID + 2) 
       OR (S2.ID = S3.ID + 1 AND S2.ID = S1.ID + 2) 
       OR (S3.ID = S1.ID + 1 AND S3.ID = S2.ID + 2)
       )
       AND S1.PEOPLE >= 100
       AND S2.PEOPLE >= 100
       AND S3.PEOPLE >= 100
 GROUP BY S1.ID
         ,TO_CHAR(S1.VISIT_DATE, 'YYYY-MM-DD')
         ,S1.PEOPLE
 ORDER BY S1.ID;
