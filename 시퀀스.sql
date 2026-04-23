select * from dict;
select * from dictionary;
select table_name from user_tables;

select * from student;
select * from USER_IND_COLUMNS WHERE TABLE_NAME ='STUDENT';

--학생 이름으로 인덱스 생성
create index student_name on student(name);
drop index idx_stud_name;

--복합 인덱스,결합 인덱스
create index idx_emp_job on emp(job);
select * from user_ind_columns where table_name = 'EMP';
select * from emp;

--고유인덱스
create unique index idx_emp_ename on emp(ename);
create index idx_emp_job_deptno on emp(job,deptno);
drop index idx_emp_job_deptno;
drop index idx_emp_ename;

create unique index idx_emp_ename on emp(ename);
create index idx_emp_job_deptno on emp(job,deptno);
drop index idx_emp_job_deptno;
drop index idx_emp_ename;

--view
create view vw_emp
as (select empno,ename,job,deptno 
    from emp 
    where deptno =30);

select * from vw_emp;

--사원번호,이름,부서명,급여 필드를 선택한 view 작성(vw_emp_dept)
select * 
from emp e join dept d on (e.deptno = d.deptno);

create view vw_emp_dept
as (select empno,ename,dname,sal
    from emp e join dept d on (e.deptno = d.deptno));

    
--학번,이름,학과명,점수,학점을 출력하는 view작성(vw_stud)
select * 
from student;
select * 
from department;
select * 
from score;
select * 
from hakjum;

create view vw_stud
as (select s.studno,s.name,d.dname,sc.total,h.grade
    from student s join department d on (s.deptno1 = d.deptno)
    join score sc on(s.studno = sc.studno)
    join hakjum h on(sc.total between h.min_point and h.max_point));
    
select * from vw_stud;

select rownum,e.* from emp e where deptno=30 order by empno desc;
select rownum,e.* from emp e where deptno=30 order by empno desc;
select rownum,e.* ,d.* from emp e , dept d where e.deptno=d.deptno order by empno desc;

----인라인 뷰를 사용한 TOP-N SQL문----
--인라인뷰(서브쿼리) 사용
SELECT ROWNUM, E.* FROM (SELECT * FROM EMP E ORDER BY SAL DESC) E;

--인라인뷰(WITH절사용)
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.* FROM E;

--인라인뷰로TOP-N 추출
SELECT ROWNUM, E.* 
FROM (SELECT * FROM EMP E ORDER BY SAL DESC) E
WHERE ROWNUM <=3;

--인라인뷰로TOP-N추출하기(WITH절사용)
WITH E AS (SELECT * FROM EMP E ORDER BY SAL DESC)
SELECT ROWNUM, E.* FROM E WHERE ROWNUM<=3;

--학생들 중에서 전공2가 있는 학생들의 ROWNUM,학번,이름, 전공2명을 출력하라
SELECT ROWNUM,NAME,DNAME
FROM (select * from STUDENT where deptno2 is not null) s,department d
WHERE s.deptno2=d.deptno;

--학생들 중에서 지도교수가 있는 학생들의 ROWNUM,학번,이름,지도교수명을 출력하라
SELECT ROWNUM,STUDNO,P.NAME,S.NAME
FROM (SELECT * FROM STUDENT WHERE PROFNO IS NOT NULL) S,PROFESSOR P
WHERE S.PROFNO = P.PROFNO;


----========시퀀스========----
CREATE TABLE DEPT_SEQ
AS SELECT * FROM DEPT WHERE 1<>1;

SELECT * FROM DEPT_SEQ;

CREATE SEQUENCE SEQ_DEPT_SEQUNCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;

SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE DEPT_SEQ2;

INSERT INTO DEPT_SEQ(DEPTNO,DNAME,LOC)
VALUES (seq_dept_sequnce.NEXTVAL,'생산7','SEOUL');
SELECT * FROM DEPT_SEQ;

CREATE TABLE DEPT100
AS SELECT * FROM DEPT WHERE 1<>1;
SELECT * FROM DEPT100;

INSERT INTO DEPT100
VALUES(DEPT_SEQ2.NEXTVAL,'영업','부산');

--SEQUENCE 사용데이터INSERT 하기
INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC) 
VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL,'DATABASE','SEOUL');

SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO;

--마지막시퀀스확인
SELECT SEQ_DEPT_SEQUENCE.CURRVAL FROM DUAL;
DROP SEQUENCE SEQ_DEPT_SEQUNCE2;


---SEQUENCE 생성
CREATE SEQUENCE DEPT_SEQ2
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;
-- 생성한시퀀스확인
SELECT * FROM USER_SEQUENCES;

--DEPTNO가90이상이될때까지반복하여INSERT--SEQUENCE가90을초과하면더이상번호생성못함
INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC) 
VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL,'DATABASE','SEOUL');


CREATE TABLE DEPT200
AS SELECT * FROM DEPT WHERE 1<>1;
INSERT INTO DEPT200
VALUES(DEPT_SEQ2.CURRVAL,'영업','부산');
SELECT * FROM DEPT200;

--SEQUENCE 수정
ALTER SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 3
MAXVALUE 99
CYCLE;
--수정된SEQUENCE 조회
SELECT * FROM USER_SEQUENCES;
--수정된SEQUENCE 사용(입력4번수행)
INSERT INTO DEPT_SEQUENCE(DEPTNO, DNAME, LOC) 
VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL,'DATABASE','SEOUL');
--데이터조회
SELECT * FROM DEPT_SEQUENCE;
--SEQUENCE 삭제
DROP SEQUENCE SEQ_DEPT_SEQUENCE;
--계정사용자시퀀스조회
SELECT * FROM USER_SEQUENCES;



