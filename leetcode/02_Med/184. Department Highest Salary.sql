-- 184. Department Highest Salary

-- Table: Employee

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | id           | int     |
-- | name         | varchar |
-- | salary       | int     |
-- | departmentId | int     |
-- +--------------+---------+
-- id is the primary key column for this table.
-- departmentId is a foreign key of the ID from the Department table.
-- Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.


-- Table: Department

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- +-------------+---------+
-- id is the primary key column for this table.
-- Each row of this table indicates the ID of a department and its name.


-- Write an SQL query to find employees who have the highest salary in each of the departments.

-- Return the result table in any order.


SELECT D.NAME   AS DEPARTMENT
      ,E.NAME   AS EMPLOYEE
      ,E.SALARY AS SALARY
  FROM EMPLOYEE E
      ,DEPARTMENT D
      ,(SELECT DEPARTMENTID
              ,MAX(SALARY) AS SALARY
          FROM EMPLOYEE
         GROUP BY DEPARTMENTID) TAB_A
 WHERE E.DEPARTMENTID = D.ID
       AND E.DEPARTMENTID = TAB_A.DEPARTMENTID
       AND E.SALARY = TAB_A.SALARY;
