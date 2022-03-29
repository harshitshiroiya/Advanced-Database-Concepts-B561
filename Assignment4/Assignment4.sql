-- Script for Assignment 4

-- Creating database with full name

CREATE DATABASE harshitshiroiya;

-- Connecting to database 
\c harshitshiroiya
\o Desktop/'Assignment4.txt';

-- Relation schemas and instances for assignment 4

CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid));

CREATE TABLE Company(cname text,
                     headquarter text,
                     primary key (cname));

CREATE TABLE Skill(skill text,
                   primary key (skill));


CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid),
                      foreign key (pid) references Person (pid),
                      foreign key (cname) references Company(cname));


CREATE TABLE companyLocation(cname text,
                             city text,
                             primary key (cname, city),
                             foreign key (cname) references Company (cname));


CREATE TABLE personSkill(pid integer,
                         skill text,
                         primary key (pid, skill),
                         foreign key (pid) references Person (pid) on delete cascade,
                         foreign key (skill) references Skill (skill) on delete cascade);


CREATE TABLE hasManager(eid integer,
                        mid integer,
                        primary key (eid, mid),
                        foreign key (eid) references Person (pid),
                        foreign key (mid) references Person (pid));

CREATE TABLE Knows(pid1 integer,
                   pid2 integer,
                   primary key(pid1, pid2),
                   foreign key (pid1) references Person (pid),
                   foreign key (pid2) references Person (pid));



INSERT INTO Person VALUES
     (1001,'Jean','Cupertino'),
     (1002,'Vidya', 'Cupertino'),
     (1003,'Anna', 'Seattle'),
     (1004,'Qin', 'Seattle'),
     (1005,'Megan', 'MountainView'),
     (1006,'Ryan', 'Chicago'),
     (1007,'Danielle','LosGatos'),
     (1008,'Emma', 'Bloomington'),
     (1009,'Hasan', 'Bloomington'),
     (1010,'Linda', 'Chicago'),
     (1011,'Nick', 'MountainView'),
     (1012,'Eric', 'Cupertino'),
     (1013,'Lisa', 'Indianapolis'), 
     (1014,'Deepa', 'Bloomington'), 
     (1015,'Chris', 'Denver'),
     (1016,'YinYue', 'Chicago'),
     (1017,'Latha', 'LosGatos'),
     (1018,'Arif', 'Bloomington'),
     (1019,'John', 'NewYork');

INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Amazon', 'Seattle'),
     ('Google', 'MountainView'),
     ('Netflix', 'LosGatos'),
     ('Microsoft', 'Redmond'),
     ('IBM', 'NewYork'),
     ('ACM', 'NewYork'),
     ('Yahoo', 'Sunnyvale');


INSERT INTO worksFor VALUES
     (1001,'Apple', 65000),
     (1002,'Apple', 45000),
     (1003,'Amazon', 55000),
     (1004,'Amazon', 55000),
     (1005,'Google', 60000),
     (1006,'Amazon', 55000),
     (1007,'Netflix', 50000),
     (1008,'Amazon', 50000),
     (1009,'Apple',60000),
     (1010,'Amazon', 55000),
     (1011,'Google', 70000), 
     (1012,'Apple', 50000),
     (1013,'Yahoo', 55000),
     (1014,'Apple', 50000), 
     (1015,'Amazon', 60000),
     (1016,'Amazon', 55000),
     (1017,'Netflix', 60000),
     (1018,'Apple', 50000),
     (1019,'Microsoft', 50000);

INSERT INTO companyLocation VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington'),
   ('Apple', 'Cupertino'),
   ('Amazon', 'Seattle'),
   ('Google', 'MountainView'),
   ('Netflix', 'LosGatos'),
   ('Microsoft', 'Redmond'),
   ('IBM', 'NewYork'),
   ('Yahoo', 'Sunnyvale');

INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');

