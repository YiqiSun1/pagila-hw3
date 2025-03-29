/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT f.title
FROM film f
WHERE (
    SELECT COUNT(DISTINCT fa.actor_id)
    FROM film_actor fa
    WHERE fa.film_id = f.film_id
    AND fa.actor_id IN (
        SELECT actor_id
        FROM film_actor
        WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
    )
) >= 2
ORDER BY f.title;
