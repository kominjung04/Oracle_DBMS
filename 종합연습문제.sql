--1. (ㄱ)은 응용프로그램과 데이터베이스 사이의 중재자로서 사용자의 요구사항에 효율적으로 서비스를
--수행하기 위 하여 제공되는 소프트웨어로, 물리적인 데이터 저장구조와 외부 인터페이스 사이의 다양한
--소프트웨어들로 구성 되어 있다. (ㄱ)은 무엇인가?
-- ORACLE

--2. 데이터베이스 언어의 종류를 적으시오. 
--DDL,DML,TCL,DCL,

--3. system 계정의 패드워드를 잊었을 때 패스워드를 재설정하는 방법을 console에 sqlplus에 접속하는
--방법부터 작성하시오.
--

--3. [SQL] 오라클에서 현재 계정이 가지고 있는 모든 테이블을 보여주는 쿼리를 작성하시오.
SELECT * FROM TAB;

--4. guest01 사용자를 추가하는 쿼리를 작성하라.(패스워드: 1234)
CREATE USER GUEST01 IDENTIFIED BY 1234;

--5. guest01 사용자에게 DBA 권한을 설하라. 
GRANT DBA TO GUEST01; 

--6. guest02 사용자(패스워드:1234)를 추가하고 guest02사용자가 데이터베이스에 접속, 리소스 사용, 세션
--생성, 뷰 생성이 가능하도록 권한 설정하는 쿼리를 작성하라.
CREATE USER GUEST02 IDENTIFIED BY 1234;
GRANT CONNECT,RESOURCE,CREATE SESSION,CREATE VIEW TO GUEST02;


--21. system에서 t_crud role를 생성하라. 

--22. t_crud 롤에 gest01 사용자의 product 테이블을 검색, 입력, 수정, 삭제 권한을 설정하라. 

--23 gest02 사용자에게 t_curd 롤 권한을 설정하라. 

--24. guest2 사용자에게 주어진 권한을 제거하라. 

--25. 트랜잭션에 대하여 설명하라.