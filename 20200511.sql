�θ�-�ڽ� ���̺� ����

1. ���̺� ������ ����
  1] �θ� (dept)
  2] �ڽ� (emp)
  
2. ������ ������(insert) ����
  1] �θ� (dept)
  2] �ڽ� (emp)
  
3. ������ ������(delete) ����
  1] �ڽ� (emp)
  2] �θ� (dept)
  
���̺� �����(���̺��� �̹� �����Ǿ� �ִ� ���) �������� �߰� ����
DROP TABLE emp_test;

CREATE TABLE emp_test(
 empno NUMBER(4),
 ename VARCHAR2(10),
 deptno NUMBER(2)
);

���̺� ������ ���������� Ư���� �������� ����

���̺� ������ ���� PRIMARY KEY �߰�

���� : ALTER TABLE ���̺��� ADD CONSTRAINT �������Ǹ� �������� Ÿ�� (������ �÷�[, ]);
�������� Ÿ�� : PRIMARY KEY, UNIQUE, FOREIGN KEY, CHECK

ALTER TABLE emp_test ADD CONSTRAINT pk_emp_test PRIMARY KEY (empno) ;

���̺� ����� �������� ����
���� : ALTER TABLE ���̺� �̸� DROP CONSTRAINT �������Ǹ�;

������ �߰��� �������� pk_emp_test ����
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;


���̺� �������� �ܷ�Ű �������� �߰� �ǽ�
emp_test.deptno ===> dept_test_deptno

dept_test ���̺��� deptno�� �ε��� ���� �Ǿ��ִ��� Ȯ��

ALTER TABLE dept_test ADD CONSTRAINT �������� �� �������� Ÿ�� (�÷�) REFERENCES �������̺� �� (�������̺� �÷���);

ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno);

������ ����;


�������� Ȱ��ȭ ��Ȱ��ȭ
���̺��� ������ ���������� ���� �ϴ� ���� �ƴ϶� ��� ����� ����, Ű�� ����
���� : ALTER TABLE ���̺��� ENABLE | DISABLE CONSTRAINT �������� ��;

������ ������ fk_emp_test_dept_test FOREIGN KEY ���������� ��Ȱ��ȭ

ALTER TABLE emp_test DISABLE CONSTRAINT fk_emp_test_dept_test;

dept(�θ�)���̺����� 99�� �μ��� �����ϴ� ��Ȳ
SELECT *
FROM dept_test;

fk_emp_test_dept_test ���������� ��Ȱ��ȭ�Ǿ� �ֱ� ������ emp_test ���̺����� 99�� �μ� �̿���
���� �Է� ������ ��Ȳ

dept_test ���̺��� 88�� �μ��� ������ �Ʒ� ������ ���������� ����
INSERT INTO emp_test VALUES (9999, 'brown', 88);


���� ��Ȳ : emp_test ���̺��� dept_test ���̺��� �������� �ʴ� 88�� �μ��� ����ϰ� �ִ� ��Ȳ
           fk_emp_test_dept_test ���������� ��Ȱ��ȭ�� ����
           
�������� ���Ἲ�� ���� ���¿��� fk_emp_test_dept_test�� Ȱ��ȭ ��Ű��???
==> ������ ���Ἲ�� ��ų �� �����Ƿ� Ȱ��ȭ �� �� ����

ALTER TABLE emp_test ENABLE CONSTRAINT fk_emp_test_dept_test;


emp, dept ���̺����� ���� PRIMARY KEY, FOREIGN KEY ������ �ɷ� ���� ���� ��Ȳ
emp ���̺��� empno�� key��
dept ���̺��� deptno�� key�� �ϴ� PRIMARY KEY ������ �߰��ϰ�

emp.deptno ==> dept.deptno�� �����ϵ��� FOREIGN KEY�� �߰�

���� ���� ���� �����ð��� �ȳ��� ������� ����
ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);

ALTER TABLE emp ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);


�������� Ȯ��
�ѿ��� �������ִ� �޴�(���̺� ���� ==> �������� tab)
USER_CONSTRAINTS : �������� ����(MASTER);

USER_CONS_COLUMNS : �������� �÷� ����(��);

SELECT *
FROM USER_CONSTRAINTS;

�÷�Ȯ��
��
SELECT *
DESC
USER_TAB_COLUMNS;(data dictionary, ����Ŭ���� ���������� �����ϴ� view);

SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'EMP';


