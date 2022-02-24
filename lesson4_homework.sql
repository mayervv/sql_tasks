--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task13 (lesson3)
--������������ �����: ������� ������ ���� ��������� � ������������� � ��������� ���� �������� 
-- (pc, printer, laptop). �������: model, maker, type

select model, maker, type
from product
order by model

--task14 (lesson3)
--������������ �����: ��� ������ ���� �������� �� ������� printer ������������� ������� ��� ���, 
-- � ���� ���� ����� ������� PC - "1", � ��������� - "0"

select *,
case 
when printer.price > (select avg (price) from pc)
then 1 else 0
end avg_price
from printer

--task15 (lesson3)
--�������: ������� ������ ��������, � ������� class ����������� (IS NULL)

select name
from ships
where class is null

--task16 (lesson3)
--�������: ������� ��������, ������� ��������� � ����, �� ����������� 
-- �� � ����� �� ����� ������ �������� �� ����.

select name
from battles
where year (date)!=(select launched from ships)


--task17 (lesson3)
--�������: ������� ��������, � ������� ����������� ������� ������ Kongo �� ������� Ships.

select battle from outcomes
join ships on outcomes.ship=ships.name 
where class = 'Kongo'

--task1  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_300) 
-- ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ > 300. 
-- �� view ��� �������: model, price, flag

create view all_products_flag_300 as
select model, price,
case when price>300 then 1
else 0
end flag
from (select model, price from pc 
  union all  
  select model, price from printer
  union all 
  select model, price from laptop) as t
  
  select *
  from all_products_flag_300
  

--task2  (lesson4)
-- ������������ �����: ������� view (�������� all_products_flag_avg_price) 
-- ��� ���� ������� (pc, printer, laptop) � ������, ���� ��������� ������ c������. 
-- �� view ��� �������: model, price, flag
  
  create view all_products_flag_avg_price as
select model, price,
case when price> (select avg (t1.price)
  from (select model, price  from pc 
  union all  
  select model, price from printer
  union all 
  select model, price  from laptop) as t1
left join (
  select model, maker
  from product 
) as t2
on t1.model = t2.model) then 1
else 0
end flag
from (select model, price from pc 
  union all  
  select model, price from printer
  union all 
  select model, price from laptop) as t
  
  select *
  from all_products_flag_avg_price
  
--task3  (lesson4)
-- ������������ �����: ������� ��� �������� ������������� = 'A' 
-- �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
  
  select printer.model
  from printer
  join product on product.model=printer.model
  where price>
  (select avg (price) from printer join product on product.model=printer.model 
  where maker='D' or maker='C')
  and maker='A'

--task4 (lesson4)
-- ������������ �����: ������� ��� ������ ������������� = 'A' 
-- �� ���������� ���� ������� �� ��������� ������������� = 'D' � 'C'. ������� model
  
select t1.model, maker, price
from (select model, price  from pc 
  union all  
  select model, price from printer
  union all 
  select model, price  from laptop) as t1
left join (
  select model, maker
  from product 
) as t2
on t1.model = t2.model
where t1.price>
  (select avg (price) from printer join product on product.model=printer.model 
  where maker='D' or maker='C')
  and maker='A'
  
--task5 (lesson4)
-- ������������ �����: ����� ������� ���� ����� ���������� ��������� ������������� = 'A' (printer & laptop & pc)
  
  select avg (t1.price)
  from (select model, price  from pc 
  union all  
  select model, price from printer
  union all 
  select model, price  from laptop) as t1
left join (
  select model, maker
  from product 
) as t2
on t1.model = t2.model
  where maker='A'
 
--task6 (lesson4)
-- ������������ �����: ������� view � ����������� ������� (�������� count_products_by_makers) 
-- �� ������� �������������. �� view: maker, count
  
  create view count_products_by_makers as
  select maker, count (model) as count
  from product
  group by maker
  
  select *
  from count_products_by_makers
  order by maker

--task7 (lesson4)
-- �� ����������� view (count_products_by_makers) ������� ������ � colab (X: maker, y: count)

--task8 (lesson4)
-- ������������ �����: ������� ����� ������� printer (�������� printer_updated) 
-- � ������� �� ��� ��� �������� ������������� 'D'
  
create table printer_updated as
select *
from printer

select *
from printer_updated
join product on printer_updated.model=product.model
where maker!='D'

--task9 (lesson4)
-- ������������ �����: ������� �� ���� ������� (printer_updated) view � �������������� 
-- �������� ������������� (�������� printer_updated_with_makers)

create view printer_updated_with_makers as 
select code, printer_updated.model, color, printer_updated.type, price, maker
from printer_updated
join product on printer_updated.model = product.model

select *
from printer_updated_with_makers


--task10 (lesson4)
-- �������: ������� view c ����������� ����������� �������� � ������� ������� (�������� sunk_ships_by_classes).
-- �� view: count, class (���� �������� ������ ���/IS NULL, �� �������� �� 0)

create view sunk_ships_by_classes as
select class, count (name)
from ships
join outcomes on outcomes.ship=ships.name
where result='sunk'
group by class

select *
from sunk_ships_by_classes

--task11 (lesson4)
-- �������: �� ����������� view (sunk_ships_by_classes) ������� ������ � colab (X: class, Y: count)

--task12 (lesson4)
-- �������: ������� ����� ������� classes (�������� classes_with_flag) � �������� � ��� flag: ���� ���������� 
-- ������ ������ ��� ����� 9 - �� 1, ����� 0
create table classes_with_flag as
select *,
case when numguns>=9 then 1 else 0
end flag
from classes

select *
from classes_with_flag

--task13 (lesson4)
-- �������: ������� ������ � colab �� ������� classes � ����������� ������� �� ������� (X: country, Y: count)

select country, count (class) as f
from classes 
group by country
order by f

--task14 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ���������� � ����� "O" ��� "M".
select count (name)
from ships 
where name like 'O%' or name like 'M%'

--task15 (lesson4)
-- �������: ������� ���������� ��������, � ������� �������� ������� �� ���� ����.
select count (name)
from ships 
where name like '% %'

--task16 (lesson4)
-- �������: ��������� ������ � ����������� ���������� �� ���� �������� � ����� ������� (X: year, Y: count)
select launched, count (name) as f
from ships
group by launched
order by launched
