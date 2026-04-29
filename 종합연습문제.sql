--1. (ㄱ)은 응용프로그램과 데이터베이스 사이의 중재자로서 사용자의 요구사항에 효율적으로 서비스를
--수행하기 위 하여 제공되는 소프트웨어로, 물리적인 데이터 저장구조와 외부 인터페이스 사이의 다양한
--소프트웨어들로 구성 되어 있다. (ㄱ)은 무엇인가?
-- ORACLE

--2. 데이터베이스 언어의 종류를 적으시오. 
--DDL,DML,TCL,DCL,

--3. system 계정의 패드워드를 잊었을 때 패스워드를 재설정하는 방법을 console에 sqlplus에 접속하는
--방법부터 작성하시오.
--
drop table t_product;
drop table t_sales;
drop table t_customer;

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

-- 7. 상품 테이블(product)을 다음과 같이 작성하라.
create table t_product(
p_code number(3),
p_name varchar2(20),
price number(4));

--8. 고객 테이블(customer)을 다음과 같이 작성하라.
create table t_customer(
c_code number(3) primary key,
c_name varchar2(20) not null unique,
gender number(6), check (gender in('남자','여자')),
tel varchar2(15) not null,
addr varchar2(100));

--9. 판매 테이블(sales)을 다음과 같이 작성하라.
create table t_sales(
s_code number(3) primary key,
c_code varchar2(20),
p_code varchar2(6),
amount number(3) not null);

alter table t_sales modify c_code number(3);
alter table t_sales add foreign key (c_code) references t_customer(c_code);

--10. 상품 테이블에 제조사(maker) 문자(20)으로 추가하라.
alter table t_product add maker varchar2(20);

--11. 상품 테이블에 p_code에 primary key 제약 조건을 추가하라
alter table t_product modify p_code primary key;

--12. 상품 테이블에 p_name에 unique 제약조건과 not null 제약조건을 추가하라.(오류)
alter table t_product add p_name not null unique;

--13. 상품 테이블에 price는 100보다 크고 999보다 작은 값으로 제약조건을 추가하라.
alter table t_product add check (price between 100 and 999);

--14. 판매 테이블에 amount 컬럼의 이름을 qty로 변경하라. 
alter table t_sales rename column amount to qty;

--15. 판매 테이블에 p_code 필드에 외래키를 지정하라.(product 테이블의 p_code 필드 참조)
alter table t_sales modify p_code number(3);
alter table t_sales add foreign key (p_code) references t_product(p_code);

--16. 고객 테이블에 c_name의 unique 제약조건을 사용안함으로 변경하고 
--    해당 테이블의 데이터에 DML까지 안되도록 변경하는 쿼리를 작성하라.

--17. 16번 문제에서 설정한 사용안함으로 설정된 제약조건을 사용함으로 변경하되 
--    기존에 있던내용과 새로 들어올 내용 모두를 제크하는 옵션으로 변경하라. 

--18. 시퀀스를 시작 값 101, 증가 값1인 시퀀스를 생성하라. 
create SEQUENCE t_cusequence
increment by 1
start with 101;

--19. 고객 정보를 입력한다. 단 c_code늘 시퀀스를 사용하여 고객의 정보를 입력하라. 

--20. 고객 테이블의 c_name으로 인덱스를 설정하라.

--21. 부서와 사원 테이블의 사원번호(empno), 이름(name),부서명(dname), 급여(pay), 전화번호(line)
--    칼럼을 선택하여 뷰(VIEW)를 작성하라.

--22. system에서 t_crud role를 생성하라. 

--23. t_crud 롤에 gest01 사용자의 product 테이블을 검색, 입력, 수정, 삭제 권한을 설정하라. 

--24 gest02 사용자에게 t_curd 롤 권한을 설정하라. 

--25. guest2 사용자에게 주어진 권한을 제거하라. 

--26. 트랜잭션에 대하여 설명하라.