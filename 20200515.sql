ROLLUP : ����׷� ���� - ����� �÷��� �����ʿ��� ���� ���������� GROUP BY�� ����

�Ʒ� ������ ����׷�
1. GROUP BY job, deptno
2. GROUP BY job
3. GROUP BY ==> ��ü

ROLLUP ���� �����Ǵ� ����׷��� ���� : ROLLUP�� ����� �÷��� + 1;

�ǽ� GROUP_AD2]

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT GROUPING(job), deptno, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT CASE WHEN GROUPING(job) = 1 THEN '�Ѱ�'
            ELSE job END job,
            deptno, SUM(sal) 
FROM emp
GROUP BY ROLLUP (job, deptno);

�ǽ� GROUP_AD2-1]
SELECT CASE WHEN GROUPING(job) = 1 THEN '�Ѱ�'
            ELSE job
            END job,
       CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '��'
            WHEN GROUPING(deptno) = 1 THEN '�Ұ�'
            ELSE TO_CHAR(deptno)
            END deptno,
           SUM(sal) 
FROM emp
GROUP BY ROLLUP (job, deptno);


�ǽ� GROUP_AD3]
SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

ROLLUP ���� ��� �Ǵ� �÷��� ������ ��ȸ ����� ������ ��ģ��
(****** ���� �׷��� ����� �÷��� ������ ���� ������ �����鼭 ����)
GROUP BY ROLLUP (deptno, job);
GROUP BY ROLLUP (job, deptno);


REPORT GROUPING FUNCTION ==> Ȯ��� GROUP BY
REPORT GROUPING FUNCTION�� ����� ���ϸ�
�������� SQL�ۼ�, UNION ALL�� ���ؼ� �ϳ��� ����� ��ġ�� ����
==> ���� ���ϰ� �ϴ°� REPORT GROUP FUNCTION


�ǽ� GROUP_AD4]
SELECT dept.dname, emp.job, SUM(emp.sal)
FROM emp LEFT OUTER JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dept.dname, emp.job);

�ǽ� GROUP_AD5]
SELECT NVL(dept.dname, '�Ѱ�'), emp.job, SUM(emp.sal)
FROM emp LEFT OUTER JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dept.dname, emp.job);


2.GROUPING SET
ROLLUP�� ���� : ���ɾ��� ����׷쵵 ���� �ؾ��Ѵ�
               ROLLUP���� ����� �÷��� �����ʿ��� ���������� ������
               ���� �߰������� �մ� ����׷��� ���ʿ� �� ��� ����.
GROUPING SETS : �����ڰ� ���� ������ ����׷��� ���
                ROLLUP���� �ٸ��� ���⼺�� ����
���� : GROUP BY GROUPING SETS (col1, col2)
GROUP BY col1
UNION ALL
GROUP BY COL2

SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY GROUPING SETS(job, deptno);

�׷������ 
1. job, deptno
2. mgr

GROUP BY GROUPING SETS((job, deptno), mgr);

SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);


3.CUBE
���� : GROUP BY CUBE (col1, col2...)
����� �÷����� ������ ��� ���� (������ ��Ų��)

GROUP BY CUBE (job, deptno);
  1       2
job     deptno
job       x
 x      deptno
 x        x


SELECT job, deptno, SUM(sal)
FROM emp
GROUP BY CUBE(job, deptno);

�������� REPORT GROUP ����ϱ�
SELECT job, deptno, mgr, SUM(sal)
FROM emp
GROUP BY job, ROLLUP(deptno), CUBE(mgr);

**�߻� ������ ������ ���
1       2       3
job    deptno   mgr ==> GROUP BY job, deptno, mgr
job    x        mgr ==> GROUP BY job, mgr
job    deptno   x   ==> GROUP BY job, deptno
job    x        x   ==> GROUP BY job


��ȣ���� �������� ������Ʈ
1. emp���̺��� �̿��Ͽ� emp_test ���̺� ����
    ==> ������ ������ emp_test ���̺� ���� ���� ����
DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

2. emp_test ���̺� dname�÷� �߰�(dept ���̺� ����)
DESC dept;
ALTER TABLE emp_test ADD (dname VARCHAR2(14));
DESC emp_test;

3. subquery�� �̿��Ͽ� emp_test ���̺� �߰��� dname�÷��� ������Ʈ ���ִ� �����ۼ�
emp_test�� dname �÷��� ���� dept ���̺��� dname �÷����� update
emp_test ���̺��� deptno ���� Ȯ���ؼ� dept ���̺��� deptno���̶� ��ġ�ϴ� dname �÷����� ������ update

 emp_test�� dname �÷��� dept ���̺��� �̿��ؼ� dname���� ��ȸ�Ͽ� ������Ʈ
 update ����� �Ǵ� �� : 14 ==> WHERE ���� ������� ����
 
 ��������� ������� dname �÷��� dept ���̺��� ��ȸ�Ͽ� ������Ʈ
 UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE emp_test.deptno = dept.deptno);
SELECT *
FROM emp_test;

--subquery update �ǽ� sub_a1
DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

DESC dept_test;

ALTER TABLE dept_test ADD (empcnt NUMBER(2));

UPDATE dept_test SET empcnt = (SELECT COUNT(*)
                               FROM emp
                               WHERE emp.deptno = dept_test.deptno);

SELECT *
FROM dept_test;

SELECT ��� ��ü�� ������� �׷� �Լ��� ������ ���
���Ǵ� ���� ������ 0���� ����
SELECT COUNT(*)
FROM emp
WHERE 1 = 2 ;

GROUP BY ���� ����� ��� ����� �Ǵ� ���� ���� ��� ��ȸ�Ǵ� ���� ����