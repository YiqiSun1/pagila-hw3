/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */
SELECT f.title
FROM film f
WHERE f.film_id IN (
    SELECT fa.film_id FROM film_actor fa
    WHERE fa.actor_id IN (
        SELECT actor_id FROM film_actor
        WHERE film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
    )
)
INTERSECT
SELECT f.title
FROM film f
WHERE f.film_id IN (
    SELECT fa.film_id FROM film_actor fa
    WHERE fa.actor_id IN (
        SELECT actor_id FROM film_actor
        WHERE film_id = (SELECT film_id FROM film WHERE title = 'ACADEMY DINOSAUR')
    )
)
INTERSECT
SELECT f.title
FROM film f
WHERE f.film_id IN (
    SELECT fa.film_id FROM film_actor fa
    WHERE fa.actor_id IN (
        SELECT actor_id FROM film_actor
        WHERE film_id = (SELECT film_id FROM film WHERE title = 'AGENT TRUMAN')
    )
)
AND title NOT IN ('AMERICAN CIRCUS', 'ACADEMY DINOSAUR', 'AGENT TRUMAN')
ORDER BY title;
