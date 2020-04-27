NVL(expr1, expr2)
expr�� null�̸� expr2���� �����ϰ�
expr1�� null�� �ƴϸ� expr1�� ����

REG_DT �÷��� NULL�� ��� ���� ��¥�� ���� ���� ������ ���ڷ� ǥ��
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
    
sal�÷��� ���� 3000�̸� null�� ����    
SELECT empno, ename, sal, NULLIF(sal, 3000)
FROM emp;

�������� : �Լ��� ������ ������ ������ ���� ����
          �������ڵ��� Ÿ���� ���� �ؾ���
          
���ڵ� �߿� ���� ���� ������ null�� �ƴ� ����
coalesce(expr1, expr2.....)
if expr1 != null
    return expr1
else 
    coalesce(expr2, expr3.....)
    
mgr �÷� null
comm �÷� null

SELECT empno, ename, comm, sal, coalesce(comm, sal)
FROM emp;

SELECT empno, ename, MGR, NVL(mgr, 9999) MGR_1, NVL2(mgr, mgr, 9999) MGR_2, coalesce(mgr, mgr, 9999) MGR_3
FROM emp;

SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) n_reg_dt
FROM users;

����ȭ ==> os���� �ٸ� os ��ġ
1. �ϵ���� �ڿ��� �̾ƸԴ´�.
2. oracle mac �÷����� ���� X

condition 
���ǿ� ���� �÷� Ȥ�� ǥ������ �ٸ� ������ ��ü
java if, switch ���� ����
1. case ����
2. decode �Լ�

1. CASE
CASE
    WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��
    [WHEN ��/������ �Ǻ��� �� �ִ� �� THEN ������ ��]
    [ELSE ������ �� (�Ǻ����� ���� WHEN ���� ������� ����)]

END

emp ���̺� ��ϵ� �����鿡�� ���ʽ��� �߰������� ������ ����
�ش� ������ job�� SALESMAN�� ��� SAL���� 5% �λ�� �ݾ��� ���ʽ��� ���� (ex: sal 100 -> 105)
�ش� ������ job�� MANAGER�� ��� SAL���� 10% �λ�� �ݾ��� ���ʽ��� ���� 
�ش� ������ job�� PRESIDENT�� ��� SAL���� 20% �λ�� �ݾ��� ���ʽ��� ���� 
�� �� �������� sal ��ŭ�� ����

SELECT empno, ename, job, sal, 
       CASE
            WHEN job = 'SALESMAN' THEN sal *1.05
            WHEN job = 'MANAGER' THEN sal *1.10
            WHEN job = 'president' THEN sal *1.20
            ELSE sal * 1
       END bonus
FROM emp;

2. DECODE(EXPR1, search1, return1, search2, return2, search3, return3....., (default)
if EXPR1 == search1
    return return1
else if EXPR1 == search2
    return return2
else if EXPR1 == search3
    return return3
.....
else
    return default;
    
    
SELECT empno, ename, job, sal,
       DECODE(job, 'SALESMAN', sal*1.05,
                    'MANAGER', sal*1.10,
                    'PRESIDENT', sal*1.20,
                    sal) bonus
FROM emp;

SELECT empno, ename, deptno,
       CASE 
            WHEN deptno = 10 THEN 'ACCOUNTING'
            WHEN deptno = 20 THEN 'RESEARCH'
            WHEN deptno = 30 THEN 'SALES'
            WHEN deptno = 40 THEN 'OPERATIONS'
            ELSE 'DDIT'
        END dname
FROM emp;


SELECT empno, ename, deptno, DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES', 40, 'OPERATION', 'DDIT') dname
FROM emp;

--condition �ǽ�2
SELECT empno, ename, hiredate, 
        CASE 
            WHEN MOD(TO_CHAR(SYSDATE, 'yyyy') - TO_CHAR(hiredate, 'yyyy'), 2) = 1 THEN '�ǰ����� ������'
            WHEN MOD(TO_CHAR(SYSDATE, 'yyyy') - TO_CHAR(hiredate, 'yyyy'), 2) = 0 THEN '�ǰ����� �����'
            
        END contact_to_doctor
FROM emp;


SELECT userid, usernm, alias, reg_dt,
        CASE
            WHEN MOD(TO_CHAR(SYSDATE, 'yyyy') - TO_CHAR(reg_dt, 'yyyy'), 2) = 0 THEN '�ǰ����� �����'
            WHEN MOD(TO_CHAR(SYSDATE, 'yyyy') - TO_CHAR(reg_dt, 'yyyy'), 2) = 1 THEN '�ǰ����� ������'
            WHEN reg_dt IS NULL THEN '�ǰ����� ������'
        END contact_to_doctor
FROM users;


