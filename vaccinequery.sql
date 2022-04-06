SELECT 
	tmp.country,
    avg(tmp.daily_vaccinations) as average
FROM (
  SELECT 
      country,
      date,
      IFNULL(daily_vaccinations, (SELECT IFNULL(AVG(daily_vaccinations), 0) FROM country_vaccination_stats AS c WHERE c.country = country_vaccination_stats.country AND c.daily_vaccinations IS NOT NULL)) AS daily_vaccinations,
      vaccines
  FROM 
      country_vaccination_stats
) as tmp
GROUP BY
	tmp.country
ORDER BY average DESC limit 3;