select *    --��� �÷������� ��ȸ
FROM prod;  --������ ��ȸ�� ���̺� ���

--Ư�� �÷��� ���ؼ��� ��ȸ : select �ķ�1, �÷�2....
--prod_id, prod_name�÷��� prod ���̺��� ��ȸ;

select prod_id, prod_name
FROM prod;

--select �ǽ����� 1��
select *
FROM prod;

select buyer_id, buyer_name
FROM buyer;

select *
FROM cart;

select mem_id, mem_pass, mem_name
FROM member;

SQL ���� : JAVA�� �ٸ��� ���� x, �Ϲ��� ��Ģ����
int b = 2;    = ���� ������, == ��

SQL ������ Ÿ�� : ����, ����, ��¥(data);


USERS ���̺��� (4/14 ����� ����) ����
USERS ���̺��� ��� �����͸� ��ȸ;

select *
FROM USERS;

��¥ Ÿ�Կ� ���� ���� : ��¥�� +, - ���� ����
data type + ���� : data���� ������¥��ŭ �̷� ��¥�� �̵�
data type - ���� : data���� ������¥��ŭ ���� ��¥�� �̵�

select userid, reg_dt + 5
FROM users;

select userid, reg_dt + 5 after_5days, reg_dt -5
FROM users;

;
�÷� ��Ī : ���� �÷����� ���� �ϰ� ���� ��
syntax : ���� �÷��� [as] ��Ī ��Ī
��Ī ��Ī�� ������ ǥ���Ǿ�� �� ��� ���� �����̼����� ���´�
���� ����Ŭ������ ��ü���� �빮�� ó�� �ϱ� ������ �ҹ��ڷ� ��Ī�� �����ϱ� ���ؼ���
���� �����̼��� ����Ѵ�

select userid as id, userid id2, userid "�� �� ��"
FROM users;

-- column alias (�ǽ� select2)
select prod_id id, prod_name name
FROM prod;

select lprod_gu gu, lprod_nm nm
FROM lprod;

select buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;


���ڿ� ����(���տ���) : ||  (���ڿ� ������ + �����ڰ� �ƴϴ�);
String str = "Hello";
str = str + ", world" --str : hello, world
SELECT /*userid 'test'*/ userid || 'test', reg_dt + 5, 'test', 15
FROM users;

�� �̸� ��
SELECT '�� ' || userid || ' ��'
FROM users;

SELECT userid || usernm
FROM users;

SELECT userid || usernm id_name
FROM users;


SELECT userid || usernm AS id_name
       CONCAT(userid, usernm) AS concat_id_name
FROM users;


--���ڿ� ���� �ǽ� sel_con1
1 + 3 + 5
user_tables : oracle �����ϴ� ���̺� ������ ��� �ִ� ���̺�(view) ==> data dictionary
SELECT 'SELECT * FROM ' || table_name AS QUERY
FROM user_tables;


���̺��� ���� �÷��� Ȯ��
1. tool(sql developer)�� ���� Ȯ��
   ���̺� - Ȯ���ϰ��� �ϴ� ���̺�

2. SELECT *
   FROM ���̺�
   �ϴ� ��ü ��ȸ; --> ��� �÷��� ǥ��

3. DESC ���̺��

DESC emp;

4. data dictionary : user_tab_columns

SELECT *
FROM user_tab_columns;

���ݱ��� ��� SELECT ����
��ȸ�ϰ��� �ϴ� �÷� ��� : SELECT
��ȸ�� ���̺� ��� : FROM
��ȸ�� ���� �����ϴ� ������ ��� : WHERE
WHERE ���� ����� ������ ��(TRUE)�� �� ����� ��ȸ
sql�� �� ���� : =

SELECT *
FROm users
WHERE userid = 'cony';

emp���̺��� �÷��� ������ Ÿ���� Ȯ��;
DESC emp;

'1234', 1234

SELECT *
FROM emp;

emp : employee
empno : �����ȣ
ename : ����̸�
job : ������
mgr : �����(������)
hiredate : �Ի�����
sal : �޿�
comm : ������
deptno : �μ���ȣ

SELECT *
FROM dept;


emp ���̺��� ������ ���� �μ���ȣ�� 30������ ū �μ��� ���� ������ ��ȸ;
SELECT *
FROM emp
WHERE deptno >= 30;

!= �ٸ� ��
users ���̺��� ����� ���̵�(userid)�� brown�� �ƴ� ����ڸ� ��ȸ

SELECT *
FROM users
WHERE userid != 'brown';


SQL ���ͷ� 
���� : .... 20, 30.5
���� : �̱� �����̼� : 'hello world'
��¥ : TO_DATE('��¥���ڿ�', '��¥ ���ڿ��� ����');

1982�� 1�� 1�� ���Ŀ� �Ի��� ������ ��ȸ
������ �Ի����� : hiredate �÷�

SELECT *
FROM emp
WHERE hiredate >= TO_DATE('19820101', 'YYYYMMDD');
 
