-- Creating database with full name
 
CREATE DATABASE harshitshiroiya;

-- Connecting to database 
\c harshitshiroiya;
\o Desktop/Assignment1.txt;



-- Table creation query

CREATE TABLE Person
(
	pid integer NOT NULL,
	pname text,
	city text,
	PRIMARY KEY (pid)
);


CREATE TABLE Company
(
	cname text, 
	headquarter text,
	PRIMARY KEY (cname)
);


CREATE TABLE Skill
(
	skill text,
	PRIMARY KEY (skill)
);


CREATE TABLE worksFor
(
	pid integer,
	cname text,
	salary text,
	FOREIGN KEY (pid)
		REFERENCES Person (pid),
    FOREIGN KEY (cname)
		REFERENCES Company (cname)
);


CREATE TABLE companyLocation
(
	cname text,
	city text,
	FOREIGN KEY (cname)
		REFERENCES Company (cname),
	PRIMARY KEY (city)
);


CREATE TABLE personSkill
(
	pid integer,
	skill text,
	FOREIGN KEY (pid)
		REFERENCES Person (pid),
	FOREIGN KEY (skill)
		REFERENCES Skill (skill)		
);


CREATE TABLE hasManager
(
	eid integer NOT NULL,
	mid integer NOT NULL,
	FOREIGN KEY (eid)
		REFERENCES Person (pid),
	FOREIGN KEY (mid)
		REFERENCES Person (pid)
);

-- Populating the Database

     -- Data for B561 Fall 2021 Assignment 1

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
     ('ACM', 'NewYork');


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
     (1013,'Netflix', 55000),
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
   ('IBM', 'NewYork');

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
 (1013,'AI'),
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
 (1019,'Networks');

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
 (1014, 1012);

\qecho 'Problem 1'
-- Provide 4 conceptually different examples that illustrate how the
-- presence or absence of primary and foreign keys affect insert and
-- deletes in these relations.  To solve this problem, you will need to
-- experiment with the relation schemas and instances for this
-- assignment.  For example, you should consider altering primary keys
-- and foreign key constraints and then consider various sequences of
-- insert and delete operations.  You may need to change some of the
-- relation instances to observe the desired effects.  Certain inserts
-- and deletes should succeed but other should generate error
-- conditions.  (Consider the lecture notes about keys, foreign keys,
-- and inserts and deletes as a guide to solve this problem.)

\qecho 'Problem 1 conceptual example 1'
 INSERT INTO personSkill VALUES (1020,'ADC');
\qecho 'Problem 1 conceptual example 2'
 DELETE FROM Person WHERE pid = 1003;
\qecho 'Problem 1 conceptual example 3'
 INSERT INTO Person VALUES (1004, 'HARSHIT','Cupertino');
\qecho 'Problem 1 conceptual example 4'
 INSERT INTO worksFor VALUES (1060, 'Facebook', 70000);
 ALTER TABLE worksFor DROP  CONSTRAINT worksfor_pid_fkey;
 ALTER TABLE worksFor DROP  CONSTRAINT worksfor_cname_fkey; 
 INSERT INTO worksFor VALUES (1060, 'Facebook', 70000);

-- DROPPING THE TABLES

DROP TABLE personSkill;
DROP TABLE companyLocation;
DROP TABLE hasManager;
DROP TABLE worksFor;
DROP TABLE Company;
DROP TABLE Skill;
DROP TABLE Person;


-- CREATING THE TABLES

CREATE TABLE Person
(
	pid integer NOT NULL,
	pname text,
	city text,
	PRIMARY KEY (pid)
);


CREATE TABLE Company
(
	cname text, 
	headquarter text,
	PRIMARY KEY (cname)
);


CREATE TABLE Skill
(
	skill text,
	PRIMARY KEY (skill)
);


CREATE TABLE worksFor
(
	pid integer,
	cname text,
	salary text,
	FOREIGN KEY (pid)
		REFERENCES Person (pid),
    FOREIGN KEY (cname)
		REFERENCES Company (cname)
);


