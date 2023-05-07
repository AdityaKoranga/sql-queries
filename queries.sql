create database EMP_DEPT;
use EMP-DEPT;

create TABLE DEPARTMENT(
  Dno Integer primary key,
  Dname Varchar(50) ,
  Location Varchar(50) default 'New Delhi'
);

create table EMPLOYEE (
  Eno char(3) primary key,
  Ename varchar(50) not null,
  Job_type Varchar(50) not Null,
  SupervisonENO Char(3),
  Hire_date DATE not null,
  Dno Integer,
  Commission Decimal(10,2),
  Salary Decimal(7,2) not null,
  foreign key (SupervisonENO) references EMPLOYEE(Eno),
  foreign key (Dno) references DEPARTMENT(Dno)
);


insert into EMPLOYEE(Eno,Ename,Job_type,Hire_date, Commission, Salary) values
("1",'adi','it',"2021-01-01",002.90,123.367);

-- select * from EMPLOYEE;

insert into EMPLOYEE(Eno,Ename,Job_type,Hire_date, SupervisonENO,Commission, Salary) values
("2",'shankar','itc',"2021-01-01",'1',002.90,123.367);
-- select * from EMPLOYEE;

INSERT INTO DEPARTMENT (Dno, Dname, Location)
VALUES (1, 'Human Resources', 'New Delhi');

insert into EMPLOYEE(Eno,Ename,Job_type,Hire_date, SupervisonENO,Dno,Commission, Salary) values
("3",'vivek','itu',"2021-06-01",'1',1, 002.90,123.367);

select * from DEPARTMENT;
select * from EMPLOYEE;

-- quereies start
-- 1.
SELECT Eno, Ename, Job_type, Hire_date
FROM EMPLOYEE;

-- 2.
select distinct Job_type from EMPLOYEE;

-- 3.
select concat(Ename,',', Job_type) as enamejobs from EMPLOYEE;

-- 4.
SELECT CONCAT(Eno, ', ', Ename, ', ', Job_type, ', ', IFNULL(SupervisonENO, ''), ', ', Hire_date, ', ', IFNULL(Dno, ''), ', ', IFNULL(Commission, ''), ', ', Salary) AS THE_OUTPUT
FROM EMPLOYEE;

-- 5.
SELECT Ename, Salary
FROM EMPLOYEE
WHERE Salary > 2850;

-- 6.
SELECT EMPLOYEE.Ename, EMPLOYEE.Dno
FROM EMPLOYEE
WHERE EMPLOYEE.Eno = '79';

-- 7.
SELECT Ename, Salary
FROM EMPLOYEE
WHERE Salary NOT BETWEEN 1500 AND 2850;

-- 8.
SELECT EMPLOYEE.Ename, EMPLOYEE.Dno
FROM EMPLOYEE
WHERE EMPLOYEE.Dno IN (10, 30)
ORDER BY EMPLOYEE.Ename ASC;

-- 9
SELECT Ename, Hire_date
FROM EMPLOYEE
WHERE YEAR(Hire_date) = 1981;

-- 10
SELECT Ename, Job_type
FROM EMPLOYEE
WHERE SupervisonENO IS NULL;

-- 11
SELECT Ename, Salary, Commission
FROM EMPLOYEE
WHERE Commission IS NOT NULL;

-- 12
SELECT *
FROM EMPLOYEE
WHERE Commission IS NOT NULL
ORDER BY Salary DESC, Commission DESC;

-- 13
SELECT Ename
FROM EMPLOYEE
WHERE SUBSTR(Ename, 3, 1) = 'A';

-- 14
SELECT Ename
FROM EMPLOYEE
WHERE ((Ename LIKE '%R%R%') OR (Ename LIKE '%A%A%'))
AND ((Dno = 30) OR (SupervisonENO = '7788'));

-- 15
SELECT Ename, Salary, Commission
FROM EMPLOYEE
WHERE Commission > (Salary * 1.05);

-- 16
-- SELECT CONCAT(DATE_FORMAT(NOW(), '%W, %M %e, %Y'), '') AS Current_Date;
-- SELECT CONCAT(DATE_FORMAT(NOW(), '%W, %M %e, %Y'), '') AS Current_Date;
SELECT date_format(CURDATE(),'%W %D %M %Y %T');


-- 17
SELECT Ename, Hire_date, DATE_FORMAT(DATE_ADD(Hire_date, INTERVAL 6 MONTH), '%W, %M %e, %Y') AS Review_Date
FROM EMPLOYEE
WHERE WEEKDAY(DATE_ADD(Hire_date, INTERVAL 6 MONTH)) = 1;

-- 18
SELECT Ename, TIMESTAMPDIFF(MONTH, Hire_date, CURDATE()) AS Months_Employed
FROM EMPLOYEE
WHERE Dno = (
    SELECT Dno
    FROM DEPARTMENT
    WHERE Dname = 'Purchase'
);

-- 19
SELECT Ename, Salary, Salary * 3 AS 'Dream Salary'
FROM EMPLOYEE;

-- 20
SELECT CONCAT(UCASE(LEFT(Ename, 1)), LCASE(SUBSTRING(Ename, 2))) AS 'Name',
       LENGTH(Ename) AS 'Name Length'
FROM EMPLOYEE
WHERE Ename LIKE 'J%' OR Ename LIKE 'A%' OR Ename LIKE 'M%';

