SELECT
    *
FROM
    deaths
WHERE
    continent IS NOT NULL;

SELECT 
    *
FROM
    vaccinations
WHERE
    continent IS NOT NULL;

-- Exploration For percentage of infection and death Based on country and date
SELECT 
-- main columns
   location,
   population,
   date,
   total_cases,
   new_cases,
   total_deaths,
   new_deaths,
   -- chance of infection and death at each recorded date/country
   (new_cases/total_cases)*100 as infection_chance_at_date,
   (new_deaths/total_deaths)*100 as death_chance_at_date, 
   -- chance of infection and death untile given date over whole population
   (total_cases/population)*100 as infection_chance_until_date_per_population,
   (total_deaths/population)*100 as death_chance_untile_date_per_population, 
   -- chance of infection and death at given date over whole population
   (new_cases/population)*100 as infection_chance_at_date_per_population,
   (new_deaths/population)*100 as death_chance_at_date_per_population 
FROM
    deaths
WHERE
    continent IS NOT NULL
order by 1,2 ;

-- Chance of infection and death over whole time
SELECT 
-- main columns
   location,
   population,
   sum(total_cases) as total_infection,
   sum(total_deaths) as total_death,
   -- chance of infection and death untile given date over whole population
   (sum(total_cases)/population )*100 as infection_chance_until_date_per_population,
   (sum(total_deaths)/population)*100 as death_chance_untile_date_per_population
FROM
    deaths
WHERE
    continent IS NOT NULL
group by location, population
order by 1,2 ;

-- high rates of infection and death per location
WITH MaxValues AS (
    SELECT 
        location,
        population,
        MAX(total_cases) AS max_infection,
        MAX(total_deaths) AS max_death
    FROM 
        deaths
    WHERE 
        continent IS NOT NULL 
    GROUP BY 
        location, population
)
SELECT 
    location,
    population,
    max_infection,
    max_death,
    (max_infection / population)*100 AS HighRateInfection,
    (max_death / population)*100 AS HighRateDeath
FROM 
    MaxValues
ORDER BY 
    5 desc;

-- data exploration based on continent
SELECT 
    *
FROM
    deaths
WHERE
    continent IS NULL;

SELECT 
    location,
    SUM(total_cases) AS InfectionCount,
    SUM(total_deaths) AS DeathsCount
FROM
    deaths
WHERE
    continent IS NULL
GROUP BY location;

-- Relationship of icu and hospital patient over golob
SELECT 
    date,
    SUM(new_cases),
    SUM(new_deaths),
    SUM(icu_patients),
    SUM(hosp_patients),
    AVG(reproduction_rate)
FROM
    deaths
GROUP BY date;

select * from vaccinations;
select * from deaths;

SELECT 
    D.location,
    D.date,
    D.new_cases,
    D.new_deaths,
    Vac.new_vaccinations
FROM
    deaths D
        JOIN
    vaccinations Vac ON D.date = Vac.date
        AND D.location = Vac.location;
        
        
        
SELECT DB_NAME() AS DatabaseName, @@SERVERNAME AS ServerName;
