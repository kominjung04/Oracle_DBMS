---복습
select 구문 :SQL
select column1,column2,....
from 테이블명
where 조건
grouby 그룹할 열
order by 정렬할 열 [asc/desc];

DML
insert into 테이블(열1,열2,....)
values (열1의 값,열2의 값);

update table 테이블명
set column1명 = 변경될 값1,column2명 = 변경될 값2,...
where 조건;

delete from table  조건
commit; dml 작업을 완료
rollback 작업을 되돌림(commit시 롤백 안됨)

DDL
create table 테이블명(
column1 datatype1,
column2 datatype2,
....);

---구조와 테이블 가져와서 새 테이블로 지정
create table 테이블명
as select * from 명;

---구조만 가져와서 새 테이블로 지정
create table 테이블명
as select * from 명;
where 1<>1;

---테이블 추가
alter table 테이블명 add|modify|drop
alter table 테이블명 add column명 datatype;
alter table 테이블명 modify column명 바꿀 datatype;
alter table 테이블명 rename column 원테이블명 to 바꾼 테이블명;

---테이블 삭제
drop table 테이블명; --테이블 구조까지 완전히 삭제
truncate table 테이블명 --테이블 구조만 남기고 데이터 완전히 삭제(롤백 불가)
delete from table; -- 테이블 원 장소는 남아있고 데이터 삭제(롤백 가능)

-----key값
primary key : unique , not null
foreign key : --외부테이블의 키 값 참조
