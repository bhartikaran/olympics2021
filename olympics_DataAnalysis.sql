--- Count athelete from each country
SELECT Country, Count(*) as No_of_athelete
FROM athelete
Group BY Country
ORDER by No_of_athelete DESC;

--- Calculate rank of each country
SELECT 
    Country, Gold, Silver, Bronze, Total,
    RANK() OVER (ORDER BY Total DESC) AS Rank_by_Total
FROM 
    medals;
----

