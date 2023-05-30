use sakila;

select * from film;
#select * from film_category;
#select * from category; 
#select * from rental;
#select * from customer;


#1. 영화 대여 이력이 가장 많은 3명의 고객에 대해, 고객 이름, 이메일, 대여 횟수를 출력하세요.

-- SELECT customer_id, last_name, email, count(inventory_id) as c
-- FROM customer
-- JOIN rental ON customer.customer_id = rental.customer_id
-- GROUP BY customer_id, last_name, email
-- ORDER BY c DESC;

#2. "Comedy" 장르에 속한 영화의 평점 평균이 4점 이상이고, 2005년 이후에 발행된 영화 중에서, 평점이 가장 높은 5편의 영화 제목과, 평균평점을 출력하세요.
#rental_rate

select title ,avg(rental_rate) 
from film as f
join film_category as fc on f.film_id = fc.film_id 
left join category as c on fc.category_id = c.category_id
where name = 'Comedy' and release_year >= 2005  
group by title
order by avg(rental_rate) desc
limit 5;


#3. 2006년 이후에 가장 많이 대여된 3개 영화의 제목과 대여 횟수를 출력하세요.
select title, count(inventory_id)
from film 
join inventory on film.film_id = inventory.film_id
where release_year >= 2006
group by title
order by count(inventory_id)
limit 3;


#4. 2006년 이전에 발행된 영화 중에서, 대여한 횟수가 가장 많은 영화의 제목과 대여 횟수를 출력하세요. (inventory 활용)
select title, count(inventory_id)
from film 
join inventory on film.film_id = inventory.film_id
where release_year >= 2006
group by title
order by count(inventory_id)
limit 1;

#5. 영화 대여 횟수가 가장 많은 고객 3명의 이름, 이메일, 대여 횟수를 출력하세요.
select last_name, email, count(inventory_id)
from film 
join inventory on film.film_id = inventory.film_id
join customer on inventory.store_id = customer.store_id
group by last_name, email
order by count(inventory_id)
limit 3;

#6. "Documentary"와 "Music" 장르에 해당되는 영화 중에서, 2005년 이후에 발행된 영화 제목과 발행 연도, 장르명을 출력하세요.
select *
from film;

#7. "Comedy" 장르에 해당되는 영화 중에서, 대여 횟수가 가장 많은 영화 제목과 대여 횟수를 출력하세요.