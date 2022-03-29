create database harshitshiroiya1to5;

\c harshitshiroiya1to5



\qecho 1

-- Helper Functions
drop function if exists SetOfIntegers(int, int, int);
create or replace function SetOfIntegers(n int, l int, u int)
	returns table (x int) as
	$$
		select floor(random() * (u-l+1) + l)::int as x
		from generate_series(1,n)
		group by (x) order by 1;
	$$ language sql;

drop function if exists BinaryRelationOverIntegers(int, int, int, int ,int);
create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
	returns table (x int, y int) as
	$$
		select floor(random() * (u_1-l_1+1) + l_1)::int as x,
		floor(random() * (u_2-l_2+1) + l_2)::int as y
		from generate_series(1,n)
		group by (x,y) order by 1,2;
	$$ language sql;

drop table if exists P; create table P(x int);
drop table if exists Q; create table Q(x int);
drop table if exists R; create table R(x int, y int);
drop table if exists S; create table S(x int, z int);

INSERT INTO P
	select * from SetOfIntegers(1000, 1, 100);

INSERT INTO Q
	select * from SetOfIntegers(1000, 1, 100);

INSERT INTO R
	select * from BinaryRelationOverIntegers(1000, 1, 100, 1, 100);

INSERT INTO S
	select * from BinaryRelationOverIntegers(1000, 1, 100, 1, 100);


-- Query 1
set enable_mergejoin = off; set enable_hashjoin = off; set enable_material = off;
explain (costs off)
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and exists (select 1 
			  						      from s s
			  						      where s.x <> q.x or r.y <> s.z));

-- Query 2
set enable_mergejoin = on; set enable_hashjoin = on;
explain (costs off)
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and exists (select 1 
			  						      from s s
			  						      where s.x <> q.x or r.y <> s.z));

-- Query 3
drop index if exists indexed_s;
create index indexed_s on s using hash (x);
explain (costs off)
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and exists (select 1 
			  						      from s s
			  						      where s.x <> q.x or r.y <> s.z));


-- Query 4
drop index if exists indexed_s;
explain (costs off)
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and (q.x not in (select s.x 
			  								   from s s) or r.y not in(select s.z
			  								   						   from s s)));

-- Query 5
explain (costs off)
select p.x, q.x
from P p, Q q, R r
where r.x = p.x and (q.x not in (select s.x 
		  					 	 from s s) or r.y not in(select s.z
		  					 	 						 from s s));

-- Query 6
explain (costs off)
select p.x, q.x
from P p, Q q, R r, S s
where r.x = p.x and (q.x <> s.x or r.y <> s.z);


-- Query 7
explain (costs off)
select p.x, qs.x
from (select x, y from P natural join R) p
join
(select q.x, s.z from Q inner join S on Q.x <> S.x) qs on (p.y <> qs.z);

\qecho 2

-- Helper Functions
create or replace function SetOfIntegers(n int, l int, u int)
	returns table (x int) as
	$$
		select floor(random() * (u-l+1) + l)::int as x
		from generate_series(1,n)
		group by (x) order by 1;
	$$ language sql;

create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
	returns table (x int, y int) as
	$$
		select floor(random() * (u_1-l_1+1) + l_1)::int as x,
		floor(random() * (u_2-l_2+1) + l_2)::int as y
		from generate_series(1,n)
		group by (x,y) order by 1,2;
	$$ language sql;

-- Creating Tables

drop table if exists P;create table P(a int);
drop table if exists S;create table S(b int);

-- Generate P
insert into p
	select * from SetOfIntegers(1000000, 1, 10000);

