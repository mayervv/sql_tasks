--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing

--task1
--�������: ��� ������� ������ ���������� ����� �������� ����� ������, ����������� � ���������. �������: ����� � ����� ����������� ��������.


select class, count (name)
from ships
join outcomes on outcomes.ship=ships.name
where result='sunk'
group by class

--task2
--�������: ��� ������� ������ ���������� ���, ����� ��� ������ �� ���� ������ ������� ����� ������. 
-- ���� ��� ������ �� ���� ��������� ������� ����������, ���������� ����������� ��� ������ �� ���� 
-- �������� ����� ������. �������: �����, ���.

select classes.class, t.min_launched
from classes
left join
(select class, min (launched) as min_launched
from ships
group by class) t on t.class=classes.class

--task3
--�������: ��� �������, ������� ������ � ���� ����������� �������� � �� ����� 3 �������� 
-- � ���� ������, ������� ��� ������ � ����� ����������� ��������.

select class, count (result) as sunked_ships
from
(select name,class, result 
from ships
join outcomes on ships.name=outcomes.ship 
where result='sunk')as t
group by class
having count (t.name)>=3 and count (t.result)>0

--task4
--�������: ������� �������� ��������, ������� ���������� ����� ������ ����� ���� �������� 
-- ������ �� ������������� (������ ������� �� ������� Outcomes).

select name
from 
(select name, class from ships
union
select ship, ship from outcomes
) as t
join classes on t.class=classes.class
where numguns>=all 
(select numguns 
from classes as m
where m.displacement=classes.displacement and m.class in 
(select t.class from 
(select name, class from ships
union
select ship, ship from outcomes) as t))
order by name

--task5
--������������ �����: ������� �������������� ���������, ������� ���������� �� � ���������� ������� 
-- RAM � � ����� ������� ����������� ����� ���� ��, ������� ���������� ����� RAM. �������: Maker
select distinct maker
from product
where maker in (select maker from product where type='Printer')
and model in (select model from pc where ram=(select min (ram) from pc) 
and speed=(select max (speed) from pc where ram=(select min (ram) from pc)))
order by maker



