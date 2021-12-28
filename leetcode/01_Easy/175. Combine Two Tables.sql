-- 175. Combine Two Tables




SELECT FIRSTNAME
      ,LASTNAME
      ,CITY
      ,STATE
  FROM PERSON P
  LEFT JOIN ADDRESS A
    ON P.PERSONID = A.PERSONID
;


SELECT FIRSTNAME
      ,LASTNAME
      ,(SELECT A.CITY FROM ADDRESS A WHERE A.PERSONID = P.PERSONID) AS CITY
      ,(SELECT A.STATE FROM ADDRESS A WHERE A.PERSONID = P.PERSONID) AS STATE
  FROM PERSON P
;