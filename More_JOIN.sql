-- 1.
-- List the films where the yr is 1962 and the budget is over 2000000 [Show id, title]
SELECT id, title
 FROM movie
 WHERE yr=1962 and budget >2000000;

-- 2.
-- Give year of 'Citizen Kane'.
select yr from movie where title ='Citizen Kane';

-- 3.
-- List all of the Star Trek movies, include the id, title and yr (all of these movies start with the words Star Trek in the title). Order results by year.
select id, title, yr from movie where title like 'Star Trek%' order by yr;

-- 4.
-- What id number does the actor 'Glenn Close' have?
select id from actor where name='Glenn Close';

-- 5.
-- What is the id of the 1942 film 'Casablanca'
select id from movie where yr=1942 and title='Casablanca'

-- 6.
-- Obtain the cast list for 1942's 'Casablanca'.
select name from actor,casting,movie where 
movie.id=movieid 
and actor.id = actorid
and movieid=132689

-- 7.
-- Obtain the cast list for the film 'Alien'
select name from actor,casting,movie where 
movie.id=movieid 
and actor.id = actorid
and title='Alien'

-- 8.
-- List the films in which 'Harrison Ford' has appeared
select title from movie join casting on movie.id = movieid 
join actor on actor.id = actorid
where actor.name='Harrison Ford'

-- 9.
-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
select title from movie join casting on movie.id = movieid join actor on actor.id = actorid 
where actor.name='Harrison Ford' and ord!=1;

-- 10.
-- List the films together with the leading star for all 1962 films.
select title, name from movie,actor,casting 
where movie.id=movieid
and actor.id = actorid
and yr=1962
and ord=1;

-- 11.
-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
select yr, count(*) as 'number of movies' from movie join casting on movie.id=movieid join actor on actor.id =actorid 
where actor.name = 'Rock Hudson'
group by yr
having count(*)>2 

-- 12.
-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.
select title, name from movie join casting on movie.id = movieid join actor on actor.id = actorid where movie.id in(select distinct movie.id from movie,casting,actor 
where movie.id=movieid
and actor.id =actorid
and actor.name='Julie Andrews')
and ord=1

-- 13.
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.
select distinct actor.name from actor,casting where actor.id=actorid and actor.id in(select actorid from casting where ord=1 group by actorid having count(*)>=15)

-- 14.
-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
select title, count(actorid) from movie join casting on movie.id = movieid where yr in (select yr from movie where yr=1978) group by title  order by 2 desc,1

-- 15.
-- List all the people who have worked with 'Art Garfunkel'.
select distinct name from actor join casting on actor.id = actorid  where movieid in(select movieid from casting join actor on actorid = actor.id where name='Art Garfunkel') and actor.name!='Art Garfunkel'

