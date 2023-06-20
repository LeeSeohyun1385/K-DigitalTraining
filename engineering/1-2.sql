# gruop by는 특정 컬럼을 기준으로 데이터를 묶은 다음
# 각종 집계 함수를 이용해 데이터를 집계 (Aggregate)
# SUM, AVG, STD, STDDEV, VAR, MAX, MIN, COUNT 등등

use world;

select *
from city;

#국가 코드별 몇개의 도시가 있는지?
select CountryCode, count(countryCode)
from city
group by CountryCode;

# 각 국가마다 인구의 평균 구하기
select avg(population)
from city
group by CountryCode;

# 인구수가 23만명 이하이거나 50만명 이상인 나라들의 국가 별 인구수 평균

select CountryCode, avg(Population)
from city
where 230000 >= Population or 500000 <= Population
group by CountryCode;

# 국가코드가 A로 시작하는 나라 (like 'A%') 중 인구수가 
# 23만명 이하이거나 50만명 이상인 나라들의 국가 별 인구수 평균
select CountryCode, avg(Population)
from city
where CountryCode like 'A%' and (Population <= 230000 or Population >= 500000)
group by CountryCode;

# CountryCode, district 별 인구수 평균
select CountryCode, avg(Population)
from city
group by CountryCode, District;

# 각 district 별 인구수 평균, 표준편차, 최댓값
select avg(Population), stddev(Population) as std, max(Population), min(Population), district
from city
group by district
order by std desc;

# having 절
# group by에 대한 조건절
# where은 from에 대한 조건절 (테이블에 대한 필터링)
# having 은 집계 결과에 대한 조건절(select에 대한 필터링)

# 인구수의 총 합이 5천만 이상인 나라만 조회
select CountryCode, sum(Population) as 'sum_pop'
from city
group by CountryCode
having sum_pop >=50000000;