-- Generate S
insert into S
	select * from SetOfIntegers(1000000, 1, 10000);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^3
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^4
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(10000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^6
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^7
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(10000000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

\qecho 3

-- Helper Functions
drop function if exists SetOfIntegers(int, int, int);
create or replace function SetOfIntegers(n int, l int, u int)
	returns table (x int) as
	$$
		select floor(random() * (u-l+1) + l)::int as x
		from generate_series(1,n)
		group by (x) order by 1;
	$$ language sql;

drop function if exists BinaryRelationOverIntegers(int, int, int, int, int);
create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
	returns table (x int, y int) as
	$$
		select floor(random() * (u_1-l_1+1) + l_1)::int as x,
		floor(random() * (u_2-l_2+1) + l_2)::int as y
		from generate_series(1,n)
		group by (x,y) order by 1,2;
	$$ language sql;

-- Creating Tables


-- 1

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 100);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 100);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 100, 1, 10000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));


-----------------------------------------------------------------------------------------------------------
-- 2

-- Generate R - 10^3
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000, 1, 100, 1, 100);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

-----------------------------------------------------------------------------------------------------------
-- 3

-- Generate R - 10^4
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(10000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

-----------------------------------------------------------------------------------------------------------
-- 4

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^3
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

----------------------------------------------------------------------------------------------------------
-- 5

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^4
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(10000, 1, 1000);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

----------------------------------------------------------------------------------------------------------
-- 6

-- Generate P - 10^3
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

----------------------------------------------------------------------------------------------------------
-- 7

-- Generate P - 10^4
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(10000, 1, 1000);

-- Generate S - 10^3
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

---------------------------------------------------------------------------------------------------------
-- 8

-- Generate P - 10^5
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100000, 1, 1000);

-- Generate S - 10^5
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100000, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

\qecho 4

-- Helper Functions
drop function if exists SetOfIntegers(int, int, int);
create or replace function SetOfIntegers(n int, l int, u int)
	returns table (x int) as
	$$
		select floor(random() * (u-l+1) + l)::int as x
		from generate_series(1,n)
		group by (x) order by 1;
	$$ language sql;

drop function if exists BinaryRelationOverIntegers(int, int, int, int, int);
create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
	returns table (x int, y int) as
	$$
		select floor(random() * (u_1-l_1+1) + l_1)::int as x,
		floor(random() * (u_2-l_2+1) + l_2)::int as y
		from generate_series(1,n)
		group by (x,y) order by 1,2;
	$$ language sql;



-- 1

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 100);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 100);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 100, 1, 100);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);


----------------------------------------------------------------------------------------------------------------------
-- 2

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 1000);

-- Generate R - 10^3
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);


------------------------------------------------------------------------------------------------------------------
-- 3

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 1000);

-- Generate R - 10^4
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(10000, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);



------------------------------------------------------------------------------------------------------------------
-- 4

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^3
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate R - 10^4
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);


-------------------------------------------------------------------------------------------------------------
-- 5

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^4
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(10000, 1, 1000);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);


-------------------------------------------------------------------------------------------------------------
-- 6

-- Generate P - 10^3
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);


-------------------------------------------------------------------------------------------------------------
-- 7

-- Generate P - 10^4
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(10000, 1, 1000);

-- Generate S - 10^3
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);


-------------------------------------------------------------------------------------------------------------
-- 8

-- Generate P - 10^5
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100000, 1, 1000);

-- Generate S - 10^5
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100000, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);


----------------------------------------------------------------------------------------------------
-- 9

-- Generate P - 10^6
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(1000000, 1, 1000);

-- Generate S - 10^6
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(1000000, 1, 1000);

-- Generate R - 10^6
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000000, 1, 1000, 1, 1000);


-- Analyzing Q8 1
explain analyze
select p.a
from P p
where exists (select 1
			  from S s
			  where not exists (select 1 
			  					from R 
			  					where p.a = r.a and r.b = s.b));


-- Analyzing Q9 1
explain analyze
select p.a
from p
except
select r.a
from r
natural join s;

-- Analyzing Q10
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	Ss as (select array(select b from S) as bs)
select a
from P
where a not in (select a from nestedR) and
not((select bs from Ss) <@ '{}')
union
select a
from nestedR
where not((select bs from Ss) <@ bs);

--Collaborated with: Harshit Shiroiya and Satin Sunil Jain

\c postgres
drop database harshitshiroiya1to5;


	

