-- countrylanguage 테이블에서 countrycode가 'NA'로 시작하는 국가의 언어들중, 사용자의 언어percentage가 10이상 30이하인 언어를 percentage순으로 오름차순 정렬
-- 2. countrylanguage 테이블에서 contrycode별 공식적인 언어(isofficial이 T)와 평균 퍼센테이지를 조회하고 평균 퍼센테이지를 내림차순으로 정렬
-- 3. city 테이블의 국가코드별 도시의 개수를 구하세요. 단 도시가 50개 이상인 국가만 표시하세요.
-- 4. country 테이블에서 독립년도가 1901~1999인 지역 중에서, 정부형태(GovenrnmentForm)가 Republic이면서 평균 GNP가 6000 이상인 지역
-- 5.country 테이블에서 Region별   surfaceArea, Capital 평균 및 GNP합계 구하시오 (단 Capital은 30 이상인곳만 조회,하고 오름차순 정렬)

use world;

# 1. countrylanguage 테이블에서 countrycode가 'NA'로 시작하는 국가의 언어들중, 사용자의 언어percentage가 10이상 30이하인 언어를 percentage순으로 오름차순 정렬
SELECT CountryCode, Percentage as 'P'
FROM countrylanguage
WHERE CountryCode LIKE 'NA%' AND (Percentage >= 10 AND Percentage <= 30)
ORDER BY P ASC;

# 2. countrylanguage 테이블에서 contrycode별 공식적인 언어(isofficial이 T)와 평균 퍼센테이지를 조회하고 평균 퍼센테이지를 내림차순으로 정렬
SELECT isOfficial, AVG(Percentage) AS P
FROM countrylanguage 
WHERE isOfficial = 'T'
GROUP BY CountryCode
ORDER BY P DESC;

# 3. city 테이블의 국가코드별 도시의 개수를 구하세요. 단 도시가 50개 이상인 국가만 표시하세요.
SELECT CountryCode, COUNT(CountryCode) AS 'count'
FROM city
GROUP BY CountryCode
HAVING count >= 50 ;

# 4. country 테이블에서 독립년도가 1901~1999인 지역 중에서, 정부형태(GovenrnmentForm)가 Republic이면서 평균 GNP가 6000 이상인 지역
#DESC country;

SELECT IndepYear, GovernmentForm, AVG(GNP) 
FROM country
WHERE IndepYear BETWEEN 1901 AND 1999 AND GovernmentForm = 'Republic'
GROUP BY GovernmentForm, IndepYear
HAVING AVG(GNP)>=6000; 

# 5. country 테이블에서 Region별   surfaceArea, Capital 평균 및 GNP합계 구하시오 (단 Capital은 30 이상인곳만 조회,하고 오름차순 정렬)
SELECT Region, AVG(SurfaceArea), AVG(Capital), SUM(GNP)
FROM country
GROUP BY Region 
HAVING AVG(Capital) >= 30
ORDER BY AVG(Capital) ASC; 


# 6. city 테이블에서, CountryCode가 A로 시작하면서 인구가 50만명 이상인 국가의 이름, CountryCode, Population을 구하고, 인구 수를 기준으로 내림차순 정리
SELECT Name, CountryCode, Population
FROM city
WHERE CountryCode LIKE 'A%' AND Population >= 500000
ORDER BY Population DESC;

# 7. country 테이블에서 대륙별 국가이름, 지역, 평균 독립년도와 평균 예상 수명을 조회하고 남아메리카와 아프리카 대륙을 제외,
#독립년도가 20세기 이후인 국가들 중 공화국(republic)인 나라들의 데이터를 구하시오. 평균 독립년도는 오름차순, 평균 예상 수명은 내림차순으로 정렬.
SELECT Continent, Name, Region, AVG(IndepYear), AVG(LifeExpectancy)
FROM country
#WHERE Continet <> 'North America' AND Continent <> 'Africa'
GROUP BY Continent, Region;

#SELECT * FROM country;