-- 21
SELECT Ename, Hire_date, DATE_FORMAT(Hire_date, '%W') AS 'Start Day'
FROM EMPLOYEE;

-- 22
SELECT E.Ename, D.Dname, D.Dno
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dno;

-- 23
SELECT DISTINCT Job_type
FROM EMPLOYEE
WHERE Dno = 30;

-- 24
SELECT E.Ename, D.Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dno
WHERE E.Ename LIKE '%A%';

-- 25
SELECT E.Ename, E.Job_type, E.Dno, D.Dname
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dno
WHERE D.Location = 'Dallas';

-- 26
SELECT E.Ename, E.Eno, S.Ename AS 'Supervisor Name', S.Eno AS 'Supervisor No'
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE S ON E.SupervisonENO = S.Eno
UNION
SELECT E1.Ename, E1.Eno, NULL AS 'Supervisor Name', NULL AS 'Supervisor No'
FROM EMPLOYEE E1
WHERE E1.SupervisonENO IS NULL;

-- 27
SELECT E.Ename, E.Dno, E.Salary
FROM EMPLOYEE E
WHERE E.Dno = (
    SELECT MAX(E1.Dno)
    FROM EMPLOYEE E1
    WHERE E1.Salary IN (
        SELECT E2.Salary
        FROM EMPLOYEE E2
        WHERE E2.Commission IS NOT NULL
    )
)
AND E.Salary IN (
    SELECT E3.Salary
    FROM EMPLOYEE E3
    WHERE E3.Commission IS NOT NULL
);

-- 28
SELECT Ename, CONCAT(REPEAT('*', FLOOR(Salary / 100))) AS Salaries
FROM EMPLOYEE;

-- 29
SELECT MAX(Salary) AS Highest_Salary,
       MIN(Salary) AS Lowest_Salary,
       SUM(Salary) AS Total_Salary,
       AVG(Salary) AS Average_Salary
FROM EMPLOYEE;

-- 30
SELECT Job_type, COUNT(*) AS Num_Employees
FROM EMPLOYEE
GROUP BY Job_type;

-- 31
SELECT COUNT(DISTINCT SupervisonENO) AS Total_Supervisors
FROM EMPLOYEE;

-- 32
SELECT D.Dname AS Department_Name, D.Location AS Location_Name,
       COUNT(*) AS Num_Employees, AVG(E.Salary) AS Average_Salary
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dno
GROUP BY E.Dno;

-- 33
SELECT E.Ename AS Employee_Name, E.Hire_date AS Hire_Date
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dno
WHERE D.Dname = (SELECT Dname FROM DEPARTMENT WHERE Dno = (SELECT Dno FROM EMPLOYEE WHERE Ename = 'Blake'));


-- 34
SELECT E.Eno AS Employee_No, E.Ename AS Employee_Name
FROM EMPLOYEE E
WHERE E.Salary > (SELECT AVG(Salary) FROM EMPLOYEE);

-- 35
SELECT E.Eno AS Employee_No, E.Ename AS Employee_Name
FROM EMPLOYEE E
WHERE E.Dno IN (
  SELECT DISTINCT D.Dno
  FROM DEPARTMENT D
  JOIN EMPLOYEE E2 ON D.Dno = E2.Dno
  WHERE E2.Ename LIKE '%T%'
);

-- 36
SELECT E.Ename AS Employee_Name, E.Salary
FROM EMPLOYEE E
WHERE E.SupervisonENO = (
  SELECT Eno
  FROM EMPLOYEE
  WHERE Ename = 'King'
);

-- 37
SELECT E.Dno AS Department_No, D.Dname AS Department_Name, E.Job_type
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dno
WHERE D.Dname = 'Sales';

-- 38
SELECT E.Ename AS Employee_Name, D.Dname AS Department_Name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.Dno = D.Dno
WHERE DATEDIFF(CURDATE(), E.Hire_date)/365 > 20;

-- 39
SELECT Location, COUNT(DISTINCT Dno) AS Total_Departments
FROM DEPARTMENT
GROUP BY Location;

-- 40
SELECT Dname AS Department_Name
FROM DEPARTMENT
WHERE Dno IN (
    SELECT Dno
    FROM EMPLOYEE
    GROUP BY Dno
    HAVING COUNT(*) >= 20
);

-- 41
SELECT e1.Ename AS Employee_Name, e2.Ename AS Supervisor_Name
FROM EMPLOYEE e1
JOIN EMPLOYEE e2 ON e1.SupervisonENO = e2.Eno
WHERE e1.Job_type != 'Supervisor' AND e2.Job_type = 'Supervisor'
GROUP BY e1.Ename, e2.Ename
HAVING COUNT(*) > 5;

-- 42
SELECT Job_type, COUNT(*) AS Total_Employees
FROM EMPLOYEE
GROUP BY Job_type
HAVING COUNT(*) = (
  SELECT MAX(Employee_Count) 
  FROM (
    SELECT COUNT(*) AS Employee_Count
    FROM EMPLOYEE
    GROUP BY Job_type
  ) AS counts
)
OR COUNT(*) = (
  SELECT MIN(Employee_Count) 
  FROM (
    SELECT COUNT(*) AS Employee_Count
    FROM EMPLOYEE
    GROUP BY Job_type
  ) AS counts
);

