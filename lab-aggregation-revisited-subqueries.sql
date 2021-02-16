-- Lab | Aggregation Revisited - Sub queries
-- In this lab, you will be using the Sakila database of movie rentals. 
-- You have been using this database for a couple labs already, 
-- but if you need to get the data again, refer to the official installation link.

-- Instructions
-- Write the SQL queries to answer the following questions:
use sakila; 

-- Select the first name, last name, and email address of all the customers who have rented a movie.
select first_name, last_name, email from customer
right join rental 
using (customer_id)
group by customer_id;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), 
-- and the average payment made).
select concat(l.first_name, ' ', l.last_name) as 'customer name', round(avg(amount),2) as 'average payment', customer_id from payment p
join customer l
using (customer_id)
group by customer_id;

-- Select the name and email address of all the customers who have rented the "Action" movies.

-- Write the query using sub queries with multiple WHERE clause and IN condition
select first_name, last_name, email from customer 
where customer_id in(
select customer_id from rental 
where inventory_id in(
select inventory_id from inventory
where film_id in (
select film_id from film_category
where category_id in (
select category_id from category
where name = 'Action'))))
GROUP BY customer_id
order by customer_id;

-- Write the query using multiple join statements
select first_name, last_name, email from customer 
join rental
using ( customer_id )
join inventory
using ( inventory_id)
join film_category
using (film_id)
join category
using (category_id)
where name = 'Action'
group by customer_id;

-- Verify if the above two queries produce the same results or not
-- Yes the answers are the same!

-- Use the case statement to create a new column classifying existing columns as either or high value transactions 
-- based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, 
-- the label should be medium, and if it is more than 4, then it should be high.
SELECT *,
CASE
    WHEN amount <= 2 THEN "low"
    WHEN amount <= 4 THEN "medium"
    ELSE "high"
END as 'transaction_value'
FROM payment
order by amount ASC;
