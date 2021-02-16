#Select the first name, last name, and email address of all the customers who have rented a movie.

select first_name,last_name,email from customer 
where customer_id in (select distinct(customer_id) from rental
where rental_id >1);

select distinct(customer_id) from rental
where rental_id >1
;

select distinct(c.first_name),c.last_name,c.email from customer as c
right join rental as r
using(customer_id)
;

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select round(avg(amount),2) as average from payment;

select c.customer_id,concat(c.first_name," ",c.last_name), avg(p.amount),
(select round(avg(amount),2) as average from payment)from customer as c
join payment as p 
using(customer_id)
group by c.customer_id;

#Select the name and email address of all the customers who have rented the "Action" movies.

#Write the query using sub queries with multiple WHERE clause and IN condition
select f.film_id from film as f
join film_category as fc
using (film_id)
join category as c
using(category_id)
where c.name in ("action");

select distinct(c.first_name),c.last_name,c.email from customer as c
right join rental as r
using(customer_id)
join inventory as i
using(inventory_id)
where i.film_id in (select f.film_id from film as f
join film_category as fc
using (film_id)
join category as c
using(category_id)
where c.name in ("action"));


#Write the query using multiple join statements
select distinct(customer_id), c.name, concat(cu.first_name,' ', cu.last_name),cu.email from category as c
right join film_category as fc using (category_id)
right join inventory as i using (film_id)
right join rental as r using (inventory_id)
right join customer as cu using(customer_id)
where c.name = 'action';

#Verify if the above two queries produce the same results or not



#Use the case statement to create a new column classifying existing columns as either or high value transactions
# based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

select  payment_id, amount from payment;



select payment_id,amount,
 case 
 When amount <= 2  Then "low" 
 when amount >= 4 then "high"
 else "medium"
 End  classification

from (select  payment_id, amount from payment
  ) sub1
group by payment_id;