INSERT INTO personSkill VALUES
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI'),
 (1019,'Networks'),
 (1010,'Databases'),
 (1011,'Databases'),
 (1013,'Databases'),
 (1014,'Databases'),
 (1017,'Databases'),
 (1019,'Databases'),
 (1005,'Databases'),
 (1006,'AI'),
 (1009,'Databases');
 

INSERT INTO hasManager VALUES
 (1004, 1003),
 (1006, 1003),
 (1015, 1003),
 (1016, 1004),
 (1016, 1006),
 (1008, 1015),
 (1010, 1008),
 (1013, 1007),
 (1017, 1013),
 (1002, 1001),
 (1009, 1001),
 (1014, 1012),
 (1011, 1005);


INSERT INTO Knows VALUES
 (1011,1009),
 (1007,1016),
 (1011,1010),
 (1003,1004),
 (1006,1004),
 (1002,1014),
 (1009,1005),
 (1018,1009),
 (1007,1017),
 (1017,1019),
 (1019,1013),
 (1016,1015),
 (1001,1012),
 (1015,1011),
 (1019,1006),
 (1013,1002),
 (1018,1004),
 (1013,1007),
 (1014,1006),
 (1004,1014),
 (1001,1014),
 (1010,1013),
 (1010,1014),
 (1004,1019),
 (1018,1007),
 (1014,1005),
 (1015,1018),
 (1014,1017),
 (1013,1018),
 (1007,1008),
 (1005,1015),
 (1017,1014),
 (1015,1002),
 (1018,1013),
 (1018,1010),
 (1001,1008),
 (1012,1011),
 (1002,1015),
 (1007,1013),
 (1008,1007),
 (1004,1002),
 (1015,1005),
 (1009,1013),
 (1004,1012),
 (1002,1011),
 (1004,1013),
 (1008,1001),
 (1008,1019),
 (1019,1008),
 (1001,1019),
 (1019,1001),
 (1004,1003),
 (1006,1003),
 (1015,1003),
 (1016,1004),
 (1016,1006),
 (1008,1015),
 (1010,1008),
 (1017,1013),
 (1002,1001),
 (1009,1001),
 (1011,1005),
 (1014,1012),
 (1010,1002),
 (1010,1012),
 (1010,1018);

\qecho 'Problem 1'
-- Find each pair $(c,n)$ where $c$ is the cnameof a company that pays
-- an average salary between 50000 and 55000 and where $n$ is the number
-- of employees who work for company $c$.

WITH AverageSalary AS (SELECT w.cname, sum(w.salary) salary, COUNT(*) total
                       FROM  worksFor w
                       GROUP BY (w.cname))

SELECT DISTINCT w.cname, a.total
FROM AverageSalary a, worksFor w
WHERE a.cname = w.cname and (a.salary/a.total) >= 50000 AND (a.salary/a.total) <= 55000; 



\qecho 'Problem 2'
-- Find the pid and name of each person who lacks at least 4 job skils
-- and who knows at least 4 persons.


WITH personskillCount AS (SELECT ps.pid ,COUNT (*) ps1 
                          FROM personSkill ps 
                          GROUP BY(ps.pid) 
                          UNION 
                          SELECT a.pid,a.skill 
                          FROM (SELECT p.pid ,0 skill FROM personSkill ps,Person p  
                          EXCEPT
                          SELECT p.pid AS ppid,0 pskill 
                          FROM personSkill ps,Person p WHERE p.pid=ps.pid)a),
     knowsCount AS (SELECT k.pid1, COUNT(*) k1 
                    FROM Knows k 
                    GROUP BY (k.pid1)),
     skillCount AS (SELECT COUNT(s.skill) s1 
                    FROM skill s)

SELECT p.pid,p.pname 
FROM Person p,personskillCount ps,skillCount s 
WHERE p.pid = ps.pid AND (s.s1 - ps.ps1) >= 4
INTERSECT
SELECT p.pid,p.pname 
FROM Person p, knowsCount k 
WHERE k.pid1 = p.pid AND k.k1 >= 4 
ORDER BY pid;




