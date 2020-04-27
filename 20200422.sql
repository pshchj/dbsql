EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno='7369';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);

Plan hash value: 3956160932
 
 �����ȹ�� ���� ����(id)
 * �鿩���� �Ǿ������� �ڽ� ���۷��̼�(��ĭ �� ���۷��̼�)
 1. ������ �Ʒ���
    *�� �ڽ� ���۷��̼��� ������ �ڽ� ���� �д´�
    1�� ==> 0�� ������ �д´�. 
    �����ȣ 7369���� ���� �������� ���ȴ�
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
 
 
--�ǽ� ����4
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7300 + '69';

SELECT *
FROM TABLE(DBMS_XPLAN.DISPLAY);
 
--��� 
SELECT ename, sal, TO_CHAR(sal , 'L009,999.00')
FROM emp;

NULL�� ���õ� �Լ�
NVL
NVL2
NULLIF
COALESCE;

�� NULL ó���� �ؾ��ұ�?
NULL�� ���� �������� NULL�̴�

���� �� emp ���̺� �����ϴ� sal, comm �ΰ��� �÷� ���� ���� ���� �˰� �;
������ ���� SQL�� �ۼ�.

SELECT empno, ename, sal, comm, sal + NVL(comm, 0) sal_plus_comm
FROM emp;

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





