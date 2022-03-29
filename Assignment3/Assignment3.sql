-- Script for Assignment 3

-- Creating database with full name

CREATE DATABASE harshit;

-- Connecting to database 
\c harshit
\o Desktop/'Assignment3.txt';

-- Relation schemas and instances for assignment 2

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
 (1014,1012);

\qecho 'Problem 6'

-- Consider the query ``Find the cname and headquarter of
-- each company that employs persons who earns less than 55000 and who do
-- not live in Bloomington.''

-- A possible way to write this query in Pure SQL is 

select c.cname, c.headquarter
from   company c
where  c.cname in (select w.cname
                   from   worksfor w
                   where  w.salary < 55000 and 
                          w.pid = SOME (select p.pid
                                        from   person p
                                        where  p.city <> 'Bloomington'));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

-- STEP 1
SELECT DISTINCT c.cname,c.headquarter 
FROM company c,worksFor w 
WHERE c.cname = w.cname AND w.salary < 55000 AND w.pid =SOME (SELECT p.pid 
                                                              FROM Person p 
                                                              WHERE p.city <> 'Bloomington');

-- STEP 2 
SELECT DISTINCT c.cname, c.headquarter
FROM company c, worksFor w, person p
WHERE w.cname = c.cname AND w.pid = p.pid AND w.salary < 55000 AND p.city <> 'Bloomington';



-- STEP 3
SELECT DISTINCT c.cname,c.headquarter 
FROM Company c,worksFor w, (SELECT p.pid FROM Person p WHERE p.city <> 'Bloomington')q 
WHERE c.cname = w.cname AND w.salary < 55000 AND w.pid = q.pid;

-- STEP 4
SELECT DISTINCT c.cname,c.headquarter 
FROM worksFor w NATURAL JOIN (SELECT p.pid FROM Person p WHERE p.city <> 'Bloomington')q 
JOIN company c ON (c.cname = w.cname AND w.salary < 55000);








\qecho 'Problem 7'

-- Consider the query ``Find the pid of each person who has
-- all-but-one job skill."

-- A possible way to write this query in Pure SQL is


select p.pid
from   person p
where  exists (select 1
               from   skill s
               where  (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                               from   personSkill ps)) and
        not exists (select 1
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill and
                           (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) and
                           (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps));




--- 1
select p.pid 
from person p 
where exists (select 1 
              from skill s 
              where (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                             from personSkill ps)) 
              intersect 
              select p.pid 
              from person p 
              where not exists (select 1 from skill s1, skill s2 where  s1.skill <> s2.skill and 
                (p.pid, s1.skill) not in (select ps.pid, ps.skill from personSkill ps) and 
                (p.pid, s2.skill) not in (select ps.pid, ps.skill from personSkill ps));


--- 2
select p.pid 
from person p, skill s 
where (p.pid, s.skill) not in (select ps.pid, ps.skill from personSkill ps) 
    intersect 
    select p.pid 
    from person p 
    except 
    select p.pid 
    from person p, skill s1, skill s2 
    where s1.skill <> s2.skill and 
    (p.pid, s1.skill) not in (select ps.pid, ps.skill from personSkill ps) and 
    (p.pid, s2.skill) not in (select ps.pid, ps.skill from personSkill ps);


--- 3
select p.pid 
from person p, skill s 
where (p.pid, s.skill) not in (select ps.pid, ps.skill from personSkill ps) 
intersect 
select p.pid from person p 
except 
select a.pid 
from (select p.*,s1.*,s2.* from person p, skill s1, skill s2 where s1.skill <> s2.skill 
      intersect 
      select p.*,s1.*,s2.* from person p, skill s1, skill s2 where 
      (p.pid, s1.skill) not in (select ps.pid, ps.skill from personSkill ps) 
      intersect 
      select p.*,s1.*,s2.* from person p, skill s1, skill s2 where 
      (p.pid, s2.skill) not in (select ps.pid, ps.skill from personSkill ps))a;


