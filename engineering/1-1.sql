use test;

# 데이터 삽입 - insert 
insert into user1(user_id, name, email, age, rdate)
values(1, 'mhso', 'minho_so#@naver.com', 36, '2023-05-25');

INSERT INTO user1(user_id, name, email, age, rdate)
VALUES (2, 'park', 'mhso@gmail.com', 34, '2021-11-13'),
       (3, 'minho', 'mino@daum.net', 28, '2021-11-15'),
       (4, 'jiwon', 'jwon@daum.net', 27, '2021-11-11'),
       (5, 'siyeon', 'syw@snu.ac.kr', 25, '2021-11-12'),
       (6, 'taehee', 'thk@naver.com', 22, '2021-11-17');
       
# 특정 컬럼을 선택해서 데이터 삽입 
insert into user1(user_id, name)
values(7, 'sominho');

# 컬럼명을 지정하지 않으면 전체 컬럼에 insert
insert into user1
values(8, 'ahahah', 'add@naver.com', 38, now());

select * from user1;

# 데이터 조회 select
# select 구문은 반드시 from 부터, select는 제일 마지막에 
select name, email, rdate
from user1;

# 별명 붙이기 (alias)
select user_id as '회원아이디',
		name as '회원이름',
        email as '회원이메일'

from user1;

# 중복값 제거 
select * from user1;
#insert into user1 values(10, 'ahahah', 'add@naver.com' '38', now());
select distinct(age) from user1;

# where절(조건절) - Filtering
# 나이가 25세 이상인 사람들의 모든 정보 조회 
select *
from user1
where age >= 25;

# 2021 11 15 일 이전에 가입한 사람의 이메일, 이름, 나이 조회 
select email, name, age
from user1
where rdate < '2021-11-15';

# and 연산
select * 
from user1
where rdate >= '2021-11-12'
and rdate<='2021-11-15';

#between 활용 
select *
from user1
where rdate between '2021-11-12' and '2021-11-15';

# 나이가 30살 이상이고 가입일이 2021-11-13일 이전인 사람의 모든 정보
select *
from user1
where age >= 30 
and rdate <= '2021-11-13';

#
select name, age, email, rdate
from user1
where age between 20 and 35
and rdate between '2021-11-12' and '2021-11-15';