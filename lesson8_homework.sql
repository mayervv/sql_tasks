--task1  (lesson8)
-- oracle: https://leetcode.com/problems/department-top-three-salaries/

--task2  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/17

select member_name, status, sum (unit_price*amount) as costs
from familymembers as fm
join payments p on p.family_member=fm.member_id
where year(date) = '2005'
group by member_name, status
order by costs

--task3  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/13

select name
from passenger
group by name
having count (name)>1

--task4  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count (first_name) as count
from student
where first_name='Anna'

--task5  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/35

select distinct COUNT(classroom) as COUNT
from Schedule
where date='2019-09-02'

--task6  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/38

select count (first_name) as count
from student
where first_name='Anna'

--task7  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/32

select floor (avg (year(now()) - year (birthday))) as age
from familymembers

--task8  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/27

select good_type_name, sum (unit_price * amount) as costs
from goodtypes gt
join goods g on g.type=gt.good_type_id
join payments p on p.good=g.good_id
where year(date)='2005'
group by good_type_name

--task9  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/37

select floor (min(datediff(now(), birthday) / 365)) as year
from student

--task10  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/44

with t as
(select student, class 
from Class c 
join Student_in_class sc on c.id = sc.class 
where name like '10%')
select floor(max(datediff(now(), birthday) / 365)) as max_year from Student s 
join t on s.id = t.student

--task11 (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/20

select status, member_name, sum (unit_price * amount) as costs
from FamilyMembers fm
join payments p on fm.member_id=p.family_member
join goods g on g.good_id=p.good
join goodtypes gt on gt.good_type_id=g.type
where good_type_name='entertainment'
group by status, member_name

--task12  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/55

delete from company
where id in 
(select company 
from trip 
group by company 
having count (id)= (
select min (c) 
from (
select count (id) as c
from Trip
group by company) as t))

--task13  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/45

select classroom
from Schedule
group by classroom
having count (classroom)=
(select count(classroom)
from Schedule
group by classroom
order by classroom desc limit 1)

--task14  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/43

select last_name
from teacher t
join schedule sc on t.id=sc.teacher
join subject su on su.id=sc.subject
where name = 'Physical Culture'
order by last_name asc

--task15  (lesson8)
-- https://sql-academy.org/ru/trainer/tasks/63

select CONCAT(last_name, '.', LEFT(first_name,1),'.', left (middle_name,1), '.') as name
from student
order by last_name, first_name
