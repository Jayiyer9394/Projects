
Select *
From ['UserCarData];

--Total Cars Sold Annually (1) 
select year, sum(Sales_ID) as TotalCarSale
from ['UserCarData]
group by year
order by year;

--Average Price of Vehicle per Region (2) --TABLEAU
select Region, AVG(selling_price_usd) as AverageCarPriceperRegion
from ['UserCarData]
group by Region
order by AverageCarPriceperRegion desc;

--Average Mileage per State and City of Cars Sold (3)
Select dbo.['UserCarData].State_Province, dbo.['UserCarData].City, ROUND(AVG(dbo.UserCarDatacardetails_mileageto.mileage_mi),2) as AverageMileageperState
from dbo.['UserCarData]
inner join dbo.UserCarDatacardetails_mileageto
on dbo.['UserCarData].Sales_ID = dbo.UserCarDatacardetails_mileageto.Sales_ID
where sold = 'Y'
group by State_Province, City
order by State_Province;

--Average Mileage per State of Cars Sold (3) --TABLEAU
Select dbo.['UserCarData].State_Province, ROUND(AVG(dbo.UserCarDatacardetails_mileageto.mileage_mi),2) as AverageMileageperState
from dbo.['UserCarData]
inner join dbo.UserCarDatacardetails_mileageto
on dbo.['UserCarData].Sales_ID = dbo.UserCarDatacardetails_mileageto.Sales_ID
where sold = 'Y'
group by State_Province
order by State_Province;

-- Highest Number of Sold Cars by Model (4) --TABLEAU
select top 5 
	count(Sales_ID) as CountofSoldCars, name
from ['UserCarData]
group by name
order by CountofSoldCars desc;

--Most common fuel type of the top car model in the South region (4) --TABLEAU
select count(b.fuel) as CountofFuelTypes, fuel
from ['UserCarData] a
inner join UserCarDatacardetails_mileageto b
on a.Sales_ID = b.Sales_ID
where Region = 'South' and name = 'Maruti'
group by fuel
order by CountofFuelTypes desc;

--Average selling price of different seat numbers for Maruti w/ mileage under 20000 (5)
select b.year, a.seats, AVG(b.selling_price_usd) as AverageSellingPrice
from dbo.UserCarDatacardetails_mileageto a
join dbo.['UserCarData] b
on a.Sales_ID = b.Sales_ID
where mileage_mi < 20000 and name = 'Maruti'
group by seats, year
order by year, seats;

--Average price for used cars in each state (6)
select State_Province, AVG(selling_price_usd) as AverageSellingPrice, year
from dbo.['UserCarData]
where year >= 2010
group by State_Province, year
order by State_Province, year;

select State_Province, AVG(selling_price_usd) as AverageSellingPrice  --TABLEAU
from dbo.['UserCarData]
group by State_Province
order by State_Province;

--Most popular model of car (based on mileage) grouped by region (per region find car with highest mileage) (7)
select a.name, ROUND(MAX(a.mi_driven_convert), 2) as MaxMilesDriven, a.Region
from dbo.['UserCarData] a
join dbo.UserCarDatacardetails_mileageto b
on a.Sales_ID = b.Sales_ID
group by name, Region
order by name, MaxMilesDriven Desc;

--Total prices per region (8) --TABLEAU
select region, ROUND(SUM(selling_price_usd), 2) as TotalSalePrices 
from dbo.['UserCarData]
group by Region
order by TotalSalePrices desc;

--Total revenue for cars in Central region by year grouped by model (9)
select year,name, ROUND(SUM(selling_price_usd),2) as TotalSellingPrice
from dbo.['UserCarData]
where region = 'Central'
group by year, name
order by year, name;

--Total Sales in South Region by year (9) --TABLEAU
select year, ROUND(SUM(selling_price_usd),2) as TotalSellingPrice
from dbo.['UserCarData]
where region = 'South'
group by year
order by year;

--Count of Sold cars in each city by year with under 50000 miles, top 10 (10)
select top 10 COUNT(a.Sales_ID) as NumberofSoldCars, a.city
from dbo.['UserCarData] a
join dbo.UserCarDatacardetails_mileageto b
on a.Sales_ID = b.Sales_ID
where mileage_mi <= 50000 and sold = 'Y'
group by city
order by NumberofSoldCars desc;

--Number of Cars sold for <10K, 10-20K, and >20K in 2020 (11)
select COUNT(Sales_ID)
from dbo.['UserCarData]
where year = 2020 and mi_driven_convert > 20000;

select COUNT(Sales_ID)
from dbo.['UserCarData]
where year = 2020 and mi_driven_convert between 10000 and 20000;

select COUNT(Sales_ID)
from dbo.['UserCarData]
where year = 2020 and mi_driven_convert < 10000;

select COUNT(Sales_ID)
from dbo.['UserCarData]
where year = 2020 and mi_driven_convert < 10000
or mi_driven_convert between 10000 and 20000
or mi_driven_convert > 20000;

select 
	COUNT(case when year = 2020 and mi_driven_convert < 10000 then 'Under 10000')
	COUNT(case when year = 2020 and mi_driven_convert between 10000 and 20000 then '10000-20000')
	COUNT(case when year = 2020 and mi_driven_convert > 20000 then 'Over 20000')
from dbo.['UserCarData];

--Total number of cars sold by make in 2017 (12) choose 2017 bc of Q1 --TABLEAU
select State_Province, COUNT(name) as NumberofCarsSold
from dbo.['UserCarData]
where year = 2017
group by State_Province
order by NumberofCarsSold desc;

--Total number of cars sold by fuel type in 2017 (13) --TABLEAU
select a.fuel, count(a.Sales_ID) as CountofCars
from dbo.UserCarDatacardetails_mileageto a
join dbo.['UserCarData] b
on a.Sales_ID = b.Sales_ID
where year = 2017
group by fuel
order by CountofCars desc;

--Find count of cars sold and group by make (find the top 5 cars makes that have been sold) (14) --TABLEAU
select top 5 name, count(Sales_ID) as CountofCars
from dbo.['UserCarData]
group by name
order by CountofCars desc;

--Total of cars sold and group by year (15) --TABLEAU
select top 5 count(Sales_ID) as CountofCarSold, year
from dbo.['UserCarData]
group by year
order by CountofCarSold desc;

--Find count of cars not sold and group by year and make, order by desc, limit 5 (16) --TABLEAU
select top 5 count(b.sold) as CountofNotSoldCars, a.name
from dbo.['UserCarData] a
join dbo.UserCarDatacardetails_mileageto b
on a.Sales_ID = b.Sales_ID
where sold = 'N'
group by name
order by CountofNotSoldCars desc; 

--Categorize the horsepower as low, average, medium, high in a new column called HP Ratings (case statement) (17)
select b.name, a.engine_liters, a.max_power_horsepower,
		 case when max_power_horsepower < 90 then 'Low'
		 when max_power_horsepower between 90 and 150 then 'Average'
		 when max_power_horsepower between 150 and 250 then 'High'
		 else 'Super High!' 
		 end as HPRatings
from dbo.UserCarDatacardetails_mileageto a
inner join dbo.['UserCarData] b
on a.Sales_ID = b.Sales_ID
where sold = 'Y'
order by max_power_horsepower; 


