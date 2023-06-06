use sakila;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length, rank() over (order by length desc) 
as 'Rank'
from film;

-- or
SELECT title, length, RANK() OVER (ORDER BY length) AS 'Rank'
FROM film
WHERE length IS NOT NULL AND length > 0;

-- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, RANK() OVER (PARTITION BY rating ORDER BY length desc) 
AS 'Rank'
FROM film;

-- 3. How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT c.nme, COUNT(*) AS film_count
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- 4. Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) AS film_count
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT a.customer_id, a.first_name, a.last_name, COUNT(*) AS rental_count
FROM customer a
JOIN rental r ON a.customer_id = r.customer_id
GROUP BY a.customer_id, a.first_name, a.last_name
ORDER BY rental_count DESC
LIMIT 1;

--  6. Bonus: Which is the most rented film? (The answer is Bucket Brotherhood).
SELECT f.film_id, f.title, COUNT(*) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 1;
