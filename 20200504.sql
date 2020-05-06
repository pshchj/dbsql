������

��Ģ ������ : +, -, *, / : ���� ������
���� ������ : ? ==> 1==1 ? true �� �� ���� : false �� �� ����

SQL ������
= : �÷�:ǥ���� = �� ==> ���� ������
  = 1
IN : �÷�:ǥ���� IN (����)
  deptno IN (10,30)
  
EXISTS ������
����� : EXISTS (��������)
���������� ��ȸ����� �Ѱ��̶� ������ TRUE
�߸��� ����� : WHERE deptno EXISTS (��������)

���������� ���� ���� ���� ���������� ���� ����� �׻� ���� �ϱ� ������
emp ���̺��� ��� �����Ͱ� ��ȸ �ȴ�

�Ʒ� ������ ���ȣ ��������
�Ϲ������� EXISTS �����ڴ� ��ȣ���� ���������� ���� ���

EXIST �������� ����
�����ϴ� ���� �ϳ��� �߰��� �ϸ� �� �̻� Ž���� ���� �ʰ� �ߴ�
���� ���� ���ο� ������ ���� �� ���

SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
              FROM dept); 
              

�Ŵ����� ���� ���� : KING
�Ŵ��� ������ �����ϴ� ���� : 14 - KING : 13
EXISTS �����ڸ� Ȱ���Ͽ� ��ȸ
SELECT *
FROM emp e
WHERE EXISTS (SELECT *
              FROM emp m
              WHERE e.mgr = m.empno); 
              
join
SELECT e.*
FROM emp e, emp m
WHERE e.mgr = m.empno;
              
--�ǽ� sub9
SELECT *
FROM product
WHERE EXISTS (SELECT pid
              FROM cycle
              WHERE cid = 1 
                AND cycle.pid = product.pid);

--�ǽ� sub10
SELECT *
FROM product
WHERE NOT EXISTS (SELECT *
                  FROM cycle
                  WHERE cid = 1 
                    AND cycle.pid = product.pid);


���տ���
������
(1, 5, 3) U (2, 3) = (1, 2, 3, 5)

SQL���� �����ϴ� UNION ALL (���� �����͸� ���� ���� �ʴ´�)
(1, 5, 3) U (2, 3) = (1, 5, 3, 2, 3)              
              
������
(1, 5, 3) ������ (2, 3) = (3)

������
(1, 5, 3) U (2, 3) = (1, 5)

SQL������ ���տ���
������ : UNION, UNION ALL, INTERSECT, MINUS
�ΰ��� SQL�� �������� ���� Ȯ�� (��, �Ʒ��� ���� �ȴ�);


UNION ������ : �ߺ�����(������ ������ ���հ� ����)

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION 

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


UNION ALL ������ : �ߺ���� 

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


INTERSECT ������ : �� ���հ� �ߺ��Ǵ� ��Ҹ� ��ȸ

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


MINUS ������ : ���� ���տ��� �Ʒ��� ���� ��Ҹ� ����

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);


SQL ���տ������� Ư¡

���� �̸� : ù��° SQL�� �÷��� ���󰣴�

1. ù��° ������ �÷��� ��Ī �ο�
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)

UNION

SELECT ename , empno 
FROM emp
WHERE empno IN (7369);

2. ������ �ϰ���� ��� �������� ���� ����
   ���� SQL���� ORDER BY �Ұ� (�ζ��� �並 ����Ͽ� ������������ ORDER BY ������� ������ ����)
SELECT ename nm, empno no
FROM emp
WHERE empno IN (7369)
--ORDER BY nm, �߰� ������ ���� �Ұ�
UNION

SELECT ename , empno 
FROM emp
WHERE empno IN (7369)
ORDER BY nm;   
   
3. SQL�� ���� �����ڴ� �ߺ��� �����Ѵ�(������ ���� ����� ����), �� UNION ALL�� �ߺ� ���  
   
4. �ΰ��� ���տ��� �ߺ��� �����ϱ� ���� ������ ������ �����ϴ� �۾��� �ʿ�
    ==> ����ڿ��� ����� �����ִ� �������� ������
        ==> UNION ALL�� ����� �� �ִ� ��Ȳ�� ��� UNION�� ������� �ʾƾ� �ӵ����� ���鿡�� �����ϴ�
