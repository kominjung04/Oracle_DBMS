--------과제 1 -------
select * from emp;
select * from student;
select * from professor;
---1. emp 테이블에서 10번 부서에 근무하는 사원의 이름과 급여와 부서번호를 출력하라---
select ename,sal,deptno from emp;
---2. student 테이블에서 키(height)가 170보다 작거나 180cm보다 큰 데이터를 출력하라---
select * from student where height < 170 or height >180;
---3. student 테이블에서 몸무게가(weight)가 60~80kg인 학생의 이름.몸무게를 출력하라---
select name,weight from student where weight >=60 and weight <=80;
---4. student 테이블에서 101번 학과와 201번 학과의 학생들을 모두 출력하라---
select * from student where deptno1 in (101,201) OR DEPTNO2 IN (101,102);
---5. professor테이블에서 name,position,pay,연봉을 출력하라, 단 연봉은 pay*12+bouse으로 구한다.---
select name,position,pay,pay*12+bonus 연봉 from professor;
---6. student 테이블에서 전화번호의 지역번호가 02, 051인 데이터의 이름과 전화번호를 출력하라.---
SELECT NAME,TEL FROM STUDENT WHERE TEL LIKE '02%' OR TEL LIKE '051%';
---7. student 테이블에서 이름과 ID를 출력하며, 이름은 대문자로, ID소문자로 변환하여 출력하라---
SELECT UPPER(NAME),LOWER(ID) FROM STUDENT;
---8. professor 테이블에서 이름의 2~4자리 글자 '***'로 표시하라.---
SELECT NAME,REPLACE(NAME,SUBSTR(NAME,2,3),'****') FROM PROFESSOR;
---9. professor 테이블에서 홈페이지 있는 교수의 이름과 홈페이지를 출력하라---
SELECT NAME,HPAGE FROM PROFESSOR WHERE HPAGE IS NOT NULL;
---10. 교수(professor) 테이블에서 position이 instructor이 아닌 교수의 name과 email,3번째 글자부터 @앞부분 글자까지 ##으로 표기하여 표시하라..---
SELECT NAME,EMAIL,SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1)FROM PROFESSOR WHERE  POSITION != 'instructor';
SELECT EMAIL,SUBSTR(EMAIL,1,INSTR(EMAIL,'@',1)-3)FROM PROFESSOR WHERE POSITION != 'instructor';
SELECT EMAIL,REPLACE(EMAIL,SUBSTR(EMAIL,3,INSTR(EMAIL,'@',1)-3),'##')FROM PROFESSOR WHERE POSITION != 'instructor';
--INSTR(EMAIL,'@',1) = @의 위치



-----------6장 문제---------
SELECT * FROM EMP;
SELECT EMPNO,ENAME FROM EMP;