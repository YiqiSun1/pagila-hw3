/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies that share at least 1 actor with 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */
SELECT f.title
FROM film f
JOIN film_actor fa1 ON f.film_id = fa1.film_id
JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
JOIN film ac ON fa2.film_id = ac.film_id
WHERE ac.title = 'AMERICAN CIRCUS'
ORDER BY f.title;