--- 4
select q.pid 
from (select p.*, s.* from person p, skill s  
      except select p1.*, s1.* 
      from person p1, skill s1, personSkill ps 
      where p1.pid=ps.pid and s1.skill=ps.skill)q 
      except 
      select y.pid 
      from (select p.*,s1.*,s2.* from person p, skill s1, skill s2 where s1.skill <> s2.skill 
        intersect 
        (select p.*,s1.*,s2.* from person p, skill s1, skill s2 
            except 
            select p.*, s1.*, s2.* from person p, skill s1, skill s2, personSkill ps where (p.pid, s1.skill)=
            (ps.pid, ps.skill)) intersect (select p.*,s1.*,s2.* from person p, skill s1, skill s2 
            except 
            select p.*, s1.*, s2.* from person p, skill s1, skill s2, personSkill ps where (p.pid, s2.skill)=(ps.pid, ps.skill)))y;


--- 5
select q.pid 
from (select p.*, s.* from person p cross join skill s except select p1.*, s1.* from person p1 natural join personSkill ps natural join skill s1)q 
except 
select y.pid from (select p.*,s1.*,s2.* from person p cross join skill s1 join skill s2 on 
    (s1.skill<>s2.skill) 
    intersect 
    (select p.*,s1.*,s2.* from person p cross join skill s1 cross join skill s2 
        except 
        select p.*, s1.*, s2.* from person p natural join personSkill ps natural join skill s1 cross join skill s2) 
        intersect 
        (select p.*,s1.*,s2.* from person p cross join skill s1 cross join skill s2 
        except 
        select p.*, s1.*, s2.* from person p natural join personSkill ps natural join skill s2 cross join skill s1))y;




-- steps you used to obtain your solution.

\qecho 'Problem 8'

-- Consider the query ``Find the pid and name of each person who
-- works for a company located in Bloomington but who does not knows any
-- person who lives in Chicago.''

 
-- A possible way to write this query in Pure SQL is

