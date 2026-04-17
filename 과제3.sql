DROP TABLE T_EMP;
DROP TABLE T_DEPT;
SELECT * FROM T_DEPT;
SELECT * FROM T_EMP;
--1번 dept(부서) 테이블을 다음과 같이 생성
create table t_dept(
deptno number,
dname varchar2(6));

--2. dept(부서) 테이블에 area 필드를 가변길이문자 10으로 지정하고 칼럼을 추가한다. 
alter table t_dept add area varchar(10);

--3. dept(부서) 테이블의 dname의 문자열 길이를 6에서 10변경하라. 
alter table t_dept modify dname varchar2(10);

--4. dept(부서) 테이블에 deptno 필드에 기본키(primary key) 제약조건을 추가하라. 
 alter table t_dept modify (deptno PRIMARY KEY);
 
--5. dept 테이블에 dname 필드에 not null과 uniqe 제약조건을 설정하라
alter table t_dept modify (dname not null unique); 

--6.emp(사원) 테이블을 다음과 같이 작성
create table t_emp(
empno number primary key,
name  varchar2(10) not null,
deptno VARCHAR2(6),
positIon varchar2(10)check(POSITION IN('사원','대리','과장','부장')),
pay number not null,
pempno number);

--7. emp 테이블의 deptno 칼럼에 외래키를 제약 조건을 dept 테이블이 deptno 칼럼을 참조하도록 지정하라.
ALTER TABLE T_EMP MODIFY DEPTNO  NUMBER;
ALTER TABLE T_EMP ADD CONSTRAINT FK_TDEPTNO FOREIGN KEY(DEPTNO) REFERENCES T_DEPT(DEPTNO);

--8. emp 테이블에 pempno 필드에 외래키 제약 조건을 emp테이블의 empno필드를 참조하도록 설정하라. 
ALTER TABLE T_EMP ADD FOREIGN KEY(PEMPNO) REFERENCES T_EMP(EMPNO);

--9. dept 테이블과 emp 테이블에 데이터를 그림과 같이 입력하라.
INSERT INTO T_DEPT(DEPTNO,DNAME)
VALUES(101,'영업부');
INSERT INTO T_DEPT(DEPTNO,DNAME)
VALUES(102,'총무부');
INSERT INTO T_DEPT(DEPTNO,DNAME)
VALUES(103,'기획부');
INSERT INTO T_DEPT(DEPTNO,DNAME)
VALUES(104,'홍보부');
INSERT INTO T_EMP
VALUES(1001,'홍길동',101,'부장',450,NULL);
INSERT INTO T_EMP
VALUES(1002,'김연아',102,'부장',400,NULL);
INSERT INTO T_EMP
VALUES(1003,'박지성',101,'과장',350,1001);
INSERT INTO T_EMP
VALUES(1004,'김태근',103,'과장',410,NULL);
INSERT INTO T_EMP
VALUES(1005,'서찬수',101,'대리',300,1003);
INSERT INTO T_EMP
VALUES(1006,'김수현',103,'대리',400,1004);
INSERT INTO T_EMP
VALUES(1007,'정동진',103,'대리',320,1002);
INSERT INTO T_EMP
VALUES(1008,'이성규',102,'사원',380,1007);
INSERT INTO T_EMP
VALUES(1009,'임진영',103,'사원',250,1006);
INSERT INTO T_EMP
VALUES(1010,'서진수',101,'사원',200,1005);

--10. dept 테이블에 area 필드의 값을 영업부는 서울, 나머지 부산으로 값을 업데이트하라. 
UPDATE  T_DEPT 
SET AREA =  DECODE(DNAME,'영업부','서울','부산');

--12. emp 테이블에서 부서번호(deptno) 101 직원 중 사원 데이터를 삭제하라. 
DELETE FROM T_EMP
WHERE DEPTNO = 101 AND POSITION = '사원';

--13. emp 테이블을 사용하여 이름, 급여, 세금를 출력하라. 단 세금은 급여가 0-200이면 5%,
--    201-300이면 10%, 301-400 이면 15%, 나머지는 20%로 지정한다,(case)

SELECT NAME,DNAME,PAY,CASE 
                WHEN PAY<200 THEN   PAY*0.05
                WHEN PAY <=300 THEN  PAY*0.1
                WHEN PAY<=400 THEN  PAY*0.15
                ELSE PAY*0.2
                END AS TAX
FROM T_DEPT D JOIN T_EMP E ON(D.DEPTNO = E.DEPTNO);

--14. 영업부 직원과 총무부 직원의 이름, 부서명, 직급을 이름순으로 오름차순으로 출력하라. 
SELECT NAME,DNAME,POSITION
FROM T_EMP T JOIN T_DEPT D ON (T.DEPTNO = D.DEPTNO)
WHERE DNAME IN('영업부','기획부')
ORDER BY POSITION;

--15. emp 테이블을 이용하여 사원의 이름과 지속상관의 이름을 출력하라. 단 직속상관이 없는 경우 null이 표시되도록 하라. 

SELECT T2.NAME,T1.NAME
FROM T_EMP T1 RIGHT OUTER JOIN T_EMP T2 ON(T1.EMPNO = T2.PEMPNO);

--16. 부서별 급여의 평균과 인원수를 구하라.(부서번호, 급여의 평균, 인원수 출력)
SELECT DEPTNO,AVG(PAY),COUNT(*)
FROM T_EMP
GROUP BY DEPTNO;

--17. 부서별 급여의 평균이 300 이상인 부서의 부서명, 급여의 급여의 평균을 구하라. 
SELECT DEPTNO,AVG(PAY),COUNT(*)
FROM T_EMP
GROUP BY DEPTNO
HAVING AVG(PAY)>=300;

--18. 부서별, 직급별 인원수와 급여의 평균을 부서별 소계를와 총계를 구하라.(rollup).
SELECT * FROM T_EMP;
SELECT * FROM T_DEPT;

--19. emp 테이블에서 이성규와 같은 부서의 직원의 이름과 부서명을 출력하라.(sub query)
SELECT NAME,DNAME
FROM T_EMP E JOIN T_DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE E.DEPTNO = (SELECT DEPTNO
                FROM T_EMP
                WHERE NAME = '이성규');

--20. emp 테이블에서 각 부서별 급여가 가장 높은 사람의 이름, 부서명, 급여를 출력하라(sub query).
SELECT NAME,DNAME,PAY
FROM T_EMP E JOIN T_DEPT D ON (E.DEPTNO = D.DEPTNO)
WHERE (E.DEPTNO,PAY) IN(SELECT E.DEPTNO,MAX(PAY)
                    FROM T_EMP E
                    GROUP BY DEPTNO);

