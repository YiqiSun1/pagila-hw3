/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT f.title
FROM film f
WHERE f.film_id IN (
    SELECT fa.film_id
    FROM film_actor fa
    WHERE fa.actor_id IN (
        SELECT fa2.actor_id
        FROM film_actor fa2
        WHERE fa2.film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
    )
)

INTERSECT

-- Films that share at least 2 categories with AMERICAN CIRCUS
SELECT f.title
FROM film f
WHERE (
    SELECT COUNT(*)
    FROM film_category fc
    WHERE fc.film_id = f.film_id
    AND fc.category_id IN (
        SELECT fc2.category_id
        FROM film_category fc2
        WHERE fc2.film_id = (SELECT film_id FROM film WHERE title = 'AMERICAN CIRCUS')
    )
) >= 2
ORDER BY title;
