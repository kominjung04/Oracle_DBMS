-----NOT NULL-----
SELECT OWNER,CONSTRAINT_NAME,CONSTRAINT_TYPE,TABLE_NAME
FROM USER_CONSTRAINTS;

CREATE TABLE T_NONULL2(
LOGIN_ID VARCHAR2(20) NOT NULL,
LOGIN_PWD VARCHAR(20) NOT NULL,
TEL VARCHAR2(20)
);

CREATE TABLE T_NONULL3(
LOGIN_ID VARCHAR2(20) CONSTRAINT C_LOGIN_ID NOT NULL,
LOGIN_PWD VARCHAR(20) CONSTRAINT C_LOGIN_PW NOT NULL,
TEL VARCHAR2(20)
);

CREATE TABLE T_NOTNULL(
LOGIN_ID VARCHAR2(20),
LOGIN_PWD VARCHAR(20),
TEL VARCHAR(20));

ALTER TABLE T_NOTNULL MODIFY(LOGIN_ID NOT NULL);
ALTER TABLE T_NOTNULL MODIFY(LOGIN_PWD NOT NULL);
INSERT INTO T_NOTNULL(LOGIN_ID, LOGIN_PWD) VALUES('ABCD','1234');
--ALTER TABLE T_NOTNULL MODIFY(TEL NOT NULL); -- 이미 NULL값이 있으면 NOTNULL 제약조건 안됨
UPDATE T_NOTNULL SET TEL='010-1234-5678';

SELECT * FROM T_NOTNULL;

SELECT OWNER,CONSTRAINT_NAME,CONSTRAINT_TYPE,TABLE_NAME
FROM USER_CONSTRAINTS;

ALTER TABLE T_NONULL3
DROP CONSTRAINT C_LOGIN_ID;

DESC T_NOTNULL;

----UNIQUE----
CREATE TABLE T_UNIQUE(
LOGIN_ID VARCHAR2(20) UNIQUE,
LOGIN_PW VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

DESC T_UNIQUE;
INSERT INTO T_UNIQUE
VALUES('ABCD','1234','010-2456-7897');
INSERT INTO T_UNIQUE
VALUES('ABCDD','12345','010-2456-1234');
INSERT INTO T_UNIQUE
VALUES(NULL,'12345','010-2456-1234');
INSERT INTO T_UNIQUE
VALUES(NULL,'12345','010-2456-1234');
INSERT INTO T_UNIQUE
VALUES(NULL,'12345','010-2456-1234');
SELECT * FROM T_UNIQUE;

-----UPDATE할 때 중복값 허용 안됨(무결성 제약조건)----
UPDATE T_UNIQUE 
SET LOGIN_ID = 'ABCD'
WHERE LOGIN_ID IS NULL;

CREATE TABLE T_UNIQUE2(
LOGIN_ID VARCHAR2(20) CONSTRAINT T_ID_UNQ UNIQUE,
LOGIN_PW VARCHAR2(20) CONSTRAINT T_ID_PW NOT NULL,
TEL VARCHAR2(20)
);


CREATE TABLE T_UNIQUE3(
LOGIN_ID VARCHAR2(20) NOT NULL UNIQUE,
LOGIN_PW VARCHAR2(20)  NOT NULL,
TEL VARCHAR2(20)
);

INSERT INTO T_UNIQUE3
VALUES('ABCD','1234','010-4567-8978');
INSERT INTO T_UNIQUE3
VALUES ('KKKQ','1234','010-4567-8798');

ALTER TABLE T_UNIQUE3 MODIFY (TEL UNIQUE);


----PRIMARY KEY----
CREATE TABLE T_PK(
LOGIN_ID VARCHAR2(20)PRIMARY KEY,
LOGIN_PW VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20)
);

SELECT OWNER,CONSTRAINT_NAME,CONSTRAINT_TYPE,TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME LIKE 'T_PK';

INSERT INTO T_PK
VALUES('ABCD','1234','010-2525-4545');
INSERT INTO T_PK
VALUES(NULL,'1234','010-2525-4545');

SELECT INDEX_NAME,TABLE_OWNER,TABLE_NAME
FROM USER_INDEXES
WHERE TABLE_NAME LIKE 'T_PK%';

---FOREIGN KEY----
create table dept_fk(
deptno number(2) constraint pk_deptno primary key,
dname varchar2(14),
loc varchar2(12));

