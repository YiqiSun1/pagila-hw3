/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
WITH russell_bacall AS (
  SELECT actor_id FROM actor WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
),
direct_costars AS (
  SELECT DISTINCT fa1.actor_id
  FROM film_actor fa1
  JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
  JOIN russell_bacall rb ON fa2.actor_id = rb.actor_id
  WHERE fa1.actor_id != rb.actor_id
),
second_degree_costars AS (
  SELECT DISTINCT fa1.actor_id
  FROM film_actor fa1
  JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
  JOIN direct_costars dc ON fa2.actor_id = dc.actor_id
  WHERE fa1.actor_id NOT IN (SELECT actor_id FROM direct_costars)
    AND fa1.actor_id NOT IN (SELECT actor_id FROM russell_bacall)
)
SELECT first_name || ' ' || last_name AS "Actor Name"
FROM actor
JOIN second_degree_costars sdc ON actor.actor_id = sdc.actor_id
ORDER BY "Actor Name";
