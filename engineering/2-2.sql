use sakila;

select * from film;
#select * from film_category;
#select * from category; 
#select * from rental;
#select * from customer;


# 1. 영화 대여 이력이 가장 많은 3명의 고객에 대해, 고객 이름, 이메일, 대여 횟수를 출력하세요.

select * from rental;
select * from customer;
select
	count(rental.customer_id) as rental_count,
    concat(customer.first_name, ' ', customer.last_name) as customer_full_name,
    customer.email
from rental
join customer on rental.customer_id = customer.customer_id
group by rental.customer_id
order by rental_count desc
limit 3;

# 2. "Comedy" 장르에 속한 영화의 평점 평균이 4점 이상이고, 2005년 이후에 발행된 영화 중에서,
# 평점이 가장 높은 5편의 영화 제목과, 평균평점을 출력하세요.

select * from film;
select * from category;
select * from film_category;
select film.title, film.rental_rate
from film
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where film.rental_rate >= 4
  and film.release_year > 2005
  and category.name = 'Comedy'
order by film.rental_rate;

# 3. 2006년 이후에 가장 많이 대여된 3개 영화의 제목과 대여 횟수를 출력하세요.

select * from rental;
select * from film;
select * from inventory;
select
	film.title,
    count(rental.rental_id) as rental_count
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
where rental_date >= '2006-01-01'
group by film.film_id
order by rental_count desc
limit 3;

# 4. 2005년 이후에 발행된 영화(film.release_year) 중에서,
# 대여한 횟수가 가장 많은 영화의 제목과 대여 횟수를 출력하세요. (inventory 활용)

select * from rental;
select  film.title,
		count(rental.rental_id) as rental_count
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
where film.release_year > 2005
group by film.film_id
order by rental_count desc
limit 1;

# 6. "Documentary"와 "Music" 장르에 해당되는 영화 중에서,
#    2005년 이후에 발행된 영화 제목과 발행 연도, 장르명을 출력하세요.

select film.title,
	   film.release_year,
       category.name as genre
from film
join film_category on film.film_id = film_category.film_id
join category on category.category_id = film_category.category_id
where category.name in ("Documentary", "Music")
  and film.release_year >= 2005;

# 7. "Comedy" 장르에 해당되는 영화 중에서, 대여 횟수가 가장 많은 영화 제목과 대여 횟수를 출력하세요.

select film.title, count(rental.rental_id) as rental_count
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join film_category on film.film_id = film_category.film_id
join category on film_category.category_id = category.category_id
where category.name = 'Comedy'
group by film.film_id
order by rental_count desc
limit 1;