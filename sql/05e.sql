/* 
 * You've decided that you don't actually like ACADEMY DINOSAUR and AGENT TRUMAN,
 * and want to focus on more movies that are similar to AMERICAN CIRCUS.
 * This time, however, you don't want to focus only on movies with similar actors.
 * You want to consider instead movies that have similar categories.
 *
 * Write a SQL query that lists all of the movies that share 2 categories with AMERICAN CIRCUS.
 * Order the results alphabetically.
 *
 * NOTE:
 * Recall that the following query lists the categories for the movie AMERICAN CIRCUS:
 * ```
 * SELECT name
 * FROM category
 * JOIN film_category USING (category_id)
 * JOIN film USING (film_id)
 * WHERE title = 'AMERICAN CIRCUS';
 * ```
 * This problem should be solved by a self join on the "film_category" table.
 */
SELECT DISTINCT f1.title
FROM film f1
JOIN film_category fc1 ON f1.film_id = fc1.film_id
WHERE fc1.category_id IN (
    SELECT fc2.category_id
    FROM film f2
    JOIN film_category fc2 ON f2.film_id = fc2.film_id
    WHERE f2.title = 'AMERICAN CIRCUS'
)
GROUP BY f1.film_id, f1.title
HAVING COUNT(DISTINCT fc1.category_id) >= 2
ORDER BY f1.title;
