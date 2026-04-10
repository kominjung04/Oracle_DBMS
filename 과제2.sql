SELECT * FROM EMP;
SELECT * FROM EMP2;
SELECT * FROM DEPT;
SELECT * FROM DEPT2;
SELECT * FROM STUDENT;
SELECT * FROM PROFESSOR;
--1번)emp 테이블을 이용하여 직책(job)별로 그룹화하여 직책(job), 평균급여(avg_sal), 최고급여(max_sal),
--최저 급여(min_sal), 사원수(count)를 구하시오. 단 평균 급여는 소수점을 제외하고 출력하라.
SELECT JOB,ROUND(AVG(SAL)),MAX(SAL),MIN(SAL),COUNT(*)
FROM EMP
GROUP BY JOB;
--2번)student 테이블을 이용하여 전공1(deptno1)별로 학생의 인원수를 구하고 인원수가 2명 이상인 전공번호와 인원수를 출력하라
SELECT DEPTNO1,COUNT(*)
FROM STUDENT
GROUP BY DEPTNO1
HAVING COUNT(*)>=2;
--3번)emp 테이블을 이용하여 입사연도(hiredata)를 기준으로 부서별 인원수를 구하라.
select HIREDATE, count(*)
from emp
GROUP BY HIREDATE;
--4번)교수 테이블에서 학과별 교수의 인원수와 연봉의 합, 평균, 최대값, 최소값을 구하라. 단 연봉은
--    pay*12+bonus로 구하라. 단 보너스 없는 경우 0으로 계산하고, 모두 소수점 1자리까지 표시하라.

--5번)교수 테이블에서 학과별 교수의 인원수와 pay의 평균을 구하고, 학과별 평균 pay가 300 이상인 것을 표시하라

--6번)Professor 테이블에서 교수 이름, 고용일, 연봉(pay*12+bonus)을 출력하라. 날짜의 형식은’2016-03-24’와 
--    같은 형식으로 이 표시하고 연봉은 ‘5,000’와 같이 표시 되도록 한다.

--7번)student 테이블을 이용하여 학번, 학생이름, 학과번호, 학과명을 출력하라. 단 학과명은 학과번호가
--   101이면 ‘컴퓨터공학’, 102 이면 ‘멀티미디어공학’, 103 이면 ‘소프트웨어공학’, 나지머지 기타로 출력하라.
--   (DCODE와 CASE 함수 사용)

--8번)dept2와 emp2 테이블을 조인하여 사원명, 부서명, 연락처, 급여를 출력하라.

--9번)dept2 테이블을 self 조인을 수행하여 부서번호, 부서명, area, 상위부서명을 출력하라. 

--10번) emp2와 dept2 테이블을 사용하여 부서번호, 부서명, 사원명, 상사이름을 출력하라

--11번)emp2와 dept2 테이블을 사용하여 전체급여의 평균보다 낮은 사람의 이름과 부서명, 급여를 부서명순으로 
--    오름 차순으로 정렬하여 출력하라.

--12번)emp2와 dept2 테이블을 사용하여 부서명별 급여가 가장 높은 사람의 이름과 부서명, 급여를 출력하라.

--13번)emp2와 dept2 테이블을 사용하여 이름, 생일, 부서명(스칼라 subquery 이용)을 출력하라

--14번)emp2 테이블에서 emp_type이 permanent employee인 사람 중 최고 급여를 받은 사람보다 적은급여를 받는 사람의 이름과
--     emp_type 급여(pay)를 출력하라.

--15번)emp 테이블에서 comm이 없는 사람의 정보(inline view), dept 테이블을 조인하여 empno, ename,dname, sal을 출력하라.