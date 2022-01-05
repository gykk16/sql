-- 177. Nth Highest Salary

-- Table: Employee

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | salary      | int  |
-- +-------------+------+
-- id is the primary key column for this table.
-- Each row of this table contains information about the salary of an employee.


-- Write an SQL query to report the nth highest salary from the Employee table. If there is no nth highest salary, the query should report null.

-- The query result format is in the following example.



-- Example 1:

-- Input:
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- n = 2
-- Output:
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- Example 2:

-- Input:
-- Employee table:
-- +----+--------+
-- | id | salary |
-- +----+--------+
-- | 1  | 100    |
-- +----+--------+
-- n = 2
-- Output:
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | null                   |
-- +------------------------+


CREATE FUNCTION getNthHighestSalary(N IN NUMBER)
RETURN NUMBER IS

    V_CNT    NUMBER;
    V_RESULT NUMBER;

BEGIN
    SELECT COUNT(1) INTO V_CNT FROM EMPLOYEE;

    IF N > V_CNT THEN

       V_RESULT := NULL;

    ELSE

      SELECT MAX(TAB_A.SALARY)
        INTO V_RESULT
        FROM (SELECT E.SALARY
                     ,DENSE_RANK() OVER(ORDER BY E.SALARY DESC) AS RNK
                FROM EMPLOYEE E) TAB_A
       WHERE TAB_A.RNK = N;

    END IF;

    RETURN V_RESULT;

END;



CREATE FUNCTION getNthHighestSalary(N IN NUMBER)
RETURN NUMBER IS

    V_CNT    NUMBER;
    V_RESULT NUMBER;

BEGIN

    SELECT COUNT(1) INTO V_CNT FROM EMPLOYEE;

    IF N > V_CNT THEN

        V_RESULT := NULL;

    ELSE

        SELECT TAB_A.SALARY
          INTO V_RESULT
          FROM (SELECT E.SALARY
                      ,DENSE_RANK() OVER(ORDER BY E.SALARY DESC) AS RNK
                  FROM EMPLOYEE E
                 GROUP BY E.SALARY) TAB_A
         WHERE TAB_A.RNK = N;

    END IF;

    RETURN V_RESULT;

END;



CREATE FUNCTION getNthHighestSalary(N IN NUMBER)
RETURN NUMBER IS

    V_RESULT NUMBER;

BEGIN

    SELECT MAX(TAB_A.SALARY)
      INTO V_RESULT
      FROM (SELECT E.SALARY
                  ,DENSE_RANK() OVER(ORDER BY E.SALARY DESC) AS RNK
              FROM EMPLOYEE E) TAB_A
     WHERE TAB_A.RNK = N;

    RETURN V_RESULT;


END;