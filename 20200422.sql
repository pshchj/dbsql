EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno='7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 
 실행계획을 보는 순서(id)
 * 들여쓰기 되어있으면 자식 오퍼레이션(한칸 띈 오퍼레이션)
 1. 위에서 아래로
    *단 자식 오퍼레이션이 있으면 자식 부터 읽는다
    1번 ==> 0번 순으로 읽는다. 
    사원번호 7369값만 빼고 나머지는 버렸다
--------------------------------------------------------------------------
| Id  | Operation         | Name | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |      |     1 |    38 |     3   (0)| 00:00:01 |
|*  1 |  TABLE ACCESS FULL| EMP  |     1 |    38 |     3   (0)| 00:00:01 |
--------------------------------------------------------------------------
 
Predicate Information (identified by operation id):
---------------------------------------------------
 
   1 - filter("EMPNO"=7369)
   
   
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
 
 
--실습 문제4
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
 
--재미 
SELECT ename, sal, TO_CHAR(sal , 'L009,999.00')
FROM emp;

NULL과 관련된 함수
NVL
NVL2
NULLIF
COALESCE;

왜 NULL 처리를 해야할까?
NULL에 대한 연산결과는 NULL이다

예를 들어서 emp 테이블에 존재하는 sal, comm 두개의 컬럼 값을 합한 값을 알고 싶어서
다음과 같이 SQL을 작성.

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) sal_plus_comm
FROM emp;

NVL(expr1, expr2)
expr이 null이면 expr2값을 리턴하고
expr1이 null이 아니면 expr1을 리턴

REG_DT 컬럼이 NULL일 경우 현재 날짜가 속한 월의 마지막 일자로 표현
SELECT userid, usernm, NVL(reg_dt, LAST_DAY(SYSDATE))
FROM users;


NVL(expr1, expr2)
expr1 == null
    return expr2
expr1 != null
    return expr1
    
NVL2(expr1, expr2, expr3)
if expr1 != null
    return expr2
else
    return expr3


NULLIF(expr1, expr2)
if expr 1 == expr2
    return null
else 
    return expr1
    
sal컬럼의 값이 3000이면 null을 리턴    
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

가변인자 : 함수의 인자의 갯수가 정해져 있지 않음
          가변인자들의 타입은 동일 해야함
          
인자들 중에 가장 먼저 나오는 null이 아닌 인자
coalesce(expr1, expr2.....)
if expr1 != null
    return expr1
else 
    coalesce(expr2, expr3.....)
    
mgr 컬럼 null
comm 컬럼 null

SELECT empno, ename, comm, sal, coalesce(comm, sal)
FROM emp;

SELECT empno, ename, MGR, NVL(mgr, 9999) MGR_1, NVL2(mgr, mgr, 9999) MGR_2, coalesce(mgr, mgr, 9999) MGR_3
FROM emp;

SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) n_reg_dt
FROM users;

가상화 ==> os위에 다른 os 설치
1. 하드웨어 자원을 뽑아먹는다.
2. oracle mac 플랫폼을 지원 X