CREATE TABLE companyLocation
(
	cname text,
	city text,
	FOREIGN KEY (cname)
		REFERENCES Company (cname),
	PRIMARY KEY (city)
);


CREATE TABLE personSkill
(
	pid integer,
	skill text,
	FOREIGN KEY (pid)
		REFERENCES Person (pid),
	FOREIGN KEY (skill)
		REFERENCES Skill (skill)		
);


CREATE TABLE hasManager
(
	eid integer NOT NULL,
	mid integer NOT NULL,
	FOREIGN KEY (eid)
		REFERENCES Person (pid),
	FOREIGN KEY (mid)
		REFERENCES Person (pid)
);

-- Populating the Database

     -- Data for B561 Fall 2021 Assignment 1

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
     ('ACM', 'NewYork');


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
     (1013,'Netflix', 55000),
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
   ('IBM', 'NewYork');

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
 (1013,'AI'),
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
 (1019,'Networks');

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
 (1014, 1012);

-- Before starting with the rest of the assignment, make sure to
-- use the originally given data set in data.sql

\qecho 'Problem 2'
-- Find the pid, pname of each person who (a) lives in Bloomington, (b)
-- works for a company where he or she earn a salary that is higher than
-- 30000, and (c) has at least one manager.

SELECT p.pid, p.pname
FROM person p, worksFor w, hasManager h
WHERE p.city = 'Bloomington' AND w.salary > '30000' AND p.pid = w.pid AND h.eid=p.pid
ORDER BY p.pid;



\qecho 'Problem 3'
-- Find the pairs $(c_1, c_2)$ of different company names who
-- headquarters are located in the same city.

SELECT c1.cname as c_1, c2.cname as c_2
FROM Company c1, Company c2
WHERE c1.headquarter = c2.headquarter AND c1.cname <> c2.cname;



\qecho 'Problem 4'
-- Find the pid and pname of each person who lives in a city that is
-- different than each city in which his or her managers live.
-- (Persons who have no manager should not be included in the answer.)

SELECT  p.pid, p.pname
FROM hasManager h, Person p
WHERE p.pid = h.eid AND p.pid NOT IN (SELECT p1.pid
		FROM Person p1,hasManager h1, Person p2  
		WHERE p1.pid = h1.eid AND p2.pid = h1.mid AND p1.city = p2.city) 
		ORDER BY pid;

\qecho 'Problem 5'
-- Find each skill that is the skill of at most 2 persons.

SELECT  s.skill
FROM skill s, personSkill p 
EXCEPT(select p1.skill 
	   FROM  personSkill p1, personSkill p2, personSkill p3 	
	   WHERE p1.pid = p2.pid AND p2.pid = p3.pid  AND p1.pid = p3.pid AND p1.skill <> p2.skill AND p2.skill <> p3.skill AND p1.skill <> p3.skill);  


