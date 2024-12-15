--- Medals table - Top performing countries
SELECT Country, SUM(Gold) as GoldM, SUM(Silver) as SilverM, SUM(Bronze) as BronzeM,
(SUM(Gold) * 3 + SUM(Silver) * 2 + SUM(Bronze) * 1) AS Score
FROM medals
GROUP BY Country
ORDER BY Score DESC;

--- Top discipline from each country
WITH discipline_county AS (SELECT Country, Discipline, COUNT(*) as n
FROM athelete
GROUP by Country,Discipline),

ranked_discipline AS (SELECT Country,Discipline,n,ROW_NUMBER() OVER (PARTITION BY Country ORDER BY n DESC) AS Rank 
FROM discipline_county)
SELECT Country,Discipline
FROM ranked_discipline
WHERE Rank=1;

--- Number of athelete from each country
SELECT Country, APPROX_COUNT_DISTINCT(Name) as N
FROM athelete
GROUP BY Country
ORDER BY N DESC; 

--- Number of athelete in each discipline
SELECT Discipline, APPROX_COUNT_DISTINCT(Name) as N
FROM athelete
GROUP BY Discipline
ORDER BY N DESC;

--- SCORE of a country (Normalised_Rank * Normalised_Participation)
WITH n_athlete AS (
    SELECT 
        Country, 
        COUNT(DISTINCT Name) AS Number_of_athletes
    FROM 
        athelete
    GROUP BY 
        Country
),
rank_n AS (
    SELECT 
        medals.Country, 
        RANK() OVER (ORDER BY (3 * SUM(Gold) + 2 * SUM(Silver) + SUM(Bronze)) DESC) AS Rank,
        n_athlete.Number_of_athletes
    FROM 
        medals
    JOIN 
        n_athlete 
    ON 
        n_athlete.Country = medals.Country
    GROUP BY 
        medals.Country, n_athlete.Number_of_athletes
),
aggregates AS (
    SELECT 
        MAX(Rank) AS Max_Rank, 
        MIN(Rank) AS Min_Rank, 
        MAX(Number_of_athletes) AS Max_Athletes, 
        MIN(Number_of_athletes) AS Min_Athletes
    FROM 
        rank_n
)
SELECT 
    rank_n.Country AS Country,
    ROUND((CAST(rank_n.Rank AS FLOAT) - (SELECT Min_Rank FROM aggregates)) / 
    ((SELECT Max_Rank FROM aggregates) - (SELECT Min_Rank FROM aggregates)) + 1,2) AS Normalized_Rank,
    ROUND((CAST(rank_n.Number_of_athletes AS FLOAT) - (SELECT Min_Athletes FROM aggregates)) / 
    ((SELECT Max_Athletes FROM aggregates) - (SELECT Min_Athletes FROM aggregates)) + 1,2) AS Normalized_Participation,
    ROUND(((CAST(rank_n.Rank AS FLOAT) - (SELECT Min_Rank FROM aggregates)) / 
    ((SELECT Max_Rank FROM aggregates) - (SELECT Min_Rank FROM aggregates)) + 1) * 
    ((CAST(rank_n.Number_of_athletes AS FLOAT) - (SELECT Min_Athletes FROM aggregates)) / 
    ((SELECT Max_Athletes FROM aggregates) - (SELECT Min_Athletes FROM aggregates)) + 1),2) AS Score
FROM 
    rank_n
ORDER BY 
    Score;


 
