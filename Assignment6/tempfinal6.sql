-- Script for Assignment 6

-- Creating database with full name

CREATE DATABASE harshitshiroiya;

-- Connecting to database 
\c harshitshiroiya
\o 'Desktop/Assignment6.txt' 



\qecho 'Problem 1'

create table P (outcome int,
                probability float);

create or replace function RelationOverProbabilityFunction(n integer , l1 integer, u1 integer, l2 integer, u2 integer)
returns table(x int,y int) as
$$
with sample as (select outcome,probability,sum(probability) over (partition by batch order by outcome) as cumprobability from (select *,0 as batch from P) as x),
distribute as(select min(outcome) from sample,(select random() x from generate_series(1,n)) y where y.x<cumprobability group by y.x)
select floor(random()*(u1-l1+1)+1)::int x, min::int y from distribute ;
$$ language sql;


\qecho 'Test case 1 - uniform mass function'
insert into P values
  (1, 0.2),
  (2, 0.2),
  (3, 0.2),
  (4, 0.2),
  (5, 0.2);

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 5) ;

delete from P;


\qecho 'Test case 2 - non-uniform function'
insert into P values
  (1, 0.25),
  (2, 0.10),
  (3, 0.40),
  (4, 0.10),
  (5, 0.15);





select * from RelationOverProbabilityFunction(100, 1, 150, 1, 5);




\qecho 'Problem 5'

-- Data
-- Relation schemas and instances for assignment 6

create table Student(sid text,
                     sname text,
                     major text,
                     byear int,
                     primary key(sid));

-- We don't specify any constraints on enroll
create table Enroll (sid text,
                     cno text,
                     grade text);

insert into Student values 
 ('s100','Eric','CS',1988),
 ('s101','Nick','Math',1991),
 ('s102','Chris','Biology',1977),
 ('s103','Dinska','CS',1978),
 ('s104','Zanna','Math',2001),
 ('s105','Vince','CS',2001);


insert into Enroll values 
 ('s100','c200','A'),
 ('s100','c201','B'),
 ('s100','c202','A'),
 ('s101','c200','B'),
 ('s101','c201','A'),
 ('s102','c200','B'),
 ('s103','c201','A'),
 ('s101','c202','A'),
 ('s101','c301','C'),
 ('s101','c302','A'),
 ('s102','c202','A'),
 ('s102','c301','B'),
 ('s102','c302','A'),
 ('s104','c201','D');



-- Set intersection $A\cap B$:
create or replace function set_intersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Set union $A \cup B$:
create or replace function set_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) union select unnest(B) order by 1);
$$ language sql;

-- Set difference $A-B$:
create or replace function set_difference(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) except select unnest(B) order by 1);
$$ language sql;


create or replace function FindStudents(input_bool text, input_cno text, input_grade text)
returns table (sid text, sname text, major text, byear int) as
$$
begin
return query
execute(select replace(
  replace(
    replace ('select s.sid,s.sname,s.major,s.byear 
    from student s
    where s.sid in 
    (select e.sid from enroll_data e  where e.tid in (select tid1 :: bigint from unnest('||input_bool||'(array(select * from indexoncno('''||input_cno||''')),
         array(select * from indexongrade('''||input_grade||''')))) as tid1) )', 'and not(array', 'set_difference(array')
  ,'or(array','set_union(array'),
  'and(array','set_intersection(array'));
end;
$$ language plpgsql;

create or replace view enroll_data as
(select row_number() over(order by sid,cno asc) as tid,* from enroll);

create or replace function indexoncno(input_cno text)
returns text[] as
$$
select array(select tid from enroll_data where cno = input_cno) as tid;
$$ language sql immutable;

create or replace function indexongrade(input_grade text)
returns text[] as
$$
select array(select tid from enroll_data where grade = input_grade) as tid;
$$ language sql immutable;

select * from FindStudents('and', 'c202', 'A');

 select sid, sname, major, byear
   from   Student
   where  sid in (select sid
                  from   Enroll sid
                  where  cno = 'c202' and grade = 'A');

\qecho 'Problem 5.a'
select * from FindStudents('and', 'c202', 'A');

\qecho 'Problem 5.b'
select * from FindStudents('or', 'c202', 'A');

\qecho 'Problem 5.c'
select * from FindStudents('and not', 'c202', 'A');




-- Collabarated with Satin Jain 

\c postgres

drop database harshitshiroiya;
