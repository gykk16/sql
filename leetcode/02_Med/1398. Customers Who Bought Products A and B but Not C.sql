-- Table: Customers

-- +---------------------+---------+
-- | Column Name         | Type    |
-- +---------------------+---------+
-- | customer_id         | int     |
-- | customer_name       | varchar |
-- +---------------------+---------+
-- customer_id is the primary key for this table.
-- customer_name is the name of the customer.


-- Table: Orders

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | order_id      | int     |
-- | customer_id   | int     |
-- | product_name  | varchar |
-- +---------------+---------+
-- order_id is the primary key for this table.
-- customer_id is the id of the customer who bought the product "product_name".


-- Write an SQL query to report the customer_id and customer_name of customers who bought products "A", "B" but did not buy the product "C" since we want to recommend them to purchase this product.

-- Return the result table ordered by customer_id.

-- The query result format is in the following example.



-- Example 1:

-- Input:
-- Customers table:
-- +-------------+---------------+
-- | customer_id | customer_name |
-- +-------------+---------------+
-- | 1           | Daniel        |
-- | 2           | Diana         |
-- | 3           | Elizabeth     |
-- | 4           | Jhon          |
-- +-------------+---------------+
-- Orders table:
-- +------------+--------------+---------------+
-- | order_id   | customer_id  | product_name  |
-- +------------+--------------+---------------+
-- | 10         |     1        |     A         |
-- | 20         |     1        |     B         |
-- | 30         |     1        |     D         |
-- | 40         |     1        |     C         |
-- | 50         |     2        |     A         |
-- | 60         |     3        |     A         |
-- | 70         |     3        |     B         |
-- | 80         |     3        |     D         |
-- | 90         |     4        |     C         |
-- +------------+--------------+---------------+
-- Output:
-- +-------------+---------------+
-- | customer_id | customer_name |
-- +-------------+---------------+
-- | 3           | Elizabeth     |
-- +-------------+---------------+
-- Explanation: Only the customer_id with id 3 bought the product A and B but not the product C.



SELECT * FROM CUSTOMERS C;
SELECT * FROM ORDERS O;

SELECT * FROM ORDERS O WHERE O.PRODUCT_NAME IN ('A', 'B');

SELECT CUSTOMER_ID
  FROM ORDERS
 WHERE PRODUCT_NAME = 'B'
       AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A');

SELECT CUSTOMER_ID FROM ORDERS O WHERE PRODUCT_NAME = 'C';


SELECT C.CUSTOMER_ID
      ,C.CUSTOMER_NAME
  FROM CUSTOMERS C
      ,(SELECT CUSTOMER_ID
          FROM ORDERS
         WHERE PRODUCT_NAME = 'B'
               AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A')) TAB_A
 WHERE C.CUSTOMER_ID = TAB_A.CUSTOMER_ID
       AND TAB_A.CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM ORDERS O WHERE PRODUCT_NAME = 'C');


SELECT DISTINCT C.CUSTOMER_ID
               ,C.CUSTOMER_NAME
  FROM CUSTOMERS C
      ,ORDERS    O
 WHERE C.CUSTOMER_ID = O.CUSTOMER_ID
       AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS O WHERE PRODUCT_NAME = 'A')
       AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS O WHERE PRODUCT_NAME = 'B')
       AND O.CUSTOMER_ID NOT IN (SELECT CUSTOMER_ID FROM ORDERS O WHERE PRODUCT_NAME = 'C')
 ORDER BY CUSTOMER_ID;