���̺�, �÷� �ּ� : USER_TAB_COMMENTS, USER_COL_COMMENTS;

SELECT *
FROM user_tab_comments;

���� ���񽺼� ���Ǵ� ���̺��� ���� ���ʰ��� ������ �ʴ� ��찡 ����


���̺��� �ּ� �����ϱ�
���� : COMMENT ON TABLE ���̺��� IS '�ּ�';
emp ���̺��� �ּ� �����ϱ�
COMMENT ON TABLE emp IS '����';

SELECT *
FROM user_tab_comments;

�÷��ּ� Ȯ��
SELECT *
FROM user_col_comments
WHERE TABLE_NAME = 'EMP';

�÷� �ּ� ����
COMMENT ON COLUMN ���̺���.�÷��� IS '�ּ�';

empno : ���, ename �̸�, hiredate �Ի����� ���� �� user_col_comments�� ���� Ȯ��
COMMENT ON COLUMN emp.deptno IS '���';
COMMENT ON COLUMN emp.ename IS '�̸�';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';


--table - comments �ǽ� 1
COMMENT ON TABLE customer IS '����';
COMMENT ON COLUMN customer.cid IS '������ȣ';
COMMENT ON COLUMN customer.cnm IS '������';
COMMENT ON TABLE cycle IS '���������ֱ�';
COMMENT ON COLUMN cycle.cid IS '������ȣ';
COMMENT ON COLUMN cycle.pid IS '��ǰ��ȣ';
COMMENT ON COLUMN cycle.day IS '����';
COMMENT ON COLUMN cycle.cnt IS '����';
COMMENT ON TABLE daily IS '�Ͻ���';
COMMENT ON COLUMN daily.cid IS '������ȣ';
COMMENT ON COLUMN daily.pid IS '��ǰ��ȣ';
COMMENT ON COLUMN daily.dt IS '����';
COMMENT ON COLUMN daily.cnt IS '����';
COMMENT ON TABLE product IS '��ǰ';
COMMENT ON COLUMN product.pid IS '��ǰ��ȣ';
COMMENT ON COLUMN product.pnm IS '��ǰ��';

SELECT t.*, c.column_name, c.comments col_comment
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name = c.table_name
  AND t.table_name IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');
  
=(equal) �����ڸ� ���� ==> IN


View �� ������
�������� ������ ���� = SQL
�������� ������ ������ �ƴϴ�

view ��� �뵵
  . ������ ����(���ʿ��� �÷� ������ ����)
  . ���ֻ���ϴ� ������ ���� ����
    . IN-LINE VIEW�� ����ص� ������ ����� 


view�� �����ϱ� ���ؼ��� CREATE VIEW ������ ���� �־�� �Ѵ� (DBA����)

SYSTEM ������ ����
GRANT CREATE VIEW TO ����������� �ο��� ������;