select p.pid, p.pname
from   person p
where  exists (select 1
               from   worksFor w, companyLocation c
               where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington') and
       p.pid not in (select k.pid1
                     from   knows k
                     where  exists (select 1
                                    from   person p
                                    where  k.pid2 = p.pid and  p.city = 'Chicago'));


-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

----- 1

Select q.pid,q.pname 
from (Select p.pid,p.pname 
      from Person p 
      where exists (Select 1 
                    from worksFor w,companyLocation c 
                    where p.pid=w.pid and w.cname=c.cname and c.city='Bloomington')
INTERSECT
Select p.pid,p.pname 
from Person p 
where p.pid not in (Select k.pid1 
                    from knows k where exists (Select 1 
                                               from Person p where k.pid2=p.pid and p.city='Chicago')))q;



-----
--- 2


Select q.pid,q.pname 
from (Select p.pid,p.pname 
      from person p, worksFor w, companyLocation c  
where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington' 
INTERSECT
Select p.pid,p.pname 
from Person p 
where p.pid not in (Select k.pid1 
                    from knows k where exists (Select 1 
                                               from Person p where k.pid2=p.pid and p.city='Chicago')))q;

--- 3

Select q.pid,q.pname 
from (Select p.pid,p.pname 
      from person p, worksFor w, companyLocation c  
where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington' 
INTERSECT
Select p.pid,p.pname 
from Person p 
where p.pid not in (Select k.pid1 
                    from knows k, Person p 
                    where k.pid2=p.pid and p.city='Chicago'))q;






---- 4


Select q.pid,q.pname 
from (Select p.pid,p.pname 
      from Person p,worksFor w,companyLocation c 
      where p.pid=w.pid and w.cname=c.cname and c.city='Bloomington'
INTERSECT
Select q2.pid,q2.pname from (
Select p.pid,p.pname from Person p
EXCEPT
Select p.pid,p.pname from Person p,knows k,Person p1
  where p.pid=k.pid1 and k.pid2=p1.pid and p1.city='Chicago')q2)q;

--------

\qecho 'Problem 9'

-- Consider the query ''Find the cname and headquarter of each company
-- that (1) employs at least one person and (2) whose workers who make
-- at most 70000 have both the programming and AI skills.”

select c.cname, c.headquarter
from   company c
where  exists (select 1 from worksfor w where w.cname = c.cname) and
       not exists (select 1
                   from   worksfor w
                   where  w.cname = c.cname and w.salary <= 70000 and
                          (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
                           w.pid not in (select ps.pid from personskill ps where skill = 'AI')));


--- 1

select q.cname, q.headquarter 
from (select c.* 
      from company c 
      where exists (select 1 
                    from worksfor w 
                    where w.cname = c.cname) 
        intersect 
        select c.* 
        from company c 
        where not exists (select 1 
                          from worksfor w 
                          where w.cname = c.cname and w.salary <= 70000 and (w.pid not in 
                            (select ps.pid 
                             from personskill ps 
                             where skill = 'Programming') or w.pid not in (select ps.pid from personskill ps where skill = 'AI'))))q;


--- 2
select q.cname, q.headquarter 
from (select c.* from company c, worksfor w where w.cname=c.cname 
      intersect 
      select c.* from company c where 
      not exists (select 1 from worksfor w where w.cname = c.cname and w.salary <= 70000 and 
        (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') 
        or w.pid not in (select ps.pid from personskill ps where skill = 'AI'))))q;


--- 3
select q.cname, q.headquarter 
from (select c.* from company c, worksfor w where w.cname=c.cname 
      intersect 
      select c.* from (select c1.* from company c1 
      except
      select c1.* from company c1, worksfor w  where w.cname = c1.cname and w.salary <= 70000 and 
      (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') 
      or w.pid not in (select ps.pid from personskill ps where skill = 'AI')))c)q;



--- 4
select q.cname, q.headquarter 
from (select c.* from company c, worksfor w where w.cname=c.cname 
      intersect 
      select c.* from (select c1.* from company c1 
      except 
      select c1.cname,c1.headquarter from (select c2.*,w.pid from company c2, worksfor w  where w.cname = c2.cname and w.salary <= 70000 
      intersect 
      select c2.*,w.pid from company c2, worksfor w  where w.cname = c2.cname and w.pid not in (select ps.pid from personskill ps where skill = 'Programming') 
      or w.pid not in (select ps.pid from personskill ps where skill = 'AI'))c1)c)q;


------ 5
select q.cname, q.headquarter 
from (select c.* from company c, worksfor w where w.cname=c.cname 
      intersect 
      select c.* from (select c1.* from company c1 
      except select c1.cname,c1.headquarter from 
      (select c2.*,w.pid from company c2, worksfor w  where w.cname = c2.cname and w.salary <= 70000 
      intersect 
      (select c2.*,w.pid from company c2, worksfor w  where w.cname = c2.cname and w.pid 
       not in (select ps.pid from personskill ps where skill = 'Programming') 
       union 
       select c2.*,w.pid from company c2, worksfor w  where w.pid 
       not in (select ps.pid from personskill ps where skill = 'AI')))c1)c)q;


--- 6
select q.cname, q.headquarter 
from (select c.* from company c, worksfor w where w.cname=c.cname 
      intersect 
      select c.* from (select c1.* from company c1 except select c1.cname,c1.headquarter from 
      (select c2.*,w.pid from company c2, worksfor w  where w.cname = c2.cname and w.salary <= 70000 
      intersect 
      (select c2.*,w.pid from company c2, worksfor w 
       except 
       select c2.*,w.pid from company c2, worksfor w, personskill ps where w.cname = c2.cname and w.pid=ps.pid and ps.skill='Programming' 
       union 
       select c2.*,w.pid from company c2, worksfor w 
       except 
       select c2.*,w.pid from company c2, worksfor w, personskill ps where w.cname = c2.cname and w.pid=ps.pid and ps.skill='AI'))c1)c)q;



--- 7
select q.cname, q.headquarter 
from (select c.* from company c, worksfor w where w.cname=c.cname 
      intersect 
      select c.* from (select c1.* from company c1 except select c1.cname,c1.headquarter 
      from (select c2.*, w.pid from company c2, (select w1.* from worksfor w1 where w1.salary<=70000)w  
      where w.cname=c2.cname 
      intersect 
      (select c2.*,w.pid from company c2, worksfor w 
        except 
        select c2.*,w.pid from company c2, worksfor w, 
        (select ps1.* from personskill ps1 where ps1.skill='Programming')ps 
         where  w.cname=c2.cname and w.pid=ps.pid 
         union 
         select c2.*,w.pid from company c2, worksfor w 
         except 
         select c2.*,w.pid from company c2, worksfor w, 
         (select ps1.* from personskill ps1 where ps1.skill='AI')ps where  w.cname=c2.cname and w.pid=ps.pid))c1)c)q;



--- 8
select q.cname, q.headquarter 
from (select c.* from company c natural join worksfor w 
      intersect 
      select c.* from (select c1.* from company c1 
      except 
      select c1.cname,c1.headquarter 
      from (select c2.*, w.pid from company c2 
        natural join (select w1.* from worksfor w1 where w1.salary<=70000)w 
        intersect 
        (select c2.*,w.pid from company c2 natural join worksfor w 
        except 
        select c2.*,w.pid from company c2 natural join worksfor w 
        natural join (select ps1.* from personskill ps1 where ps1.skill='Programming')ps 
        union 
        select c2.*,w.pid from company c2 natural join worksfor w 
        except 
        select c2.*,w.pid from company c2 natural join worksfor w 
        natural join (select ps1.* from personskill ps1 where ps1.skill='AI')ps))c1)c)q;






\qecho 'Problem 10'

-- Consider the following Pure SQL query.

select p.pid, exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
from   Person p;


--- 1 

Select distinct q.pid,'f' as bool from (Select p.pid,p.pname from Person p
  EXCEPT
  Select distinct p.pid,p.pname from hasManager hm1,hasManager hm2, Person p where
  hm1.mid=p.pid and hm2.mid=p.pid and hm1.eid<>hm2.eid)q
Union
Select distinct p.pid,'t' as bool from Person p,hasManager hm1,hasManager hm2 where
hm1.mid=p.pid and hm2.mid=p.pid and hm1.eid<>hm2.eid ORDER BY pid;

--- 2

Select distinct q.pid,'f' as booleanvalue from (Select p.pid,p.pname from Person p
  EXCEPT
  Select distinct p.pid,p.pname from hasManager hm1 Join Person p on (hm1.mid=p.pid)
  Join hasManager hm2 on (hm2.mid=p.pid) where hm1.eid<>hm2.eid)q
Union
Select distinct p.pid,'t' as booleanvalue from Person p,hasManager hm1,hasManager hm2 where
hm1.mid=p.pid and hm2.mid=p.pid and hm1.eid<>hm2.eid ORDER BY pid;

--- 3

Select distinct q.pid,'f' as booleanvalue from (Select p.pid,p.pname from Person p
  EXCEPT
  Select distinct p.pid,p.pname from hasManager hm1 Join Person p on (hm1.mid=p.pid)
  Join hasManager hm2 on (hm2.mid=p.pid) where hm1.eid<>hm2.eid)q
Union
Select distinct p.pid,'t' as booleanvalue from Person p Join hasManager hm1 on (hm1.mid=p.pid)
  Join hasManager hm2 on (hm2.mid=p.pid) where hm1.eid<>hm2.eid ORDER BY pid;


-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE harshit;





