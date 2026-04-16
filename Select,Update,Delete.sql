select column1,column2.....
from  table명
where 조건
group by 그룹화 할 column,...
havig절 그룹화 할 cloumn 조건
order by column [asc/desc];

join
sub query;

---테이블 생성---
---dept의 테이블을 복사해 새 테이블로 생성
create table dept_temp 
as 
select * 
from dept;

select * from dept_temp;

create table emp_temp
as
select * 
from emp;

select * from emp_temp;
//dept 구조만 복사(존재 할 수 없는 조건)
create table dept_temp2 
as
select *
from dept
where 1<>1;

select * from dept_temp2;

create table emp_temp2
as
select *
from emp
where 1<>1;

select * from emp_temp;
--------------------------------
--=====데이터 추가=====--
insert into dept_temp(deptno,dname,loc)
values (50,'홍보부','서울');

select * from dept_temp;

--열 이름 생략 가능
insert into dept_temp values (60,'NETWORK','BUSAN'); 

--열의 개수와 값의 타입과 개수만 같다면 추가 가능
INSERT INTO DEPT_TEMP(LOC,DEPTNO,DNAME)
VALUES ('BUSAN',70,'DATABASE');

--열과 값을 안넣을 경우 NULL값으로 대체(NULL이 안들어가는 조건이 있을 경우 오류)
INSERT INTO DEPT_TEMP(DEPTNO,DNAME)
VALUES(80,'PRO');

--날짜 데이터 입력하기
INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(9999,'홍길동','PRESIDENT',NULL,'2001/01/01',5000,1000,10);

INSERT INTO EMP_TEMP(EMPNO,HIREDATE,SAL)
VALUES(9999,'2001/01/01',5000);

SELECT * FROM EMP_TEMP;

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(1111,'성춘향','MANAGER',9999,'2001-01-01',4000,NULL,10);

INSERT INTO EMP_TEMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO) ---ERROR:YYYY MM DD형식 틀림
VALUES(1111,'성춘향','MANAGER',9999,'01/01/2001',4000,NULL,10);

--열에 조건이 있을시 조건에 따라야 함(DEPTNO (NOT NULL),DNAME(NOT NULL)
INSERT INTO DEPT_TEMP(DEPTNO,DNAME,LOC)
VALUES (99,'기획','PUSAN');

INSERT INTO EMP_TEMP2
SELECT * FROM EMP;

SELECT * FROM EMP_TEMP2;

INSERT INTO EMP_TEMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND S.GRADE=1;

CREATE TABLE T1 AS
SELECT E.ENAME,D.DNAME,SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND 1<>1;

SELECT * FROM T1;

CREATE TABLE T2 AS
SELECT E.ENAME,D.DNAME,SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT * FROM T2;

---예제. 학생테이블과 학과테이블을 조인하여 학번,학생이름,학과명 테이블을 데이터 없이 작성하라
1 홍길동 컴공
2 성춘향 컴공
3 이도령 인공지능
SELECT * FROM STUDENT;
SELECT * FROM DEPARTMENT;

CREATE TABLE STD AS
SELECT S.STUDNO,S.NAME,D.DNAME
FROM STUDENT S,DEPARTMENT D
WHERE S.DEPTNO1 = D.DEPTNO
AND 1<>1;

INSERT INTO STD(STUDNO,NAME,DNAME)
VALUES (1111,'홍길동','컴공');
INSERT INTO STD(STUDNO,NAME,DNAME)
VALUES (2,'성춘향','컴공');
INSERT INTO STD(STUDNO,NAME,DNAME)
VALUES (3,'이도룡','인공지능');
commit;--테이블 상태를 적용시키기
SELECT * FROM STD;

--=====UPDATE=====--
update dept_temp
set loc = 'Busan';
rollback;

select * from dept_temp;

UPDATE DEPT_TEMP
SET LOC = 'SEOUL'
WHERE DEPTNO=10;
COMMIT;
SELECT * FROM DEPT_TEMP;
ROLLBACK; --커밋되기전만 롤백 가능

---COMM이 NULL인것을 찾아서 100으로 변경하라
SELECT * FROM EMP_TEMP;

UPDATE EMP_TEMP
SET COMM = 100
WHERE COMM IS NULL;
ROLLBACK;

--10번 부서 직원들의 COMM을 50을 더하라
UPDATE EMP_TEMP
SET COMM = NVL(COMM,0)+50
WHERE DEPTNO = 10;

--SUBQUREY를 이용한 데이터 수정---
--40번 부서의 이름과 위치를 10번 부서의 이름과 위치에 업데이트 해라
UPDATE DEPT_TEMP 
SET (DNAME,LOC) = (SELECT DNAME,LOC FROM DEPT WHERE DEPTNO=40)
WHERE DEPTNO=10;

SELECT * FROM DEPT_TEMP;
ROLLBACK;

--30번 부서의 COMM을 30번 부서의 COMM의 평균으로 변경하라
SELECT * FROM EMP_TEMP;
UPDATE EMP_TEMP
SET COMM = (SELECT AVG(COMM) FROM EMP WHERE DEPTNO=30)
WHERE DEPTNO=30;

ROLLBACK;
SELECT * FROM EMP_TEMP;

--=====DELETE=====--

SELECT * FROM EMP_TEMP;
DELETE FROM EMP_TEMP;
ROLLBACK;

SELECT * FROM EMP_TEMP;
DELETE FROM EMP_TEMP WHERE DEPTNO=30;
ROLLBACK;

SELECT * FROM EMP_TEMP2;
DELETE FROM EMP_TEMP2 WHERE JOB = 'MANAGER';
ROLLBACK;


DELETE FROM EMP_TEMP2
WHERE EMPNO IN (SELECT E.EMPNO 
                FROM EMP_TEMP2 E,  SALGRADE S
                WHERE E.SAL BETWEEN S.LOSAL AND HISAL AND S.GRADE=3 AND DEPTNO=30);
                

DELETE FROM STUDENT WHERE STUDNO IN (SELECT S1.STUDNO
                                    FROM STUDENT S1,SCORE S2,HAKJUM H   
                                    WHERE S1.STUDNO = S2.STUDNO AND S2.TOTAL 
                                    BETWEEN MIN_POINT AND MAX_POINT AND H.GRADE = 'C+');
SELECT * FROM STUDENT;
ROLLBACK;

--부서별 급여가 가장 낮은 사람만 삭제--
SELECT * FROM EMP;

DELETE FROM EMP_TEMP2
WHERE SAL IN (SELECT MIN(SAL)
              FROM EMP_TEMP2
              GROUP BY DEPTNO);
ROLLBACK;

DELETE FROM EMP_TEMP2;
SELECT * FROM EMP_TEMP2;
ROLLBACK;

TRUNCATE TABLE EMP_TEMP2; -- 공간을 잘려내 롤백 불가


