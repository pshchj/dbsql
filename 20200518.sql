����׷� ���� ���
ROLLUP : �ڿ���(����������) �ϳ��� �������鼭 ����׷��� ����
        ==> (deptno, job), (deptno), (*)        
CUBE : ������ ��� ����
GROUPING SETS : �����ڰ� ����׷� ������ ���� ���

sub_a2]
DROP TABLE dept_test;

SELECT *
FROM dept;

DELETE DEPT
WHERE deptno NOT IN (10, 20, 30, 40);

CREATE TABLE dept_test AS
SELECT *
FROM dept;

INSERT INTO dept_test values(99, 'it1', 'daejeon');
INSERT INTO dept_test values(98, 'it2', 'daejeon');

DELETE dept_test 
WHERE NOT EXISTS (SELECT 'X'
                  FROM emp
                  WHERE emp.deptno = dept_test.deptno);
sub_a3]

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

UPDATE emp_test m SET sal = sal + 200
WHERE sal < (SELECT AVG(sal)
             FROM emp_test s
             WHERE m.deptno = s.deptno);


���Ŀ��� �ƴ�����, �˻�-������ ���� ������ ǥ��
���������� ���� ���
1. Ȯ���� : ��ȣ���� �������� (EXISTS)
           ==> ������������ ���� ==> �������� ����
2. ������ : ���������� ���� ����Ǽ� ���������� ���� ���� ���ִ� ����


13�� : �Ŵ����� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IN (SELECT empno
              FROM emp);

�μ��� �޿������ ��ü �޿���պ��� ū �μ��� �μ���ȣ, �μ��� �޿� ��� ���ϱ�

�μ��� ��� �޿�
SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno;

��ü �޿� ���
SELECT ROUND(AVG(sal), 2)
FROM emp;


SELECT deptno, ROUND(AVG(sal), 2)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT ROUND(AVG(sal), 2)
                            FROM emp);


WITH �� : SQL���� �ݺ������� ������ QUERY BLOCK(SUBQUERY)�� ������ �����Ͽ�
          SQL ����� �ѹ��� �޸𸮿� �ε��� �ϰ� �ݺ������� ����� �� �޸� ������ �����͸�
          Ȱ���Ͽ� �ӵ� ������ �� �� �ִ� KEYWORD
          ��, �ϳ��� SQL���� �ݺ����� SQL ���� ������ ���� �߸� �ۼ��� SQL�� ���ɼ��� ���� ������
          �ٸ� ���·� ������ �� �ִ����� ���� �غ��� ���� ��õ.

WITH emp_avg_sal AS(
    SELECT ROUND(AVG(sal), 2)
    FROM emp
)
SELECT deptno, ROUND(AVG(sal), 2), (SELECT * FROM emp_avg_sal)
FROM emp
GROUP BY deptno
HAVING ROUND(AVG(sal), 2) > (SELECT *
                            FROM emp_avg_sal);
                            

��������
CONNECT BY LEVEL : ���� �ݺ��ϰ� ���� ����ŭ ������ ���ִ� ���
��ġ : FROM(WHERE) �� ������ ���
DUAL ���̺�� ���� ���

���̺� ���� �Ѱ�, �޸𸮿��� ����
SELECT LEVEL
FROM dual
CONNECT BY LEVEL <= 5;

���� ���� ���� �̹� ��� KEYWORD�� �̿��Ͽ� �ۼ� ����
5�� �̻��� �����ϴ� ���̺��� ���� ���� ����
���࿡ �츮�� ������ �����Ͱ� 10000���̸��� 10000�ǿ� ���� DISK I/O�� �߻�
SELECT ROWNUM
FROM emp
WHERE ROWNUM <= 5;


1. �츮���� �־��� ���ڿ� ��� : 202005
   �־��� ����� �ϼ��� ���Ͽ� �ϼ��� ���� ����
   
�޷��� �÷��� 7�� - �÷��� ������ ���� : Ư�����ڴ� �ϳ��� ���Ͽ� ����  
SELECT TO_DATE('202005', 'YYYYMM') + LEVEL - 1 dt,
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD');

SELECT TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD')
FROM dual;

�Ʒ� ������� SQL�� �ۼ��ص� ������ �ϼ��ϴ°� �����ϳ�
������ ���鿡�� �ʹ� �����Ͽ� �ζ��κ並 �̿��Ͽ� ������ ���� �ܼ��ϰ� �����
SELECT TO_DATE('202005', 'YYYYMM') + LEVEL - 1 dt,
        DECODE....
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD');

�÷��� ����ȭ �Ͽ� ǥ��
TO_DATE('202005, 'YYYYMM') + (LEVEL-1) ==> dt

SELECT dt dt�� �������̸�,... 7���� �÷��߿� ���ϳ��� �÷����� dt
FROM
(SELECT TO_DATE('202005', 'YYYYMM') + LEVEL - 1 dt
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'DD'));


SELECT MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed, MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, 
       MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + LEVEL - 1 dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
 

SELECT *
FROM sales;

�޷� ����1]
 SELECT NVL(MIN(DECODE(TO_CHAR(dt, 'MM'), 01 , SUM(sales), '')), 0) JAN,
        NVL(MIN(DECODE(TO_CHAR(dt, 'MM'), 02 , SUM(sales), '')), 0) FEB,
        NVL(MIN(DECODE(TO_CHAR(dt, 'MM'), 03 , SUM(sales), '')), 0) MAR,
        NVL(MIN(DECODE(TO_CHAR(dt, 'MM'), 04 , SUM(sales), '')), 0) APR,
        NVL(MIN(DECODE(TO_CHAR(dt, 'MM'), 05 , SUM(sales), '')), 0) MAY,
        NVL(MIN(DECODE(TO_CHAR(dt, 'MM'), 06 , SUM(sales), '')), 0) JUN
 FROM sales
 GROUP BY TO_CHAR(dt, 'MM');
 
 
�޷� ����2]
SELECT DECODE(d, 1, iw+1, iw),
       MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed, MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri, 
       MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + LEVEL - 1 dt,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'd') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD'))
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);

