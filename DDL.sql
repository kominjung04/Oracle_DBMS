-----CREAT(테이블 생성)------
create table emp_100
as select * from emp;
select * from emp_100;

create table dept_100
as select * from dept;
select * from dept_100;

create table emp_130
as select * from emp where deptno=30;
select * from emp_130;

create table emp_temp10
as select empno,ename,job,sal,e.deptno,dname,loc
from emp e, dept d
where e.deptno = d.deptno;

create table emp_200
as select * from emp where 1<>1;
select * from emp_200;

create table emp_dept_200
as 
select empno,ename,job,sal,e.deptno,dname,loc
from emp e,dept d where e.deptno = d.deptno and 1<>1;
select * from emp_dept_200;

create table emp_ddl(
empno number(4),
ename varchar(2),
job varchar2(9),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2)
);
select * from emp_ddl;

CREATE TABLE DEPT_DDL(
DEPTNO NUMBER(2),
DNAME VARCHAR2(30),
LOC VARCHAR2(20));
SELECT * FROM DEPT_DDL;

table명 : mumber_ddl
columns :
id : 문자 20자
passwd : 문자 15자
name : 문자 : 20
email 문자 : 30
reg_date : date

create table mumber_ddl(
mno number(4),
id varchar2(20),
passwd varchar2(15),
name varchar2(20),
email varchar2(30),
reg_date date default sysdate
);

select * from mumber_ddl;

insert into mumber_ddl(mno,id,passwd,name,email)
values (1,'abcd','1234','홍길동','abcd@aaa.com');
insert into mumber_ddl(mno,id,passwd,name,email)
values (2,'chs','1234','성춘향','chs@aaa.com');
insert into mumber_ddl(mno,id,passwd,name,email)
values (3,'mllee','1234','이몽룡','mllee@aaa.com');

CREATE TABLE BOARD_DDL(
BNO NUMBER (5),
TITLE VARCHAR2(250),
CONTENT VARCHAR2(4000),
WRITER VARCHAR2(20),
READ_CNT NUMBER(4) DEFAULT 0,
REG_DATE DATE DEFAULT SYSDATE);

INSERT INTO BOARD_DDL(BNO,TITLE,CONTENT,WRITER)
VALUES(1,'제목1','내용1','홍길동');

SELECT * FROM BOARD_DDL;

UPDATE BOARD_DDL
SET READ_CNT=READ_CNT+1;
WHERE BNO=1;

-----ALTER(테이블 변경)-----
ALTER TABLE BOARD_DDL
ADD BLIKE NUMBER(3);

ALTER TABLE BOARD_DDL
ADD REPLY_CNT NUMBER(3) DEFAULT 0;
SELECT * FROM BOARD_DDL;

ALTER TABLE BOARD_DDL
RENAME COLUMN BLIKE TO LIKE_CNT;

ALTER TABLE BOARD_DDL RENAME TO NEW_BOARD;
SELECT * FROM NEW_BOARD;

DESC NEW_BOARD;

ALTER TABLE NEW_BOARD MODIFY WRITER VARCHAR2(50);
ALTER TABLE NEW_BOARD DROP COLUMN REPLY_CNT;
ALTER TABLE MUMBER_DDL RENAME TO MEMBER_DDL;

DESC MEMBER_DDL;
--HP : VARCHAR2(15)
--GENDER : VARCHAR2(1)
--GENDER 칼럼을 '남자','여자'가 들어갈 수 있도록 수정
--GENDER 칼럼 삭제
ALTER TABLE MEMBER_DDL ADD HP VARCHAR2(15);
ALTER TABLE MEMBER_DDL ADD GENDER VARCHAR2(1);
ALTER TABLE MEMBER_DDL MODIFY GENDER VARCHAR2(6);
ALTER TABLE MEMBER_DDL DROP COLUMN GENDER;
SELECT * FROM MEMBER_DDL;