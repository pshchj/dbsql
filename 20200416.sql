select *    --모든 컬럼정보를 조회
FROM prod;  --데이터 조회할 테이블 기술

--특정 컬럼에 대해서만 조회 : select 컴럼1, 컬럼2....
--prod_id, prod_name컬럼만 prod 테이블에서 조회;

select prod_id, prod_name
FROM prod;

--select 실습문제 1번
select *
FROM prod;

select buyer_id, buyer_name
FROM buyer;

select *
FROM cart;

select mem_id, mem_pass, mem_name
FROM member;

SQL 연산 : JAVA와 다르게 대입 x, 일반적 사칙연산
int b = 2;    = 대입 연산자, == 비교

SQL 데이터 타입 : 문자, 숫자, 날짜(data);


USERS 테이블이 (4/14 만들어 놓음) 존재
USERS 테이블의 모든 데이터를 조회;

select *
FROM USERS;

날짜 타입에 대한 연산 : 날짜는 +, - 연산 가능
data type + 정수 : data에서 정수날짜만큼 미래 날짜로 이동
data type - 정수 : data에서 정수날짜만큼 과거 날짜로 이동

select userid, reg_dt + 5
FROM users;

select userid, reg_dt + 5 after_5days, reg_dt -5
FROM users;

;
컬럼 별칭 : 기존 컬럼명을 변경 하고 싶을 때
syntax : 기존 컬럼명 [as] 별칭 명칭
별칭 명칭에 공백이 표현되어야 할 경우 더블 쿼테이션으로 묶는다
또한 오라클에서는 객체명을 대문자 처리 하기 때문에 소문자로 별칭을 지정하기 위해서도
더블 쿼테이션을 사용한다

select userid as id, userid id2, userid "아 이 디"
FROM users;

-- column alias (실습 select2)
select prod_id id, prod_name name
FROM prod;

select lprod_gu gu, lprod_nm nm
FROM lprod;

select buyer_id 바이어아이디, buyer_name 이름
FROM buyer;


문자열 연산(결합연산) : ||  (문자열 결합은 + 연산자가 아니다);
String str = "Hello";
str = str + ", world" --str : hello, world
SELECT /*userid 'test'*/ userid || 'test', reg_dt + 5, 'test', 15
FROM users;

경 이름 축
SELECT '경 ' || userid || ' 축'
FROM users;

SELECT userid || usernm
FROM users;

SELECT userid || usernm id_name
FROM users;


SELECT userid || usernm AS id_name
       CONCAT(userid, usernm) AS concat_id_name
FROM users;


--문자열 결합 실습 sel_con1
1 + 3 + 5
user_tables : oracle 관리하는 테이블 정보를 담고 있는 테이블(view) ==> data dictionary
SELECT 'SELECT * FROM ' || table_name AS QUERY
FROM user_tables;


테이블의 구성 컬럼을 확인
1. tool(sql developer)을 통해 확인
   테이블 - 확인하고자 하는 테이블

2. SELECT *
   FROM 테이블
   일단 전체 조회; --> 모든 컬럼이 표시

3. DESC 테이블명

DESC emp;

4. data dictionary : user_tab_columns

SELECT *
FROM user_tab_columns;

지금까지 배운 SELECT 구문
조회하고자 하는 컬럼 기술 : SELECT
조회할 테이블 기술 : FROM
조회할 행을 제한하는 조건을 기술 : WHERE
WHERE 절에 기술한 조건이 참(TRUE)일 때 결과를 조회
sql의 비교 연산 : =

SELECT *
FROm users
WHERE userid = 'cony';

emp테이블의 컬럼과 데이터 타입을 확인;
DESC emp;

'1234', 1234

SELECT *
FROM emp;

emp : employee
empno : 사원번호
ename : 사원이름
job : 담당업무
mgr : 담당자(관리자)
hiredate : 입사일자
sal : 급여
comm : 성과급
deptno : 부서번호

SELECT *
FROM dept;


emp 테이블에서 직원이 속한 부서번호가 30번보다 큰 부서에 속한 직원을 조회;
SELECT *
FROM emp
WHERE deptno >= 30;

!= 다를 때
users 테이블에서 사용자 아이디가(userid)가 brown이 아닌 사용자를 조회

SELECT *
FROM users
WHERE userid != 'brown';


SQL 리터럴 
숫자 : .... 20, 30.5
문자 : 싱글 쿼테이션 : 'hello world'
날짜 : TO_DATE('날짜문자열', '날짜 문자열의 형식');

1982년 1월 1일 이후에 입사한 직원만 조회
직원의 입사일자 : hiredate 컬럼

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
 
