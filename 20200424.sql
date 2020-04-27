NULL처리 하는 방법 (4가지 중에 본인 편한걸로 하나 이상은 기억)
NVL, NVL2...

SELECT NVL(empno, 0) , ename, NVL(sal, 0), NVL(comm, 0)
FROM emp;

실행계획 : 실행계획이 뭔지
          보는 순서
          
emp 테이블에 등록된 직원들에게 보너스를 추가적으로 지급할 예정
해당 직원의 job이 SALESMAN일 경우 SAL에서 5% 인상된 금액을 보너스로 지급 (ex: sal 100 -> 105)
해당 직원의 job이 MANAGER이면서 deptno가 10이면 SAL에서 30% 인상된 금액을 보너스로 지급 
                             그 외의 부서에 속하는 사람은 10% 인상된 금액을 보너스로 지급
해당 직원의 job이 PRESIDENT일 경우 SAL에서 20% 인상된 금액을 보너스로 지급
그외직원들은 sal만큼만 지금

DECODE만 사용 (case 절 사용 금지)

그 외 직원들은 sal 만큼만 지급          

SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal*1.05, 
              DECODE(deptno, 10, sal*1.30, sal*1.10),
                   'PRESIDENT', sal*1.20,
                    sal) bonus
FROM emp;

집합 A = {10, 15, 18 , 23, 24, 25, 29, 30, 35, 37}
Prime Number 소수 : {23, 29, 37}
비소수 : {10, 15, 18, 24, 25, 30, 35}


GROUP FUNCTION
여러행의 데이터를 이용하여 같은 그룹끼리 묶어 연산하는 함수
여러행을 입력받아 하나의 행으로 결과가 묶인다
EX : 부서별 급여 평균
     emp 테이블에는 14명의 직원이 있고, 14명의 직원은 3개의 부서(10, 20, 30)에 속해 있다.
     부서별 급여 평균은 3개의 행으로 결과가 반환된다
     
GROUP BY 적용시 주의 사항 : SELECT 기술할 수 있는 컬럼이 제한됨

SELECT 그룹핑 기준 컬럼: 그룹함수
FROM 테이블
GROUP BY 그룹핑 기준 컬럼
[ORDER BY ];

부서별 가장 높은 급여 값

SELECT deptno, ename, MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, sal
FROM emp
ORDER BY deptno;

SELECT deptno,
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), --부서별로 가장 낮은 급여 값
        ROUND(AVG(sal), 2), --부서별 급여 평균
        SUM(sal), --부서별 급여 합
        COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT(*),   --부서별 행의 수
        COUNT(mgr)
FROM emp
GROUP BY deptno;


* 그룹 함수를 통해 부서번호 별 가장 높은 급여를 구할 수는 있지만
  가장 높은 급여를 받는 사람의 이름을 알 수는 없다.
   ==> 추후 WINDOW/분석 FUNCTION을 통해 해결 가능

emp 테이블의 그룹 기준을 부서번호가 아닌 전체 직원으로 설정 하는 방법
SELECT  MAX(sal), --전체 직원중가장 높은 급여 값
        MIN(sal), --전체 직원중 가장 낮은 급여 값
        ROUND(AVG(sal), 2), --전체 직원의 급여 평균
        SUM(sal), --전체 직원의 급여 합
        COUNT(sal), --전체 직원의 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT(*),   --전체 행의 수
        COUNT(mgr)  -- mgr 컬럼이 null이 아닌 건수
FROM emp;

2020.04.27 발표 때 정답 확인
GROUP BY 절에 기술된 컬럼이
    SELECT 절에 나오지 않으면 기술한 컬럼의 기본값만 안나온다.
    
GROUP BY 절에 기술되지 않은 컬럼이
    SELECT 절에 나오면 결과에 기술한 컬럼이 나온다.;
    
그룹화와 관련 없는 문자열, 상수, 등은 SELECT 절에 표현 될 수 있다 (에러 아님);
SELECT deptno, 'TEST', 1,
        MAX(sal), --부서별로 가장 높은 급여 값
        MIN(sal), --부서별로 가장 낮은 급여 값
        ROUND(AVG(sal), 2), --부서별 급여 평균
        SUM(sal), --부서별 급여 합
        COUNT(sal), --부서별 급여 건수(sal 컬럼의 값이 null이 아닌 row의 수)
        COUNT(*),   --부서별 행의 수
        COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP 함수 연산시 NULL 값은 제외가 된다
30번 부서에는 NULL값을 갖는 행이었지만 SUM(COMM)의 값이 정상적으로 계산된 걸 확인 할 수 있다
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10번, 20번 부서의 SUM(COMM) 컬럼이 NULL이 아니라 0이 나오도록 NULL처리
* 특별한 사유가 아니면 그룹함수 계산결과에 NULL 처리를 하는 것이 성능상 유리

NVL(SUM(comm), 0) : COMM컬럼에 SUM 그룹함수를 적용하고 최종 결과에 NVL을 적용(1회 호출)
SUM(NVL(comm, 0)) : 모든 COMM컬럼에 NVL 함수를 적용 후(해당 그룹의 ROW수 만큼 호출) SUM 그룹함수 적용

SELECT deptno, NVL(SUM(comm), 0)
FROM emp
GROUP BY deptno;

single row 함수는 where 절에 기술할 수 있지만
multi row 함수(group 함수)는 where 절에 기술할 수 없고
GROUP BY 절 이후 HAVING 절에 별도로 기술

single row 함수는 WHERE 절에서 사용 가능
SELECT *
FROM emp;
WHERE LOWER(ename) = 'switch';

부서별 급여 할이 5000이 넘는 부서만 조회
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
WHERE SUM(sal) > 9000;


SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--실습 grp1번
SELECT MAX(sal),
       MIN(sal),
       ROUND(AVG(sal),2),
       SUM(sal),
       COUNT(sal),
       COUNT(mgr),
       COUNT(*)
FROM emp;

--실습 grp2번
SELECT deptno,
       MAX(sal),
       MIN(sal),
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal),
       COUNT(sal),
       COUNT(mgr),
       COUNT(*)
FROM emp
GROUP BY deptno;

--실습 grp3번
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES') dname,
       MAX(sal),
       MIN(sal),
       ROUND(AVG(sal),2) avg_sal,
       SUM(sal),
       COUNT(sal),
       COUNT(mgr),
       COUNT(*)
FROM emp
GROUP BY deptno;

--실습 grp4번
SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm');

--실습 grp5번
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');

--실습 grp6번
SELECT COUNT(*) cnt
FROM dept;

--실습 grp7번
SELECT COUNT(deptno)
FROM(SELECT deptno
    FROM emp    
    GROUP BY deptno);






