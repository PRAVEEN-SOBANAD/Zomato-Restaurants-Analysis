#group 3 Atharv~
 
#ALTER TABLE main ADD COLUMN cuisines2 VARCHAR(25);
#UPDATE main
#SET cuisines2 = SUBSTRING_INDEX(cuisines, ',', 1);


#Number of Restaurents based on City (1)
select city, count(restaurantname) as "No. of Restaurants" from main
group by city;


#Number of Restaurents based on Country (2)
SELECT c.countryname, COUNT(m.restaurantname) AS "No. of Restaurants" 
FROM main m 
INNER JOIN country c 
ON m.CountryCode = c.countryid
GROUP BY c.countryname;


#No. of restaurants opening based on Year, Quarter and Month (3,4,5)
SELECT year(d.date) as "year",count(m.restaurantname) AS "No. of Restaurants" 
FROM main m 
INNER JOIN date d
ON m.Datekey_Opening = d.DateKey
GROUP BY year(d.date)
order by 1 asc;

select Quarter(d.date) as "Quarter", count(m.restaurantname) AS "No. of Restaurants" 
FROM main m 
INNER JOIN date d
ON m.Datekey_Opening = d.DateKey
GROUP BY Quarter(d.date)
order by 1 asc;

SELECT  d.Monthname ,month(d.date) as "Month", count(m.restaurantname) AS "No. of Restaurants" 
FROM main m 
INNER JOIN date d
ON m.Datekey_Opening = d.DateKey
GROUP BY month(d.date)
order by 2 asc;

#count of restaurants based on average rating (6)
select Rating, count(RestaurantName) as `Count. of Restauants` from main 
group by Rating
order by 1;

#Create buckets based on Average Price of reasonable size and find out how many resturants falls in each buckets (7)
SELECT 
CASE 
	WHEN Average_cost_for_two <= 100 THEN '0-100'
	WHEN Average_cost_for_two <= 200 THEN '101-200'
	WHEN Average_cost_for_two <= 300 THEN '201-300'
	WHEN Average_cost_for_two <= 400 THEN '301-400'
	WHEN Average_cost_for_two <= 500 THEN '401-500'
	ELSE '501+'
    END AS Cost_Range,
    COUNT(restaurantname) AS "No. of Restaurants"
FROM main
GROUP BY 1
ORDER BY Average_cost_for_two;

#Percentage of Resturants based on "Has_Table_booking" (8)
select has_table_booking,
count(*) as totalrestaurants,
round(  (COUNT(*)/(select COUNT(*) from main)  ) *100,2) as percentage
from main
group by Has_Table_booking;

#Percentage of Resturants based on "Has_Online_delivery" (9)
select Has_Online_delivery,
count(*) as totalrestaurants,
round(  (COUNT(*)/(select COUNT(*) from main)   ) *100,2) as percentage
from main
group by Has_Online_delivery;

#No. of restaurants with Rating-Range (10)
SELECT 
CASE 
	WHEN rating < 1 THEN '0-1'
	WHEN rating < 2 THEN '1-2'
	WHEN rating < 3 THEN '2-3'
	WHEN rating < 4 THEN '3-4'
	WHEN rating < 5 THEN '4-5'
	ELSE '5+'
END AS Rating_Range,
count(*) as "No.of Restaurants"
FROM main
group by 1
order by Rating;
 

#No. of Restaurants based on Cuisines (11)
select distinct cuisines2 as "cuisines", count(*) as "No. of Restaurants" from main
group by 1;


#No of cuisines based on bucket rating range (12)
SELECT distinct cuisines2 as "cuisines",
CASE 
	WHEN rating < 1 THEN '0-1'
	WHEN rating < 2 THEN '1-2'
	WHEN rating < 3 THEN '2-3'
	WHEN rating < 4 THEN '3-4'
	WHEN rating < 5 THEN '4-5'
	ELSE '5+'
END AS Rating_Range,
    count(Cuisines2) as "No.of cuisines"
FROM main
group by 1
order by Rating;