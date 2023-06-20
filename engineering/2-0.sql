# CEIL , ROUND, TRUNCATE

# 1) CEIL : 실수 데이터를 올림하여 정수로 나타내기 
SELECT CEIL(12.345);

use world;
# 국가별 언어 사용 비율을 소수 첫번째 자리에서 올림하여 정수로 나타내기
SELECT CountryCode, Language, Percentage, CEIL(Percentage)
FROM countrylanguage;

# 2) ROUND : 실수 데이터를 반올림 할 때 사용한다. 
SELECT ROUND(12.345, 2);  #소수점 셋째 자리에서 반올림하여 둘째 자리까지 표시

SELECT CountryCode, Language, Percentage, ROUND(Percentage, 0)
FROM countrylanguage;

# 3) TRUNCATE : 실수 데이터를 버림 할 때 사용한다.
SELECT TRUNCATE(12.345, 2);

SELECT CountryCode, Language, Percentage, TRUNCATE(Percentage, 0)
FROM countrylanguage;

# SQL에서 조건문을 사용할 수 있음, IF, CASE
# 1) IF(조건, 참 expr, 거짓 expr)

# 도시의 인구가 100만이 넘으면 'Big City', 안 넘으면 'Small City'
SELECT name, Population, IF(Population >= 1000000, 'Big City', 'Small City')
FROM city;

# 도시의 인구가 100만이 넘으면 'Big City'. 50만이 넘으면 'Medium, City', 안넘으면 'Small City'
SELECT name,
	Population,
    IF(Population >= 1000000, 
    'Big City', 
    IF(Population >=500000, 'Medium City', 'Small City')
    )
FROM city;

# NULL : 데이터가 업음을 의미
SELECT *
FROM country
WHERE IndepYear IS NULL; #IS NOT NULL

# NULL 값을 처리 -> NULL 대신에 다른 값으로 채우겠다.
# IFNULL(컬럼명, 채울 값)
SELECT IndepYear, IFNULL(IndepYear,0), Name
FROM country;

-- # CASE
-- CASE
-- 	WHEN(조건1) THEN 출력1,
--     WHEN(조건2) THEN 출력2,
-- END

# AS 를 붙여주는 것이 좋음

# 나라 별로 인구가 10억 이상, 1억 이상, 1억 이하인 컬럼을 추가하여 표현
SELECT name,
	population,
    CASE 
		WHEN population >=1000000000 THEN '10억 이상'
        WHEN population >= 100000000 THEN '1억 이상'
        WHEN population < 100000000 THEN '1억 미만'
    END AS 'result'
FROM country;

# result를 사용해서 GROUP BY(집계) 해보기 
SELECT 
	AVG(population) as avg_pop,
    CASE 
		WHEN population >=1000000000 THEN '10억 이상'
        WHEN population >= 100000000 THEN '1억 이상'
        WHEN population < 100000000 THEN '1억 미만'
    END AS 'result'
FROM country
GROUP BY result, name;
# GROUP BY 에는 카테고리가 될 수 없는 컬럼이 들어오면 안된다.

# 10억 이상, 1억 이상, 1억 미만인 나라들 중 가장 인구수가 많은 나라를 각각 구하시오.
# 나라 이름을 구해야함 
# 카테고리컬 컬럼을 만들어서 group by (group by에 함부로 컬럼을 넣으면 안됨)
# GROUP BY의 목적은 단순해야함(계획을 잘 세우고 쓰기)

# DATE_FORMAT(날짜 데이터, 포매팅)
# 날짜 : (년-월-일 시:분:초)
use sakila;

SELECT SUM(amount), DATE_FORMAT(payment_date, '%Y-%m') as "monthly"
FROM payment
GROUP BY monthly;

#JOIN
#CREATE DATABASE test;
#USE test;
-- CREATE TABLE user (
-- 	user_id int(11) unsigned NOT NULL AUTO_INCREMENT, name varchar(30) DEFAULT NULL,
-- 	PRIMARY KEY (user_id)
-- );

-- CREATE TABLE addr (
-- 	id int(11) unsigned NOT NULL AUTO_INCREMENT, addr varchar(30) DEFAULT NULL,
-- 	user_id int(11) DEFAULT NULL,
-- 	PRIMARY KEY (id)
-- );

INSERT INTO user(name) VALUES ("jin"),
("po"),
("alice"),
("petter");

INSERT INTO addr(addr, user_id) VALUES ("seoul", 1),
("pusan", 2),
("deajeon", 3),
("deagu", 5), ("seoul", 6);

# INNER JOIN : 두 테이블 사이에 공통된 값이 없는 row에는 출력 안함
SELECT user.user_id, user.name, addr.addr
FROM user #메인이 되는 테이블을 FROM절에 넣음 
JOIN addr ON user.user_id = addr.user_id;

use world;

# 도시이름과 국가이름을 출력
# 도시 : city, 국가이름: country 테이블

#desc world.city;
#desc world.country;

SELECT city.name AS 'city_name', country.name AS 'country_name'
FROM city
JOIN country on city.CountryCode = country.Code;

# LEFT JOIN
# FROM절에 오는 테이블의 모든 정보를 표시
USE test;
 
SELECT user.user_id, user.name, addr.addr
FROM user
LEFT JOIN addr ON user.user_id = addr.user_id;

# RIGHT JOIN
SELECT addr.user_id , user.name, addr.addr
FROM user
RIGHT JOIN addr ON user.user_id = addr.user_id;


# UNION
# SELECT 문의 결과 데이터를 하나로 합쳐서 출력
# 주의: 컬럼의 개수, 타입, 순서 모두 일치해야함
# UNION 은 자동으로 distinct가 적용된다.(중복 데이터는 제거됨)
# UNION ALL은 중복을 허용
SELECT name FROM user 
UNION
SELECT addr FROM addr;

SELECT name FROM user 
UNION ALL
SELECT addr FROM addr;

# UNION 으로 FULL Outer JOIN 구현
SELECT id, user.name, addr.addr
FROM user
LEFT JOIN addr ON user.user_id = addr.user_id

UNION

SELECT id, user.name, addr.addr
FROM user
RIGHT JOIN addr ON user.user_id = addr.user_id;