�˰���(����-��ǰ, ���� ����, ���� ����,..., 
           �ڷ� ���� : Ʈ������(���� Ʈ��, �뷱�� Ʈ��)
                      heap 
                      stack, queue
                      list
            
 ���տ��꿡�� �߿��� ���� : �ߺ�����
 


SELECT ROWNUM rn, a.sido, a.sigungu, a.city_idx
FROM
(SELECT bk.sido sido, bk.sigungu sigungu, bk.cnt, kfc.cnt, mac.cnt, lot.cnt,
      ROUND((bk.cnt + kfc.cnt + mac.cnt) / lot.cnt, 2) city_idx
 FROM
(SELECT sido, sigungu, COUNT(*) CNT
 FROM fastfood 
 WHERE gb = '����ŷ' 
 GROUP BY sido, sigungu) bk,

(SELECT sido, sigungu, COUNT(*) CNT
 FROM fastfood
 WHERE gb = 'KFC' 
 GROUP BY sido, sigungu) kfc,

(SELECT sido, sigungu, COUNT(*) CNT
 FROM fastfood
 WHERE gb = '�Ƶ�����' 
 GROUP BY sido, sigungu) mac,
    
(SELECT sido, sigungu, COUNT(*) CNT
 FROM fastfood
 WHERE gb = '�Ե�����' 
 GROUP BY sido, sigungu) lot
 

WHERE bk.sido = kfc.sido
  AND bk.sigungu = kfc.sigungu
  AND bk.sido = mac.sido
  AND bk.sigungu = mac.sigungu
  AND bk.sido = lot.sido
  AND bk.sigungu = lot.sigungu
ORDER BY city_idx DESC ) a ;





SELECT *
FROM tax;

�ʼ�
���� 1] fastfood ���̺�� tax ���̺��� �̿��Ͽ� ������ ���� ��ȸ�ǵ��� SQL �ۼ�
 1. ���ù��������� ���ϰ�
 2. �δ� ���� �Ű���� ���� �õ� �ñ������� ������ ���Ͽ� 
 3. ���ù��������� �����Ű�� ������ ���� ������ ���� �����Ͽ� �Ʒ��� ���� �÷��� ��ȸ�ǵ��� SQL �ۼ�
 
����, �ܹ��� �õ�, �ܹ��� �ñ���, �ܹ��� ���ù�������, ����û �õ�, ����û �ñ���, ����û �������� �ݾ� 1�δ� �Ű��

SELECT ROWNUM rn, bug.hsido, bug.hsigungu, bug.city_idx, tax1.tsido, tax1.tsigungu, tax1.city_tax
FROM
(SELECT ROWNUM rn, a.*
 FROM
    (SELECT bk.sido hsido, bk.sigungu hsigungu,
     ROUND((bk.cnt + kfc.cnt + mac.cnt) / lot.cnt, 2) city_idx  
     FROM
    (SELECT sido, sigungu, COUNT(*) CNT
     FROM fastfood 
     WHERE gb = '����ŷ' 
     GROUP BY sido, sigungu) bk,

    (SELECT sido, sigungu, COUNT(*) CNT
     FROM fastfood
     WHERE gb = 'KFC' 
     GROUP BY sido, sigungu) kfc,
    
    (SELECT sido, sigungu, COUNT(*) CNT
     FROM fastfood
     WHERE gb = '�Ƶ�����' 
     GROUP BY sido, sigungu) mac,
        
    (SELECT sido, sigungu, COUNT(*) CNT
     FROM fastfood
     WHERE gb = '�Ե�����' 
     GROUP BY sido, sigungu) lot

    WHERE bk.sido = kfc.sido
      AND bk.sigungu = kfc.sigungu
      AND bk.sido = mac.sido
      AND bk.sigungu = mac.sigungu
      AND bk.sido = lot.sido
      AND bk.sigungu = lot.sigungu
    ORDER BY city_idx DESC) a) bug,
    
    (SELECT ROWNUM rn, sido tsido, sigungu tsigungu, ROUND(city_taxs, 2) city_tax
     FROM
        (SELECT sido , sigungu, sal / people city_taxs
         FROM tax 
         GROUP BY sido , sigungu , people, sal
         ORDER BY city_taxs DESC) a) tax1
WHERE bug.rn(+) = tax1.rn
ORDER BY tax1.rn;


�ɼ�
���� 2]
�ܹ��� ���ù��� ������ ���ϱ� ���� 4���� �ζ��� �並 ��� �Ͽ��µ� (fastfood ���̺��� 4�����)
�̸� �����Ͽ� ���̺��� �ѹ��� �д� ���·� ������ ����(fastfood ���̺��� 1���� ���)
[HINT] CASE, DECODE �̿��ϸ� ����

SELECT ROWNUM rank, sido , sigungu, city_idx
FROM
(SELECT ROWNUM rank, sido, sigungu, ROUND((kfc + mac + bk) / lot, 2) city_idx
FROM
(SELECT sido, sigungu, 
       NVL(SUM(CASE WHEN gb = '�Ե�����' THEN 1 END), 1) lot, 
       NVL(SUM(CASE WHEN gb = 'KFC' THEN 1 END), 0) kfc,
       NVL(SUM(CASE WHEN gb = '�Ƶ�����' THEN 1 END), 0) mac, 
       NVL(SUM(CASE WHEN gb = '����ŷ' THEN 1 END), 0) bk
FROM fastfood
WHERE gb IN('����ŷ', 'KFC', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu)
ORDER BY city_idx DESC);

���� 3]
�ܹ��� ���� SQL�� �ٸ� ���·� �����ϱ�.

SELECT *
FROM fastfood;




