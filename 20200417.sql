SELECT ���� ���� :
    ��¥ ����(+, -) : ��¥ + ����, -���� : ��¥���� +-������ �� ���� Ȥ�� �̷������� ����Ʈ Ÿ�� ��ȯ
    ���� ����(....) : �����ð��� �ٷ��� ����.
    ���ڿ� ����
        ���ͷ� : ǥ����
                 ���� ���ͷ� : ���ڷ� ǥ��
                 ���� ���ͷ� : java : "���ڿ�" / sql : 'sql'
                    ���ڿ� ���տ��� : +�� �ƴ϶� || (java ������ +)
                 ��¥?? : TO_DATE("��¥���ڿ�", "��¥ ���ڿ��� ���� ����")
                         TO_DATE('20170417', 'yyyymmdd')
--���� �ǽ�--              
                         
WHERE : ����� ���ǿ� �����ϴ� �ุ ��ȸ �ǵ��� ����;

SELECT *
FROM users
WHERE userid = 'brown';


sal���� 1000���� ũ�ų� ����, 2000���� �۰ų� ���� ������ ��ȸ ==> BETWEEN AND
�񱳴�� �÷� / �� BETWEEN ���۰� AND ���ᰪ
���۰��� ���ᰪ�� ��ġ�� �ٲٸ� ���� �������� ����

sal >= 1000
sal <= 2000

SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

exclusive or (��Ÿ�� or)
a or b  a=true, b=true ==> true
a exclusive or b  a=true, b=true ==> false

SELECT *
FROM emp
WHERE sal >= 1000
  AND sal <= 2000;

--�ǽ� 1--
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '19820101' AND '19830101';


IN ������
�÷�: Ư���� IN(��1,��2,.....)
�÷��̳� Ư������ ��ȣ�ȿ� ���߿� �ϳ��� ��ġ�� �ϸ� TRUE

SELECT *
FROM emp
WHERE deptno IN (10,30);
==> deptno�� 10�̰ų� 30���� ����
deptno = 10 OR deptbo = 30

SELECT *
FROM emp
WHERE deptno = 10  
   OR deptno = 30;

SELECT *
FROM users;

--�ǽ�3
SELECT USERID "���̵�", USERNM "�̸�", ALIAS "����"
FROM users
WHERE userid IN('brown','cony','sally');

���ڿ� ��Ī ���� : LIKE ���� / JAVA :.startWith, .endWith(surffix)
����ŷ ���ڿ� : % - ��� ���ڿ�(���� ����)
              _ - � ���ڿ��̵��� �� �ϳ��� ����
���ڿ��� �Ϻΰ� ������ TRUE

�÷�: Ư���� LIKE ���ڿ�

'cony' : cony�� ���ڿ�
'co%'  : ���ڿ��� co�� �����ϰ� �ڿ��� � ���ڿ��̵� �� ���ִ� ���ڿ�
        'cony', 'con', 'co'
'%co%  : 'co'�� �����ϴ� ���ڿ�
         'cony', 'sally cony'
'co__' : co�� �����ϰ� �ڿ� �ΰ��� ���ڰ� ���� ���ڿ�
'_on_' : ��� �α��ڰ� on�̰� �յڷ� � ���ڿ� �̵��� �ϳ��� ���ڰ� �� ���ִ� ���ڿ�

���� �̸�(ename)�� �빮�� s�� �����ϴ� ������ ��ȸ
SELECT *
FROM emp
WHERE ename LIKE 'S%';

--�ǽ� 4��
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--�ǽ� 5��
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

NULL ��
SQL �񱳿����� : 
  WHERE usernm = 'brown'
  
MGR�÷� ���� ���� ��� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr = null;

SQL���� NULL ���� ���� ��� �Ϲ�����
�񱳿�����(=)�� ��� ���ϰ� IS �����ڸ� ���

SELECT *
FROM emp
WHERE mgr IS null;

���� �ִ� ��Ȳ���� � �� : =, !=, <>
NULL : IS NULL , IS NOT NULL

emp���̺��� mgr �÷� ���� NULL�� �ƴ� ������ ��ȸ
SELECT *
FROM emp
WHERE mgr IS NOT null;

--�ǽ�6��

SELECT *
FROM emp
WHERE comm IS NOT null;


������ NOT
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839);

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839, NULL);

IN�����ڸ� �� �����ڷ� ����
SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
==> WHERE mgr = 7698 OR mgr = 7839;

SELECT *
FROM emp
WHERE mgr = 7698 OR mgr = 7839;

SELECT *
FROM emp
WHERE mgr != 7698 AND mgr != 7839;

SELECT *
FROM emp
WHERE mgr NOT IN (7698, 7839)
   OR mgr IS NULL;
   
--�ǽ� 7��
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');

--�ǽ� 8��
SELECT *
FROM emp
WHERE deptno != 10
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');

--�ǽ� 9��
SELECT *
FROM emp
WHERE deptno NOT IN (10)
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');

SELECT *
FROM emp
WHERE deptno IN (20,30)
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');

--�ǽ� 10��
SELECT *
FROM emp
WHERE deptno IN (20,30)
  AND hiredate >= TO_DATE('19810601', 'yyyymmdd');

--�ǽ� 11��
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
   OR hiredate >= TO_DATE('19810601', 'yyyymmdd');
   
--�ǽ� 12��
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
   OR empno LIKE '78%';
   
--�ǽ� 13��
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
   OR empno >= 7800 AND empno < 7900;   
   
--�ǽ� 14��
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
   OR empno LIKE '78%'
   AND hiredate >= TO_DATE('19810601', 'yyyymmdd');
   
  table���� ��ȸ, ����� ������ ����(�������� ����)
  ==> ���нð��� ���հ� ������ ����
  
  SQL������ �����͸� �����Ϸ��� ������ ������ �ʿ�
  ORDER BY �÷���, �÷���2 [��������]...
  
������ ���� : ��������(DEfAULT) - ASC, �������� - DESC
  
���� �̸����� �������� ����
SELECT *
FROM emp
ORDER BY ename ASC; 

���� �̸����� �������� ����
SELECT *
FROM emp
ORDER BY ename DESC;

job�� �������� �������� �����ϰ� job�� ������� �Ի����ڷ� �������� ����
��� ������ ��ȸ
SELECT *
FROM emp
ORDER BY job ASC, hiredate DESC; 


   
  
  
  