/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
WITH film_revenue AS (
  SELECT
    i.film_id,
    SUM(p.amount) AS revenue
  FROM payment p
  JOIN rental r ON p.rental_id = r.rental_id
  JOIN inventory i ON r.inventory_id = i.inventory_id
  GROUP BY i.film_id
),
actor_film_revenue AS (
  SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    f.film_id,
    f.title,
    fr.revenue
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  JOIN film f ON fa.film_id = f.film_id
  JOIN film_revenue fr ON f.film_id = fr.film_id
),
top_films_per_actor AS (
  SELECT
    actor_id,
    first_name,
    last_name,
    film_id,
    title,
    ROW_NUMBER() OVER (PARTITION BY actor_id ORDER BY revenue DESC, film_id) AS rank,
    revenue
  FROM actor_film_revenue
)
SELECT * FROM top_films_per_actor
WHERE rank <= 3
ORDER BY actor_id, rank;
