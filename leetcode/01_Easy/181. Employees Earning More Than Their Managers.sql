-- 181. Employees Earning More Than Their Managers




SELECT E1.NAME AS EMPLOYEE
  FROM EMPLOYEE E1
      ,EMPLOYEE E2
 WHERE E1.MANAGERID = E2.ID
       AND E1.SALARY > E2.SALARY;
       