\qecho 'Problem 3'
-- Find the pid and name of each person who has fewer than 2 of the
-- combined set of job skills of persons who work for Google.



SELECT p.pid, p.pname 
FROM person p 
WHERE (SELECT count(ps.skill) 
       FROM personskill ps 
       WHERE ps.pid = p.pid AND ps.skill  IN (SELECT ps1.skill 
                                              FROM personskill ps1, worksfor w1 
                                              WHERE w1.pid = ps1.pid AND w1.cname = 'Google'))<2;


\qecho 'Problem 4'


WITH AverageSalary AS (SELECT w.cname, (sum(w.salary)/count( * )) salary, COUNT( * ) total
                       FROM  worksFor w
                       GROUP BY (w.cname))


SELECT DISTINCT a.cname
FROM AverageSalary a 
WHERE a.total >= 3 AND a.salary <= All (SELECT b.salary FROM AverageSalary b WHERE b.total >= 3);


\qecho 'Problem 5'
-- Find each pair $(c_1,c_2)$ of different company cnames such that,
-- among all companies, company $c_2$ pays the closest average salary
--- compared to the average salary paid by company $c_1$.

WITH AverageSalary1 AS (SELECT w.cname, AVG(w.salary) salary, COUNT(*) total FROM worksFor w GROUP BY (w.cname)),
AverageSalary2 as (SELECT w.cname, AVG(w.salary) salary, COUNT(*) total FROM worksFor w GROUP BY (w.cname))
SELECT DISTINCT a1.cname,a2.cname
FROM AverageSalary1 a1,AverageSalary1 a2 
WHERE a1.cname <> a2.cname 
and ABS(a1.salary - a2.salary) <= ALL ( Select ABS(a1.salary - a3.salary) 
                                  FROM AverageSalary1 a3 
                                  WHERE a1.cname <> a3.cname)
ORDER BY a1.cname;


\qecho 'Problem 6'
--Without using set predicates, find each pid of a person who does not
--know each person who (1) works for Apple and
-- (2) who makes less than 55000.


SELECT DISTINCT q.pid1 AS pid 
FROM (SELECT p.pid AS pid1, w.pid 
     FROM person p, worksfor w 
     WHERE w.cname='Apple' AND w.salary < 55000 EXCEPT SELECT k.pid1 AS pid1,k.pid2 FROM knows k)q order by pid;


\qecho 'Problem 7'
-- Without using set predicates, find each pairs $(s_1,s_2)$ of skills
-- such that the set of persons with skill $s_1$ is the same as the set
-- of persons with skill $s_2$.
SELECT s.skill, s1.skill 
FROM skill s, skill s1 
EXCEPT 
SELECT q.s1,q.s2 
FROM (SELECT a.pid,ps.skill AS s1,s.skill AS s2 
      FROM (SELECT ps.pid FROM personskill ps GROUP BY ps.pid HAVING(COUNT(ps.pid) >= 2))a, personskill ps, skill s 
      WHERE ps.pid=a.pid 
      EXCEPT 
      SELECT ps.pid,ps.skill,ps1.skill 
      FROM personskill ps,personskill ps1 
      WHERE ps.pid = ps1.pid)q;



\qecho 'Problem 8'
-- Find each pairs $(s_1,s_2,n)$ of different skills $s_1$ an $s_2$ and
-- such that (1) the number of persons with skill $s_1$ is the same as
-- the number of persons with skill $s_2$ and (2) where $n$ is the number
-- of such persons associated with $s_1$ and $s_2$.

SELECT ps.s1,ps1.s2, ps.n 
FROM (SELECT ps.skill AS s1, COUNT (*) AS n FROM personskill ps GROUP BY ps.skill)ps, 
     (SELECT ps.skill AS s2, COUNT (*) AS n FROM personskill ps GROUP BY ps.skill)ps1 
WHERE ps.n = ps1.n AND ps.s1 <> ps1.s2 ORDER BY n,s1,s2;

\qecho 'Problem 9'

\qecho 'Problem 9a'

