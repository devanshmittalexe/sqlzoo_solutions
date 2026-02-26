-- 1.
-- List each country name where the population is larger than that of 'Russia'.

-- world(name, continent, area, population, gdp)
select name from world where population>(select population from world where name='Russia')

-- 2.
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

-- Per Capita GDP
select name from world where continent='Europe' and gdp/population >(select gdp/population from world where name='United Kingdom')

-- 3.

-- List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country.
select name, continent from world where continent in (select continent from world where name in ('Argentina','Australia')) order by name

-- 4.
-- Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.
select name , population from world where population>(select population from world where name='United Kingdom') and population<(select population from world where name='Germany')

-- 5.
-- Germany (population roughly 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

-- Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.

-- The format should be Name, Percentage for example:

-- name	percentage
-- Albania	3%
-- Andorra	0%
-- Austria	11%
-- ...	...
-- Decimal places
-- Percent symbol %
select name ,concat(round(population/(select population from world where name ='Germany')*100),'%') as percentage from world where continent='Europe'

-- 6.
-- Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)
select name from world where gdp>= all(select gdp from world where gdp>0 and continent='Europe') and continent<>'Europe'

-- 7.
-- Find the largest country (by area) in each continent, show the continent, the name and the area:

-- The above example is known as a correlated or synchronized sub-query.

-- Using correlated subqueries
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND population>0)

-- 8.
-- List each continent and the name of the country that comes first alphabetically.
select continent,min(name) from world group by continent

-- 9.
-- Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population.
select name,continent, population from world where continent in(select continent from world group by continent having max(population)<=25000000)

-- 10.
-- Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents.
select name, continent from world a where population> all(select 3*population from world b where a.continent=b.continent and a.name<>b.name)