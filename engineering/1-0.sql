#CREATE DATABASE test;
# 2) 데이터 베이스 확인 
#show databases;

# 데이터 베이스 사용
#use test;

# 선택된 데이터 베이스 확인 
#select database();

# 테이블 생성(제약조건 없는 테이블)
-- create table user1(
-- 	user_id int,
--     name varchar(20),
--     email varchar(30),
--     age int(3),
--     rdate date
-- );

-- # 테이블 생성(제약조건 있음) -> 추천
-- create table user2(
-- 	user_id int primary key auto_increment,
--     name varchar(20) not null,
--     email varchar(30) unique not null,
--     age int(3) default 30, #기본값
--     rdate timestamp default now()
-- );

# 데이터 베이스, 테이블 변경 - alter
# 현재 선택된 데이터 베이스의 문자집합 확인

#show variables like 'character_set_database';

# 데이터 베이스의 문자집합을 ascii로 변경
#alter database test character set = ascii;
#show variables like 'character_set_database';

#alter database test character set = utf8mb4;
#show variables like 'character_set_database';

# 테이블 구조 변경( 보통 컬럼에 대한 추가, 삭제, 변경)
#alter table user2 add tmp text;

# 컬럼 변경 (modify)
#alter table user2 modify column tmp int(3);

# 컬럼 삭제(drop)
#alter table user2 drop tmp;

# 테이블 삭제 
#drop table user1;
#drop database test;


