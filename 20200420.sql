table���� ��ȸ/���� ������ ����
 ==> ORDER BY �÷��� ���Ĺ��,.....
 
 ORDER BY �÷����� ��ȣ�� ���� ����
 ==> SELECT �÷��� ������ �ٲ�ų�, �÷� �߰��� �Ǹ� �����ǵ���� �������� ���� ���ɼ��� ����
 
 
 SELECT�� 3��° �÷��� �������� ����
 SELECT *
 FROM emp
 ORDER BY 3;
 
 ��Ī���� ����
 �÷����ٰ� ������ ���� ���ο� �÷��� ����� ���
 SAL*DEPTNO SAL_DEPT
 
 SELECT empno, ename, sal, deptno, sal*deptno sal_dept
 FROM emp
 ORDER BY sal_dept;
 
 --�ǽ�1
 SELECT *
 FROM dept
 ORDER BY dname ASC;
 
 SELECT *
 FROM dept
 ORDER BY loc DESC;
 
 --�ǽ�2
 SELECT *
 FROM emp
 WHERE comm IS NOT null AND comm != 0
 ORDER BY comm DESC, empno ASC;

--�ǽ�3
SELECT *
 FROM emp
 WHERE mgr IS NOT null 
 ORDER BY job ASC, empno DESC; 
 
 --�ǽ�4
 SELECT *
 FROM emp
 WHERE deptno IN(10, 30) AND sal > 1500
 ORDER BY ename DESC;
 
 
 ����¡ ó���� �ϴ� ����
 1. �����Ͱ� �ʹ� �����ϱ�
   . �� ȭ�鿡 ������ ��뼺�� ��������
   . ���ɸ鿡�� ��������
   
 ����Ŭ���� ����¡ ó�� ��� ==> ROWNUM
 
 ROWNUM : SELECT ������� 1������ ���ʴ�� ��ȣ�� �ο����ִ� Ư�� KEYWORD
 
 SELECT���� *ǥ���ϰ� �޸��� ���� �ٸ� ǥ��(ex. ROWNUM)�� ����Ұ��
 *�տ� � ���̺� ���Ѱ��� ���̺� ��Ī/��Ī�� ����ؾ� �Ѵ�.
 SELECT ROWNUM , e.* 
 FROM emp e;
 
 
 ����¡ ó���� ���� �ʿ��� ����: 
 1.������ ������(10)
 2.������ ���� ����
 
 1-page : 1 ~ 10
 2-page : 11 ~ 20 (11 ~ 14)
 
 1.������ ����¡ ����
 SELECT ROWNUM, empno, ename
 FROM emp
 WHERE ROWNUM BETWEEN 1 AND 10;
 
 2.������ ����¡ ����
 SELECT ROWNUM, empno, ename
 FROM emp
 WHERE ROWNUM BETWEEN 11 AND 20;
 
 ROWNUM�� Ư¡
 1. ORACLE���� ����
   . �ٸ� DBMS�� ��� ����¡ ó���� ���� ������ Ű���尡 ���� (LIMIT)
 2. 1������ ���������� �д°�츸 ����
   ROWNUM BETWEEN 1 AND 10 ==> 1~10
   ROWNUM BETWEEN 11 AND 20 ==> 1~10�� ��ŵ�ϰ� 11~20�� �������� �õ�
 
   WHERE ������ ROWNUM�� ����� ��� ���� ����
   ROWNUM = 1;
   ROWNUM BETWEEN 1 AND N;
   ROWNUM <, <= N (1~N)
   
 SELECT ROWNUM, empno, ename
 FROM emp
 ORDER BY empno;
 
 SELECT ROWNUM, empno, ename
 FROM emp
 ORDER BY ename;
 
 ROWNUM�� ORDER BY ������ ����
 SELECT -> ROWNUM -> ORDER BY
 
 ROWNUM�� ��������� ���� ������ �Ȼ��·� ROWNUM�� �ο��Ϸ��� IN-LINE VIEW �� ����ؾ� �Ѵ�
 ** IN-LINE : ���� ����� �ߴ�.;
SELECT *
FROM
 (SELECT ROWNUM rn, a.*
  FROM
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a ) a
 WHERE rn BETWEEN 1 + (:page - 1) * :pageSize AND :page * :pageSize;
 
 WHERE rn BETWEEN 1 AND 10; 1 PAGE
 WHERE rn BETWEEN 11 AND 20; 2 PAGE
 WHERE rn BETWEEN 21 AND 30; 3 PAGE
 .
 .
 WHERE rn BETWEEN 1+(n-1)*10 AND pageSize * n ; n PAGE
 
 ����
 
SELECT *
FROM
(SELECT empno, ename
 FROM emp
 ORDER BY ename);
 
INLINE-VIEW�� �񱳸� ���� VIEW�� ���� ����(�����н�, ���߿� ���´�)
VIEW - ����

DML - Data Manipulation Language : SELECT, INSERT, UPDATE, DELETE
DDL - Data Definition Language : CREATE, DROP, MODIFY, RENAME

CREATE OR REPLACE VIEW emp_ord_by_ename AS
    SELECT empno, ename
    FROM emp
    ORDER BY ename
;
 
 
 SELECT *
 FROM (SELECT empno, ename
        FROM emp
        ORDER BY ename);

VIEW�� �ۼ��� ����
SELECT *
FROM emp_ord_by_ename;

emp ���̺� �����͸� �߰��ϸ�
in-line view, view�� ����� ������ ����� ��� ������ ������???

���� �ۼ��� ������ ã�ư���
java : �����
SQL : ����� ���� ����

����¡ ó�� ==> ����, ROWNUM
����, ROWNUM�� �ϳ��� �������� ������ ��� ROWNUM���� ������ �Ͽ�
���ڰ� ���̴� ���� �߻� ==> INLINE-VIEW
  ���Ŀ� ���� INLINE-VIEW
  ROWNUM�� ���� INLINE-VIEW
  
 SELECT *
 FROM
 (SELECT ROWNUM rn, a.*
  FROM
  (SELECT empno, ename
  FROM emp
  ORDER BY ename) a)
WHERE rn BETWEEN 10 AND 20;
 
--�ǽ�3
SELECT *
 FROM
 (SELECT ROWNUM rn, a.*
  FROM
  (SELECT empno, ename
  FROM emp
  ORDER BY ename ASC) a)
WHERE rn BETWEEN 10 AND 20;

** �ű� ����
PROD ���̺��� PROD_LGU (��������), PROD_COST(��������)���� �����Ͽ�
����¡ ó�� ������ �ۼ� �ϼ���
�� ������ ������� 5
���ε� ���� ����� ��

SELECT *
 FROM
(SELECT ROWNUM rn, a.*
 FROM
 (SELECT prod_lgu, prod_cost
  FROM prod
  ORDER BY prod_lgu DESC, prod_cost ) a)
WHERE rn BETWEEN 1 + (:page - 1) * :pageSize AND :page * :pageSize;