CREATE OR REPLACE FUNCTION  numberOfSkills(c TEXT)
RETURNS TABLE (pid INTEGER, salary INT, numberOfSkills BIGINT) AS
$$
(SELECT w.pid,w.salary,0 AS numberofskills 
 FROM worksfor w 
 WHERE w.cname = c AND pid NOT IN (SELECT p.pid FROM personskill p WHERE w.pid = p.pid)) 
 UNION 
 (SELECT w.pid, w.salary, COUNT(p.skill) AS numberofskills 
  FROM worksFor w, personSkill p 
  WHERE p.pid = w.pid AND w.cname = c GROUP BY w.pid, w.salary);
$$ LANGUAGE SQL;

\qecho 'Problem 9b'
SELECT * FROM numberofskills('Apple')  q ORDER BY q.numberofskills;
SELECT * FROM numberofskills('Amazon')  q ORDER BY q.numberofskills;
SELECT * FROM numberofskills('ACM')  q ORDER BY q.numberofskills;

\qecho 'Problem 9c'
CREATE OR REPLACE FUNCTION  numberOfSkills(c TEXT)
RETURNS TABLE (pid INTEGER, salary INT, numberOfSkills BIGINT) AS
$$
SELECT w.pid, w.salary, (SELECT COUNT(p.skill) FROM personskill p WHERE p.pid = w.pid) 
FROM worksFor w WHERE w.cname = c;
$$ language sql;

\qecho 'Problem 9d'
SELECT * FROM numberofskills('Apple')  q ORDER BY q.numberofskills;
SELECT * FROM numberofskills('Amazon')  q ORDER BY q.numberofskills;
SELECT * FROM numberofskills('ACM')  q ORDER BY q.numberofskills;


\qecho 'Problem 9e'
-- Using the function {\tt numberOfSkills} but without using set
-- predicates, write the following query: ``{\it Find each pair $(c,p)$
-- where $c$ is the name of a company and where $p$ is the pid of a
-- person who (1) works for company $c$, (2) makes more than 50000 and
-- (3) has the most job skills among all the employees who work for
-- company $c$}."

SELECT w.cname, n.pid 
FROM worksfor w, numberofskills(w.cname) n 
WHERE n.salary > 50000 EXCEPT SELECT w.cname, n1.pid 
                              FROM worksfor w, numberofskills(w.cname) n1, numberofskills(w.cname) n2 
                              WHERE n1.numberofskills < n2.numberofskills ORDER BY cname;

\qecho 'Problem 10'

create table P(coefficient integer, deg integer) ;

create table Q(coefficient integer, deg integer);

INSERT INTO P VALUES (2,2),(-5,1),(5,0) ;

INSERT INTO Q VALUES (4,4), (3,3), (1,2), (-1,1);

\qecho 'Polynomial P = 2x^2 - 5x + 5'

\qecho 'Polynomial Q = 4x^4 + 3x^3 + x^2 - x'

\qecho 'P'

SELECT * FROM P;

\qecho 'Q'

SELECT * FROM Q;

\qecho 'Problem 10a'

create or replace function multiplyPolynomials (polynomial1 text, polynomial2 text)
  returns table(coefficient integer, degree integer) as
$$
  begin
  return query
  execute
  'Select cast(sum(X.coefficient) as integer) , X.deg from(select p.coefficient * q.coefficient as coefficient ,
   p.deg + q.deg as deg from ' ||polynomial1||' p, '||polynomial2||' q where (p.coefficient * q.coefficient) <> 0)X
   group by (X.deg)';
  end;
$$language plpgsql;

\qecho 'Problem 10b.i'

select * from multiplyPolynomials('P','Q') order by degree DESC;

\qecho 'Problem 10b.ii'

select * from multiplyPolynomials('P', 'P') order by degree DESC;

\qecho "Problem 10b.iii"

create view QP as (select coefficient, degree as deg from multiplyPolynomials('Q', 'P') order by degree DESC);
select * from multiplyPolynomials ( 'P','QP') order by degree DESC;



-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE harshitshiroiya;