���� : CREATE [OR REPLACE] VIEW ���̸� [�÷���Ī1, �÷���Ī2....] AS
         SELECT ����;
 
 emp���̺����� sal, comm �÷��� ������ 6���� �÷��� ��ȸ�� ������ v_emp view�� ����
 
 CREATE OR REPLACE VIEW v_emp AS 
 SELECT empno, ename, job, mgr, hiredate, deptno
 FROM emp;

 view (v_emp)�� ���� ������ ��ȸ
 SELECT *
 FROM v_emp;
 
 v_emp view�� sem ���� ����
 HR�������� �λ� �ý��� ������ ���ؼ� EMP���̺��� �ƴ� SAL, COMM ��ȸ�� ���ѵ�
 v_emp view�� ��ȸ�� �� �ֵ��� ������ �ο�
 
 [hr �������� ����]���Ѻο� �� hr �������� v_emp ��ȸ
 SELECT *
 FROM sem.v_emp;
 
 psh�������� hr�������� v_emp view�� ��ȸ�� �� �ִ� ���� �ο�
 
 GRANT SELECT ON v_emp TO hr;
 
 [hr �������� ����] v_emp view ������ hr ������ �ο��� ���� ��ȸ �׽�Ʈ
 SELECT *
 FROM PSH.v_emp;
 
 
 �ǽ�
 v_emp_dept �並 ����
 emp, dept ���̺��� deptno�÷����� �����ϰ�
 emp.empno, ename, dept.deptno, dname 4���� �÷����� ����
 
 CREATE OR REPLACE VIEW v_emp_dept AS 
 SELECT emp.empno, ename, dept.deptno, dname
 FROM emp JOIN dept ON emp.deptno = dept.deptno;
 
 SELECT *
 FROM v_emp_dept;
 
 
 VIEW ����
 ���� : DROP VIEW ������ �� �̸�;
 
 DROP VIEW v_emp;
 
 
 VIEW�� ���� DML ó��
 SIMPLE VIEW�� ���� ����
 
 SIMPLE VIEW : ���ε��� �ʰ�, �Լ� , GROUP BY, ROWNUM�� ������� ���� ������ ������ VIEW
 COMPLEX VIEW : SIMPLE VIEW�� �ƴ� ����
 
 V_emp : simple view
 
 SELECT *
 FROM v_emp;

 v_emp�� ���� '7369' SMITH ����� �̸��� brown���� ����
 UPDATE v_emp SET ename = 'brown'
 WHERE empno = 7369;
 
 v_emp �÷����� sal �÷��� �������� �ʱ� ������ ����
 UPDATE v_emp SET sal = 1000
 WHERE empno = 7369;

 ROLLBACK;
 
 
 SEQUENCE
 ������ �������� �������ִ� ����Ŭ ��ü
 ���� �ĺ��� ���� ������ �� �ַ� ���
 
 �ĺ��� ==> �ش� ���� �����ϰ� ������ �� �ִ� ��
 ���� <=> ���� �ĺ���
 
 ���� : ���� �׷��� ��.
 ���� : �ٸ糽 ��.
 
 �Ϲ������� � ���̺�(����Ƽ)�� �ĺ��ڸ� ���ϴ� �����
 [����], [����], [������]
 
 �Խ����� �Խñ� : �Խñ� �ۼ��ڰ� ���� ����� �ۼ� �ߴ���
 �Խñ��� �ĺ��� : �ۼ���id, �ۼ�����, ������    
    ==> ���� �ĺ��ڰ� �ʹ� �����ϱ� ������ ������ ���̼��� ����
        ���� �ĺ��ڸ� ��ü�� �� �ִ� (�ߺ����� �ʴ�) ���� �ĺ��ڷ� ���
    
 ������ �ϴٺ��� ������ ���� �����ؾ� �� ���� ����
 ex : ���, �й�, �Խñ� ��ȣ
      ���, �й� : ü��
      ��� : 15101001 - ȸ�� �������� 15, 10�� 10��, �ش� ��¥�� ù��° �Ի��� ��� 01
      �й� : ...
      
      �Խñ� ��ȣ : ü�谡...., ��ġ�� �ʴ� ����
      ü�谡 ���°��� �ڵ�ȭ�� ���� ==> SEQUENCE ��ü�� Ȱ���Ͽ� �ս��� ���� ����
                                      ==> �ߺ����� �ʴ� ���� ���� ��ȯ
      
  
 �ߺ����� �ʴ� ���� �����ϴ� ���
 1. KEY table�� ����
    ==> SELECT FOR UPDATE �ٸ� ����� ���ÿ� ������� ���ϵ��� ���°� ����
    ==> ���� ���� ���� ��, ������ ���� �̻ڰ� �����ϴ°� ����(SEQUENCE ������ �Ұ���)
     
 2. JAVA�� UUID Ŭ������ Ȱ��, ������ ���̺귯�� Ȱ��(����) ==> ������, ����, ī��
  
  
 SEQUENCE ����
 ���� : CREATE SEQUENCE ������ ��;
 
 seq_emp��� �������� ����
 CREATE SEQUENCE seq_emp;
 
 ���� : ��ü���� �������ִ� �Լ��� ���ؼ� ���� �޾ƿ´�
 NEXTVAL : �������� ���� ���ο� ���� �޾ƿ´�
 CURRVAL : ������ ��ü�� NEXTVAL�� ���� ���� ���� �ٽ��ѹ� Ȯ���� �� ���
            (Ʈ����ǿ��� NEXTVAL �����ϰ� ���� ����� ����)
    
 SELECT seq_emp.NEXTVAL
 FROM dual;
 
 SELECT seq_emp.CURRVAL
 FROM dual;
 
 SELECT *
 FROM emp_test;
 
 SEQUENCE �� ���� �ߺ����� �ʴ� empno �� �����Ͽ� insert �ϱ�
 INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'sally', 88);
 
 
    
  
  
  
  
  