create table emp_fk(
empno number(4) constraint pk_empno primary key,
ename varchar2(10) not null,
job varchar2(20),
mar number(4),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2) constraint emp_deptno_fk references dept_fk(deptno)
);

----이름 없이 생성----
create table dept_fk2(
DEPTNO NUMBER(2) PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13));


create table emp_fk2(
EMPNO NUMBER(4) PRIMARY KEY,
ENAME VARCHAR(10),
JOB VARCHAR(20),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2) REFERENCES DEPT_FK(DEPTNO)
);
---오류발생:부모테이블에 10번이 존재하지 않음---
insert into emp_fk2
values(9999,'test_name','test_job',null,sysdate,3000,null,10);
insert into dept_fk2
values(10,'test_dname','test_loc');

create table dept_fk3(
DEPTNO NUMBER(2) CONSTRAINT PK_DEPTNO3 PRIMARY KEY,
DNAME VARCHAR2(14),
LOC VARCHAR2(13));

create table emp_fk3(
EMPNO NUMBER(4) CONSTRAINT PK_EMPNO3 PRIMARY KEY,
ENAME VARCHAR(10),
JOB VARCHAR(20),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK3 
REFERENCES DEPT_FK(DEPTNO)on delete cascade
);

insert into emp_fk3
values(999,'test1_name','test_job2',null,sysdate,2000,null,10);
insert into dept_fk3
values(10,'test_dname','test_loc');

delete from dept_fk3 where deptno=10;
select * from dept_fk3;
select * from emp_fk3;

create table emp_fk4(
EMPNO NUMBER(4) CONSTRAINT PK_EMPNO4 PRIMARY KEY,
ENAME VARCHAR(10),
JOB VARCHAR(20),
MGR NUMBER(4),
HIREDATE DATE,
SAL NUMBER(7,2),
COMM NUMBER(7,2),
DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK4 
REFERENCES DEPT_FK3(DEPTNO)on delete set null
);
insert into dept_fk3
values(10,'test_dname','test_loc');
insert into emp_fk4
values(9999,'test_name','test_job',null,sysdate,3000,null,10);

delete from dept_fk3 where deptno=10;
select * from dept_fk3;
select * from emp_fk4;

-------------실습---------
create table t_product1(
pcode number primary key,
pname varchar(10) not null unique,
price number not null);

create table t_salese1(
scode number primary key,
pcode number references t_product1(pcode), 
pdate date,
count number);
--DATE가 FORMAT에 지정한 형태로 나옴
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS'; 

insert into t_product1
values (10,'연필',1000);
insert into t_product1
values (20,'볼펜',2000);
select * from t_product1;

select * from t_salese1;
insert into t_salese1
values(1,10,sysdate,5);
insert into t_salese1
values(2,20,sysdate,10);

create table t_salese1(
scode number primary key,
pcode number(2), 
pdate date default sysdate,
count number(3)
);

alter table t_salese2 add constraint fk_pcode foreign key (pcode) 
references t_product1(pcode);

create table t_salese3(
scode number ,
pcode number(2), 
pdate date default sysdate,
count number(3),
constraint pk_scode1 primary key(pcode)
);

alter table t_salese3 modify (scode primary key);

create table t_salese4(
scode number ,
pcode number(2), 
pdate date default sysdate,
count number(3),
constraint pk_scode1 primary key(pcode)
);


create table t_salese5(
scode number(2),
pcode number(2), 
pdate date default sysdate,
count number(3),
constraint pk_scode4 primary key(scode),
constraint fk_pcode4 foreign key(pcode) references t_product1(pcode)
);
alter table t_salese add constraint pk_scode primary key(pcode);
alter table t_salese add constraint fk_pcode foreign key(pcode)
references t_prdouct1(pcode);

------CHECK-----
CREATE TABLE T_CHECK(
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(15) CHECK(LENGTH(LOGIN_PWD)>3),
JOB VARCHAR2(20) CHECK(JOB IN ('회사원','공무원','교사')
));

INSERT INTO T_CHECK VALUES('ABCD','1234','군인');
INSERT INTO T_CHECK VALUES('ABCD','1234','교사');


-------DEFAULT-----
CREATE TABLE TABLE_DEFAULT(
LOGIN_ID VARCHAR2(20) PRIMARY KEY,
LOGIN_PWD VARCHAR2(20) DEFAULT '1234',
JOB VARCHAR2(20) CHECK(JOB IN ('공무원','회사원','교사')),
REGDATE DATE DEFAULT SYSDATE
)

