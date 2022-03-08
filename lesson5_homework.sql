--����� ��: https://docs.google.com/document/d/1NVORWgdwlKepKq_b8SPRaSpraltxoMg2SIusTEN6mEQ/edit?usp=sharing
--colab/jupyter: https://colab.research.google.com/drive/1j4XdGIU__NYPVpv74vQa9HUOAkxsgUez?usp=sharing

--task1 (lesson5)
-- ������������ �����: ������� view (pages_all_products), 
-- � ������� ����� ������������ �������� ���� ��������� (�� ����� ���� ��������� �� ����� ��������). 
-- �����: ��� ������ �� laptop, ����� ��������, ������ ���� �������

sample:
1 1
2 1
1 2
2 2
1 3
2 3

create view pages_all_products as
select *, (row_num+1) % 2 + 1 as r1, floor((row_num + 1)/2) as r2
from (select *, row_number() over() row_num
from laptop) t

select *
from pages_all_products

--task2 (lesson5)
-- ������������ �����: ������� view (distribution_by_type), � ������ �������� ����� 
-- ���������� ����������� ���� ������� �� ���� ����������. 
-- �����: �������������, ���, ������� (%)

create view distribution_by_type as
select maker, type, count(*)*100/sum(count(*)) over() as percentage
from product
group by maker, type

select *
from distribution_by_type 
order by maker

--task3 (lesson5)
-- ������������ �����: ������� �� ���� ����������� view ������ - �������� ���������. ������ https://plotly.com/python/histograms/

--task4 (lesson5)
-- �������: ������� ����� ������� ships (ships_two_words), �� �������� ������� ������ �������� �� ���� ����

create table ships_two_words as
select * from ships
where name like '% %'

select *
from ships_two_words

--task5 (lesson5)
-- �������: ������� ������ ��������, � ������� class ����������� (IS NULL) � �������� ���������� � ����� "S"

select name
from ships s
join outcomes o on s.name=o.ship
left join classes c on c.class=s.class
where (c.class is null) and (name like 'S%')

--task6 (lesson5)
-- ������������ �����: ������� ��� �������� ������������� = 'A' �� ���������� ���� ������� �� ��������� ������������� = 'C' 
-- � ��� ����� ������� (����� ������� �������). ������� model

select printer.model
from printer 
join product on printer.model=product.model 
where maker='A' and price>(
select avg (price) from printer 
join product on printer.model=product.model 
where maker='C')