\qecho 'Problem 6'
-- Find the pid, pname, and salary of each employee who has at least two
-- managers such that these managers have a common job skill but provided
-- that it is not the `Networks' skill.

SELECT p.pid, p.pname, w.salary
FROM Person p, worksFor w
WHERE p.pid = w.pid AND p.pid IN (SELECT h1.eid 
								  FROM personSkill p1, personSkill p2, hasManager h1, hasManager h2
								  WHERE p1.pid = h1.eid AND p2.pid = h2.eid AND h1.mid <> h2.mid AND h1.eid = p.pid AND h2.eid = p.pid AND p1.skill = p2.skill AND p1.skill <> 'Networks' );



\qecho 'Problem 7'
-- Find the cname of each company that not only employs persons
-- who live in MountainView.

SELECT DISTINCT w.cname
FROM Person p, worksFor w
WHERE p.pid = w.pid
EXCEPT (SELECT w1.cname
		FROM Person p1, worksFor w1
		WHERE w1.pid = p1.pid AND p1.city = 'MountainView')
ORDER BY cname;


\qecho 'Problem 8'
-- For each company, list its name along with the highest salary made by
-- employees who work for it.

SELECT w.cname, w.salary
FROM worksFor w, Company c
WHERE c.cname = w.cname AND w.salary >= ALL (SELECT w1.salary
								  FROM worksfor w1
								  WHERE  w1.cname = w.cname)
ORDER BY cname;


\qecho 'Problem 9'
-- Find the pid and pname of each employee who has a salary that is
-- higher than the salary of each of his or her managers.  (Employees who
-- have no manager should not be included.)

SELECT DISTINCT p.pid, p.pname 
FROM person p, worksFor w, hasManager h
WHERE p.pid = h.eid AND h.eid = w.pid AND w.salary >  ALL (SELECT w1.salary
														   FROM worksfor w1, hasManager h1 
														   WHERE w1.pid = h1.mid AND p.pid = h1.eid)
ORDER BY pid;

\qecho 'Problem 10'

SELECT p.pid, p.pname, w.cname, w.salary
FROM Person p, worksFor w
WHERE p.pid = w.pid AND p.city = 'Bloomington' AND w.salary >= '40000' AND w.cname <> 'Apple';


\qecho 'Problem 11'

SELECT p.pid, p.pname
FROM Person p 
WHERE p.pid IN (SELECT w.pid
				FROM Company c, worksFor w	
				WHERE c.cname = w.cname AND c.headquarter = 'LosGatos' AND p.pid IN (SELECT hm.eid
																					 FROM hasManager hm, Person m
																					 WHERE hm.mid = m.pid AND m.city <> 'LosGatos'));


\qecho 'Problem 12'

SELECT s.skill
FROM skill s
WHERE s.skill NOT IN (SELECT ps.skill
					  FROM personSkill ps, Person p	
					  WHERE p.pid = ps.pid AND p.city = 'Bloomington');

\qecho 'Problem 13'

SELECT m.pid, m.pname
FROM Person m
WHERE NOT EXISTS (SELECT 1
				  FROM hasManager hm
				  WHERE hm.mid = m.pid AND NOT EXISTS (SELECT 1
							  						   FROM Person e
							  						   WHERE hm.eid = e.pid AND e.city = m.city));

\qecho 'Problem 18'
-- Each person works for a company and has at least two job skills.

SELECT NOT EXISTS(SELECT 1
				  FROM Person p
				  WHERE NOT EXISTS (SELECT 1
				  					FROM worksfor w	
				  					WHERE p.pid = w.pid AND EXISTS (SELECT 1 
				  												FROM personSkill ps1, personSkill ps2
				  												WHERE ps1.pid = p.pid AND ps2.pid = p.pid AND ps1.skill <> ps2.skill)))constraintSatisfied;



\qecho 'Problem 19'
-- Some person has a salary that is strictly higher than the salary of
-- each of his or her managers.

SELECT EXISTS (SELECT 1
			   FROM Person p, worksFor w 
			   WHERE p.pid=w.pid AND NOT EXISTS (SELECT 1 
												 FROM  worksFor w1, hasManager h
												 WHERE w.salary > w1.salary AND NOT EXISTS(SELECT 1
												 										   WHERE w1.pid = h.mid)))constraintSatisfied;


\qecho 'Problem 20'
-- Each employee and his or her managers work for the same company.

SELECT NOT EXISTS (SELECT 1
				   FROM hasManager h, worksFor w, worksFor w1
				   WHERE w.pid = h.eid AND w1.pid = h.mid AND NOT EXISTS (SELECT 1 
				   														   FROM worksFor w, worksFor w1
				   														   WHERE w.cname = w1.cname))constraintSatisfied;

-- Connect to default database
\c postgres;

-- Drop database created for this assignment
DROP DATABASE harshitshiroiya;
