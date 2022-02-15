-- Задание 1: Вывести name, class по кораблям, выпущенным после 1920
--
select name, class
from ships
where launched>1920

-- Задание 2: Вывести name, class по кораблям, выпущенным после 1920, но не позднее 1942
--
select name, class
from ships
where launched>1920 and launched<=1942

-- Задание 3: Какое количество кораблей в каждом классе. Вывести количество и class
--
select count (name), class
from ships
group by class


-- Задание 4: Для классов кораблей, калибр орудий которых не менее 16, укажите класс и страну. (таблица classes)
--
select class, country
from classes
where bore>=16


-- Задание 5: Укажите корабли, потопленные в сражениях в Северной Атлантике (таблица Outcomes, North Atlantic). Вывод: ship.
--
select ship
from outcomes
where battle='North Atlantic' and result='sunk'


-- Задание 6: Вывести название (ship) последнего потопленного корабля
--
select ship
from outcomes 
join battles on battles.name=outcomes.battle 
where date=(select max(date) from battles join outcomes on battles.name=outcomes.battle where result='sunk')
and result='sunk'


-- Задание 7: Вывести название корабля (ship) и класс (class) последнего потопленного корабля
--
select ship, class
from outcomes 
join battles on battles.name=outcomes.battle
join ships on ships.name=outcomes.ship
where date=(select max(date) from battles join outcomes on battles.name=outcomes.battle where result='sunk')
and class=(select class from ships join outcomes on ships.name=outcomes.ship where result='sunk' )
and result='sunk'


-- Задание 8: Вывести все потопленные корабли, у которых калибр орудий не менее 16, и которые потоплены. Вывод: ship, class
--
select ship, ships.class
from outcomes
join ships on outcomes.ship=ships.name
join classes on classes.class=ships.class
where result='sunk' 
and bore>=16


-- Задание 9: Вывести все классы кораблей, выпущенные США (таблица classes, country = 'USA'). Вывод: class
--
select  distinct ships.class
from ships
join classes
on classes.class=ships.class
where country='USA'

-- Задание 10: Вывести все корабли, выпущенные США (таблица classes & ships, country = 'USA'). Вывод: name, class
-- 
select name, ships.class
from ships
join classes
on classes.class=ships.class
where country='USA'
