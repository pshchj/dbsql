NULLó�� �ϴ� ��� (4���� �߿� ���� ���Ѱɷ� �ϳ� �̻��� ���)
NVL, NVL2...

SELECT NVL(empno, 0) , ename, NVL(sal, 0), NVL(comm, 0)
FROM emp;

�����ȹ : �����ȹ�� ����
          ���� ����
          
emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 -> 105)
�ش� ������ job�� MANAGER�̸鼭 deptno�� 10�̸� SAL���� 30% �λ�� �ݾ��� ���ʽ��� ���� 
                             �� ���� �μ��� ���ϴ� ����� 10% �λ�� �ݾ��� ���ʽ��� ����
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ����
�׿��������� sal��ŭ�� ����

DECODE�� ��� (case �� ��� ����)

�� �� �������� sal ��ŭ�� ����          

SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal*1.05, 
              DECODE(deptno, 10, sal*1.30, sal*1.10),
                   'PRESIDENT', sal*1.20,
                    sal) bonus
FROM emp;

���� A = {10, 15, 18 , 23, 24, 25, 29, 30, 35, 37}
Prime Number �Ҽ� : {23, 29, 37}
��Ҽ� : {10, 15, 18, 24, 25, 30, 35}


GROUP FUNCTION
�������� �����͸� �̿��Ͽ� ���� �׷쳢�� ���� �����ϴ� �Լ�
�������� �Է¹޾� �ϳ��� ������ ����� ���δ�
EX : �μ��� �޿� ���
     emp ���̺��� 14���� ������ �ְ�, 14���� ������ 3���� �μ�(10, 20, 30)�� ���� �ִ�.
     �μ��� �޿� ����� 3���� ������ ����� ��ȯ�ȴ�
     
GROUP BY ����� ���� ���� : SELECT ����� �� �ִ� �÷��� ���ѵ�

SELECT �׷��� ���� �÷�: �׷��Լ�
FROM ���̺�
GROUP BY �׷��� ���� �÷�
[ORDER BY ];

�μ��� ���� ���� �޿� ��

SELECT deptno, ename, MAX(sal)
FROM emp
GROUP BY deptno;

SELECT deptno, sal
FROM emp
ORDER BY deptno;

SELECT deptno,
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� ��
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),   --�μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;


* �׷� �Լ��� ���� �μ���ȣ �� ���� ���� �޿��� ���� ���� ������
  ���� ���� �޿��� �޴� ����� �̸��� �� ���� ����.
   ==> ���� WINDOW/�м� FUNCTION�� ���� �ذ� ����

emp ���̺��� �׷� ������ �μ���ȣ�� �ƴ� ��ü �������� ���� �ϴ� ���
SELECT  MAX(sal), --��ü �����߰��� ���� �޿� ��
        MIN(sal), --��ü ������ ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --��ü ������ �޿� ���
        SUM(sal), --��ü ������ �޿� ��
        COUNT(sal), --��ü ������ �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),   --��ü ���� ��
        COUNT(mgr)  -- mgr �÷��� null�� �ƴ� �Ǽ�
FROM emp;

2020.04.27 ��ǥ �� ���� Ȯ��
GROUP BY ���� ����� �÷���
    SELECT ���� ������ ������ ����� �÷��� �⺻���� �ȳ��´�.
    
GROUP BY ���� ������� ���� �÷���
    SELECT ���� ������ ����� ����� �÷��� ���´�.;
    
�׷�ȭ�� ���� ���� ���ڿ�, ���, ���� SELECT ���� ǥ�� �� �� �ִ� (���� �ƴ�);
SELECT deptno, 'TEST', 1,
        MAX(sal), --�μ����� ���� ���� �޿� ��
        MIN(sal), --�μ����� ���� ���� �޿� ��
        ROUND(AVG(sal), 2), --�μ��� �޿� ���
        SUM(sal), --�μ��� �޿� ��
        COUNT(sal), --�μ��� �޿� �Ǽ�(sal �÷��� ���� null�� �ƴ� row�� ��)
        COUNT(*),   --�μ��� ���� ��
        COUNT(mgr)
FROM emp
GROUP BY deptno;

GROUP �Լ� ����� NULL ���� ���ܰ� �ȴ�
30�� �μ����� NULL���� ���� ���̾����� SUM(COMM)�� ���� ���������� ���� �� Ȯ�� �� �� �ִ�
SELECT deptno, SUM(comm)
FROM emp
GROUP BY deptno;

10��, 20�� �μ��� SUM(COMM) �÷��� NULL�� �ƴ϶� 0�� �������� NULLó��
* Ư���� ������ �ƴϸ� �׷��Լ� ������� NULL ó���� �ϴ� ���� ���ɻ� ����

NVL(SUM(comm), 0) : COMM�÷��� SUM �׷��Լ��� �����ϰ� ���� ����� NVL�� ����(1ȸ ȣ��)
SUM(NVL(comm, 0)) : ��� COMM�÷��� NVL �Լ��� ���� ��(�ش� �׷��� ROW�� ��ŭ ȣ��) SUM �׷��Լ� ����

SELECT deptno, NVL(SUM(comm), 0)
FROM emp
GROUP BY deptno;

single row �Լ��� where ���� ����� �� ������
multi row �Լ�(group �Լ�)�� where ���� ����� �� ����
GROUP BY �� ���� HAVING ���� ������ ���

single row �Լ��� WHERE ������ ��� ����
SELECT *
FROM emp;
WHERE LOWER(ename) = 'switch';

�μ��� �޿� ���� 5000�� �Ѵ� �μ��� ��ȸ
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
WHERE SUM(sal) > 9000;


SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--�ǽ� grp1��
SELECT MAX(sal),
       MIN(sal),
       ROUND(AVG(sal),2),
       SUM(sal),
       COUNT(sal),
       COUNT(mgr),
       COUNT(*)
FROM emp;

--�ǽ� grp2��
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

--�ǽ� grp3��
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

--�ǽ� grp4��
SELECT TO_CHAR(hiredate, 'yyyymm') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyymm');

--�ǽ� grp5��
SELECT TO_CHAR(hiredate, 'yyyy') hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'yyyy');

--�ǽ� grp6��
SELECT COUNT(*) cnt
FROM dept;

--�ǽ� grp7��
SELECT COUNT(deptno)
FROM(SELECT deptno
    FROM emp    
    GROUP BY deptno);






