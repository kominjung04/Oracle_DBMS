--* 다음의 작업을 guest01 사용자로 접속하여 그림과 같이 t_product(사원), t_customer(고객),
--t_sales(판매) 테이블과 데이터를 참고하여 작성한다. 

--7. 상품 테이블(product)을 다음과 같이 작성하라.
CREATE TABLE PRODUCT(
P_CODE NUMBER(3),
P_NAME VARCHAR2(20),
PRICE NUMBER(4)
);

--8. 고객 테이블(customer)을 다음과 같이 작성하라.
CREATE TABLE CUSTOMER(
C_CODE NUMBER(3) PRIMARY KEY,
C_NAME VARCHAR2(20) UNIQUE NOT NULL,
GENDER VARCHAR2(6) CHECK(GENDER IN('남자','여자')),
TEL VARCHAR2(15) NOT NULL,
ADDR VARCHAR2(100));

--9. 판매 테이블(sales)을 다음과 같이 작성하라.
ALTER TABLE CUSTOMER MODIFY C_CODE VARCHAR2(20); 

CREATE TABLE SALES(
S_CODE NUMBER(3) PRIMARY KEY,
C_CODE VARCHAR2(20) REFERENCES CUSTOMER(C_CODE),
P_CODE VARCHAR2(6),
AMOUNT NUMBER(3) NOT NULL);

--10. 상품 테이블에 제조사(maker) 문자(20)으로 추가하라.
ALTER TABLE PRODUCT ADD MAKER VARCHAR2(20);

--11. 상품 테이블에 p_code에 primary key 제약 조건을 추가하라. 
ALTER TABLE PRODUCT MODIFY P_CODE PRIMARY KEY;

--12. 상품 테이블에 p_name에 unique 제약조건과 not null 제약조건을 추가하라. 
ALTER TABLE PRODUCT MODIFY P_NAME UNIQUE NOT NULL;

--13. 상품 테이블에 price는 100보다 크고 999보다 작은 값으로 제약조건을 추가하라. 
ALTER TABLE PRODUCT MODIFY PRICE CHECK(PRICE BETWEEN 100 AND 999);

--14. 판매 테이블에 amount 컬럼의 이름을 qty로 변경하라. 
ALTER TABLE SALES RENAME COLUMN AMOUNT TO QTY;

--15. 판매 테이블에 p_code 필드에 외래키를 지정하라.(product 테이블의 p_code 필드 참조)
ALTER TABLE PRODUCT MODIFY P_CODE VARCHAR2(6);
--ALTER TABLE SALES MODIFY P_CODE REFERENCE PRODUCT(P_CODE);

--16. 고객 테이블에 c_name의 unique 제약조건을 사용안함으로 변경하고 해당 테이블의 데이터에 DML
--까지 안되도록 변경하는 쿼리를 작성하라.

--17. 16번 문제에서 설정한 사용안함으로 설정된 제약조건을 사용함으로 변경하되 기존에 있던
--내용과 새로 들어올 내용 모두를 제크하는 옵션으로 변경하라. 

--18. 시퀀스를 시작 값 101, 증가 값1인 시퀀스를 생성하라. 

--19. 고객 정보를 입력한다. 단 c_code늘 시퀀스를 사용하여 고객의 정보를 입력하라. 

--19. 고객 테이블의 c_name으로 인덱스를 설정하라. 20. 부서와 사원 테이블의 사원번호(empno), 이름(name),부서명(dname), 급여(pay), 전화번호(line)
--칼럼을 선택하여 뷰(VIEW)를 작성하라. 