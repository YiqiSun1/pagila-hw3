/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */
SELECT f2.title
FROM film_actor fa
JOIN film f USING (film_id)
JOIN film_actor fa2 USING (actor_id)
JOIN film f2 ON fa2.film_id = f2.film_id
WHERE f.title IN('AMERICAN CIRCUS', 'ACADEMY DINOSAUR', 'AGENT TRUMAN')
GROUP BY f2.film_id, f2.title
HAVING COUNT(fa.actor_id) >= 3
ORDER BY f2.title;
