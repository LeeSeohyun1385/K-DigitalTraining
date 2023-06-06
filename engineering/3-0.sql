use world;

# select 절에서 서브쿼리 사용하기

# 전체 나라 수, 전체 도시 수, 전체 언어 수를 출력
select
	(select count(*) from city) as total_city,
    (select count(*) from country) as total_country,
    (select count(*) from countrylanguage) as total_language
    from dual;
    
#dual 은 더미 테이블 - 데이터를 표시만 하고자 할 때 (생략가능)

# from 절에 서브쿼리 사용
# 인구가 800만 이상되는 도시에 국가코드, 이름, 도시인구수 출력
# step 1) city 테이블 필터링 하기
select name as 'city_name',countrycode, population
from city
where population >= 8000000;

# step 2) 서브 쿼리로 사용하기 (from 절)
select *

from (
	select name as 'city_name',
			countrycode, 
            population
	from city
	where population >= 8000000) as city_pop_over_800;
    
# 서브 쿼리 이용시 테이블 알리하스 붙여야함

# step 3) 다른 테이블과의 JOIN, 같은 테이블과의 조인을 행하는 것을 self-join 이라고 한다.
select city_pop_over_800.city_name,
		country_simple.name,
		city_pop_over_800.population

from (
	select name as 'city_name',
			countrycode, 
            population
	from city
	where population >= 8000000) as city_pop_over_800
    
    join( select code, name from country) as country_simple 
     on city_pop_over_800.countrycode = country_simple.code;
     
# where 절 서브쿼리
# 800만 이상 도시의 국가코드, 국가이름, 대통령 이름 
select code, name 
     
from country

where code in (select distinct(countrycode)
				from city 
				where population >= 8000000);
