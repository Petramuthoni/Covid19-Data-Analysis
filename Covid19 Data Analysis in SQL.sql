
select Location,date,total_cases,new_cases,total_deaths,population_density from PortfolioProject..CovidDeaths order by 1,2

--Getting the Covid DeathPercentage

select Location,date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercetageRate from PortfolioProject..CovidDeaths where Location like '%kenya%'order by 1,2

--Getting the covid positive population percentage rate in kenya

select Location,date,total_cases,total_deaths,population_density,(total_cases/population_density)*100 as covidpositivepopulationpercentage from PortfolioProject..CovidDeaths where Location like '%kenya%' order by 1,2

--countries with the highest infection rate with respect to population density

select Location,population_density,MAX(total_cases) as highestinfectioncount,MAX((total_cases/population_density))*100 as highestpopulationinfectionpercentagecount from PortfolioProject..CovidDeaths where continent is not NULL group by Location,population_density order by highestpopulationinfectionpercentagecount desc

--countries with highest death count
select location ,Max(cast(total_deaths as int)) as DeathCount from PortfolioProject..CovidDeaths where continent is not NULL group by Location order by DeathCount desc

--continents with highest death count
select continent ,Max(cast(total_deaths as int)) as DeathCount from PortfolioProject..CovidDeaths where continent is not NULL  group by continent order by DeathCount desc

--getting total cases,total death cases and deathpercentage
select date,Sum(new_cases) as totalcases,Sum(cast(total_deaths as int)) as totaldeaths,(Sum(cast(total_deaths as int))/Sum(new_cases))*100 as deathpercentagecount from PortfolioProject..CovidDeaths where continent is not null group by date order by 1,2
--vaccination table
select * from PortfolioProject..CovidVaccinations
--Joining coviddeaths table with covidvaccinations table on location and date columns
select * from PortfolioProject..CovidDeaths deaths
Join PortfolioProject..CovidVaccinations vaccinations
 On deaths.Location=vaccinations.Location
 And deaths.date=vaccinations.date

 --showing polulation density of contries and number of vaccinations
 select deaths.continent,deaths.Location,
 deaths.date,deaths.population_density,vaccinations.new_vaccinations 
 from PortfolioProject..CovidDeaths deaths
 Join PortfolioProject..CovidVaccinations vaccinations
 on deaths.date=vaccinations.date
 and deaths.Location=vaccinations.location
 where deaths.continent is not null 
 order by 2,3

 --showing total number of vaccinations vs populations 
 select deaths.continent,deaths.Location,
 deaths.date,deaths.population_density,
 vaccinations.new_vaccinations,Sum(cast(vaccinations.new_vaccinations as float)) OVER
 (Partition by deaths.Location order by deaths.Location,deaths.date) as Total_new_Vaccinations
 from PortfolioProject..CovidDeaths deaths
 Join PortfolioProject..CovidVaccinations vaccinations
 on deaths.Location=vaccinations.Location
 and deaths.date=vaccinations.date
 where deaths.continent is not null 
 order by 2,3



