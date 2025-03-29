/*
 * Compute the country with the most customers in it. 
 */

SELECT country country
FROM (
	SELECT country country, count(DISTINCT(customer_id)) num 
	FROM customer c
 	JOIN address a ON c.address_id = a.address_id
	JOIN city ON a.city_id = city.city_id
	JOIN country ON city.country_id = country.country_id
	GROUP BY country
	ORDER BY num DESC
	LIMIT 1

) AS customer_count
;

