1
SELECT name, year 
FROM movies 
WHERE year =1981;   

2
SELECT COUNT(*)as Total
FROM movies
WHERE year =1982;

3
SELECT *
FROM actors 
WHERE last_name like '%stack%';

4
SELECT first_name, last_name,
COUNT(*) as Total
FROM actors
group by lower(last_name), lower(last_name) order by Total desc
limit 10;

5
SELECT a.first_name, a.last_name,COUNT (*) as Total
FROM actors as a
join roles as r on a.id = r.actor_id
group by a.id
order by Total desc
limit 100;

6
select genre,
count(*) as Total 
from movies_genres
group by genre
order by Total;

7
select a.first_name, last_name from actors as a
join roles as r on a.id = r.actor_id
join movies as m on r.movie_id = m.id
where m.name = "Braveheart" and m.year = 1995
order by a.last_name;

8
Leap Noir
Listá todos los directores que dirigieron una película de género 'Film-Noir' 
en un año bisiesto (para reducir la complejidad, asumí que cualquier año divisible por cuatro es bisiesto).
 Tu consulta debería devolver el nombre del director, el nombre de la peli y el año. 
 Todo ordenado por el nombre de la película.


select d.last_name, m.name, m.year
from directors as d
join movies_directors as md on d.id = md.director_id
join movies as m on md.movie_id = m.id
join movies_genres as mg on m.id = mg.movie_id
where mg.genre = 'Film-Noir' AND m.year%4=0
order by m.name;

9
Listá todos los actores que hayan trabajado con Kevin Bacon en películas de Drama 
(incluí el título de la peli). Excluí al señor Bacon de los resultados.

select a.first_name, a.last_name, m.name
from actors as a
join roles as r on a.id = r.actor_id
join movies as m on r.movie_id = m.id
join movies_genres as mg on m.id = mg.movie_id
where mg.genre = 'Drama' 
and m.id IN (
    select  m.id
    from movies as m
    join roles as r on m.id = r.movie_id
    join actors as a on r.actor_id = a.id
    where a.first_name = 'Kevin' and a.last_name = 'Bacon'
)
and (a.first_name || a.last_name != 'KevinBacon');

10

select * from actors
where id in (
    select r.actor_id from roles as r
    join movies as m on r.movie_id = m.id
    where m.year <1900
) and id in (
    select r.actor_id from roles as r
    join movies as m on r.movie_id = m.id
    where m.year >2000
);

11

select a.first_name a.last_name, m.last_name, count (distinct role) as Total
from actors as a 
join roles as r on a.id=r.actor_id
join movies as m on r.movie_id = m.id
where m.year >1990
group by a.id, m.id
having count(distinct role) > 5;

12
select year, count(distinct id) as Total
from movies
where id not in (
    select r.movie_id from roles as r
    join actors as a on r.actor_id = a.id
    where a. gender = 'M'
)
group by year;


