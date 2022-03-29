
-- Script for Assignment 6

-- Creating database with full name

CREATE DATABASE harshitshiroiya;

-- Connecting to database 
\c harshitshiroiya
\o 'Desktop/Assignment6.txt' 




\qecho 'Problem 3'

-- set work_mem = '1GB';
-- set work_mem = '64KB';
set work_mem = '4MB';

create or replace function SetOfIntegers(n int, l int, u int)
    returns table (x int) as
$$
    select floor(random() * (u-l+1) + l)::int from generate_series(1,n) ;
$$ language sql;



create or replace function makeS (n integer)
     returns void as
     $$
     begin
         -- drop table if exists S;
         create table S (x int);
         insert into S select * from SetOfIntegers(n,1,n);
     end;
     $$ language plpgsql;

Select x from SetofIntegers(5,5,10);

select makeS(1000);

explain analyze select x from S;

explain analyze select x from S order by 1;

Select * from S;





create or replace function SetOfIntegers(n int, l int, u int)
returns table (x int) as
$$
select floor(random() * (u-l+1) + l)::int from generate_series(1,n);
$$ language sql;



CREATE TABLE Company(cname text,
                     primary key (cname));

INSERT INTO Company VALUES
     ('Apple'),
     ('Amazon'),
     ('Google'),
     ('Netflix'),
     ('Microsoft'),
     ('IBM'),
     ('ACM'),
     ('Yahoo');




CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid));

CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid),
                      foreign key (pid) references Person (pid),
                      foreign key (cname) references Company(cname));

create or replace function Create_WorksforTable (start integer, fin integer)
returns void as
$$
begin
  for i in start..fin loop
    INSERT INTO Person  
    select i , concat( 'table', i )  order by random() limit 1;
    INSERT INTO worksfor (pid, cname, salary )  
    select i , c.cname , (floor((s.x + 999) / 1000) * 1000) from company c, SetofIntegers(10,5000,20000) s order by random() limit 1 ;
  end loop;
end;
$$ language plpgsql;

vacuum;

select Create_WorksforTable(1, 1000);

\qecho 'Problem 10'



explain analyze select pid from worksFor where cname = 'Apple';

create index cname_index on worksFor using btree (salary);

explain analyze select pid from worksFor where cname = 'Apple';



\qecho 'Problem 11'

explain analyze select pid, cname from worksFor where 12000 <= salary and salary <= 16000;

create index salary_index on  worksFor using btree (salary);

explain analyze select pid, cname from worksFor where 12000 <= salary and salary <= 16000;

\qecho 'Problem 12'

explain analyze select pid from worksFor where salary = 15000 and cname = 'Apple';

create index salaryANDcname_index on  worksFor using btree (cname,salary);

explain analyze select pid from worksFor where salary = 15000 and cname = 'Apple';

\qecho 'Problem 13'

\qecho 'NOT IN'

explain analyze select pid,pname from public.person where pid not in (select pid from worksfor w where cname = 'Apple');

create index cname_worksfor_index on worksfor (cname);

explain analyze select pid,pname from public.person where pid not in (select pid from worksfor w where cname = 'Apple');

\qecho 'IN'

explain analyze select pid,pname from public.person where pid  in (select pid from worksfor w where cname = 'Apple');

create index pidPersons_index on person (pid);

explain analyze select pid,pname from public.person where pid  in (select pid from worksfor w where cname = 'Apple');



-- Collabarated with Satin Jain 

\c postgres

drop database harshitshiroiya;