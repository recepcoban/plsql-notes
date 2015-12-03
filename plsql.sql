----- ORACLE - PL/SQL NOTLARIM -----  
-- create table 
create table demotable (
   id number(10) not null, -- not null -> not empty  
   name varchar2(100) not null,
   mail varchar2(100),
   city varchar2(50),
   constraint pk primary key (id) -- constraint primary key  
);

-- drop table  
drop table rcoban_demo -- geri dönüşüm yapılabilir  
drop table rcoban_demo purge; -- geri dönüşüm yapılamaz  

-- insert  
INSERT INTO DEMOTABLE
VALUES
   (2,
    'recep',
    'recep@mail.com',
    'istanbul',
    TO_DATE('20121010', 'YYYYMMDD'));

-- rename table 
rename rcoban_demo to demotable

-- update 
UPDATE DEMOTABLE SET CITY = 'izmir' WHERE ID = 1

-- delete  
DELETE FROM DEMOTABLE WHERE ID = 2

-- select  
SELECT * FROM DEMOTABLE

-- select(rename columns)  
SELECT ID       AS ID,
       NAME     AS NAME,
       MAIL     AS MAIL,
       CITY     AS CITY,
       BIRTHDAY AS BIRTHDAY
  FROM DEMOTABLE

-- alter operations  
alter table demotable add salary number default 0;

alter table demotable modify (mail varchar2(100));

alter table demotable drop column salary;

alter table demotable rename column name to demo_name;

-- procedure  
CREATE OR REPLACE PROCEDURE PRO_INSERT_DEMO(DEMO_ID   IN DEMOTABLE.DEMO_ID%TYPE,
                                            DEMO_NAME IN DEMOTABLE.DEMO_NAME%TYPE,
                                            MAIL      IN DEMOTABLE.MAIL%TYPE,
                                            CITY      IN DEMOTABLE.CITY%TYPE,
                                            BIRTH     IN DEMOTABLE.BIRTH%TYPE) IS
BEGIN
   INSERT INTO DEMOTABLE VALUES (DEMO_ID, DEMO_NAME, MAIL, CITY, BIRTH);
END;

-- execute the proc
-- right click on proc name select test enter the value and ok  

--****************************--

-- anonim bir sorgu, yapı olarak genellikle bu şekildedir.
DECLARE
   TARIH DATE;
BEGIN
   SELECT SYSDATE INTO TARIH FROM DUAL;
   DBMS_OUTPUT.PUT_LINE(TARIH);
END;

-- değişken tanımlama
DECLARE
   DEGER VARCHAR2(100) := 'hello';
BEGIN
   DBMS_OUTPUT.PUT_LINE(DEGER || ' world');
END;

-- for döngüsü kullanımı
BEGIN
   FOR I IN (SELECT * FROM DEMOTABLE WHERE DEMO_NAME LIKE 'r%') LOOP
      DBMS_OUTPUT.PUT_LINE(I.DEMO_NAME);
   END LOOP;
END;

-- if then yapısı kullanımı
DECLARE
   MYAGE NUMBER := 28;
BEGIN
   IF MYAGE < 11 THEN
      DBMS_OUTPUT.PUT_LINE(MYAGE || ', I am a child ');
   ELSE
      DBMS_OUTPUT.PUT_LINE(MYAGE || ', I am not a child ');
   END IF;
END;

-- fonksiyon kullanımı
CREATE FUNCTION FONK(DEGER IN VARCHAR2) RETURN VARCHAR2 IS
BEGIN
   RETURN DEGER;
END;

-- constant kullanımı
DECLARE
   NUM CONSTANT NUMBER(5, 2) := 100.15;
BEGIN
   -- num := 20;
   DBMS_OUTPUT.PUT_LINE(NUM);
END;

-- aritmetik operatörler
DECLARE
   NUM1 NUMBER := 10;
   NUM2 NUMBER := 5;
   NUM3 NUMBER;
BEGIN
   NUM3 := NUM1 + NUM2; -- +
   DBMS_OUTPUT.PUT_LINE(NUM3);
   NUM3 := NUM1 - NUM2; -- -
   DBMS_OUTPUT.PUT_LINE(NUM3);
   NUM3 := NUM1 * NUM2; -- * 
   DBMS_OUTPUT.PUT_LINE(NUM3);
   NUM3 := NUM1 / NUM2; -- /
   DBMS_OUTPUT.PUT_LINE(NUM3);
   NUM3 := NUM1 ** NUM2; -- **
   DBMS_OUTPUT.PUT_LINE(NUM3);
END;

-- karşılaştırma operatörleri
DECLARE
   NUM1 NUMBER := 10;
   NUM2 NUMBER := 20;
BEGIN
   IF NUM1 > NUM2 THEN
      -- buyuk , < kucuk , = esit , != esit degil , >= buyuk esit ,
      DBMS_OUTPUT.PUT_LINE('buyuk');
   ELSE
      DBMS_OUTPUT.PUT_LINE('''kucuk''');
   END IF;
END;

-- for döngüsü kullanımı
DECLARE
   I NUMBER(1);
   J NUMBER(1);
BEGIN
   <<OUTER_LOOP>> -- zorunlu degil
   FOR I IN 1 .. 3 LOOP
      <<INNER_LOOP>> -- zorunlu degil
      FOR J IN 1 .. 3 LOOP
         IF J = 2 THEN
            -- exit;  -- exit
            CONTINUE; -- continue
         END IF;
         DBMS_OUTPUT.PUT_LINE('i is: ' || I || ' and j is: ' || J);
      END LOOP INNER_LOOP;
   END LOOP OUTER_LOOP;
END;

-- diziler
-- pl/sql de dizilerin isdisleri 1 den başlar
DECLARE
   TYPE NAMESARRAY IS VARRAY(5) OF VARCHAR2(10);
   TYPE GRADES IS VARRAY(5) OF INTEGER;
   NAMES NAMESARRAY;
   MARKS GRADES;
   TOTAL INTEGER;
BEGIN
   NAMES := NAMESARRAY('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
   MARKS := GRADES(98, 97, 78, 87, 92);
   TOTAL := NAMES.COUNT;
   DBMS_OUTPUT.PUT_LINE('Total ' || TOTAL || ' Students');
   FOR I IN 1 .. TOTAL LOOP
      DBMS_OUTPUT.PUT_LINE('Student: ' || NAMES(I) || '
      Marks: ' || MARKS(I));
   END LOOP;
END;

-- dizi örneği
DECLARE
   CURSOR C_DEMO IS
      SELECT DEMO_NAME FROM DEMOTABLE;
   TYPE C_LIST IS VARRAY(6) OF DEMOTABLE.DEMO_NAME%TYPE;
   NAME_LIST C_LIST := C_LIST();
   COUNTER   INTEGER := 0;
BEGIN
   FOR N IN C_DEMO LOOP
      COUNTER := COUNTER + 1;
      NAME_LIST.EXTEND;
      NAME_LIST(COUNTER) := N.DEMO_NAME;
      DBMS_OUTPUT.PUT_LINE('Demo(' || COUNTER || '):' ||
                           NAME_LIST(COUNTER));
   END LOOP;
END;

-- prosedür kullanımı
CREATE OR REPLACE PROCEDURE HELLO_MESAJI AS
BEGIN
   DBMS_OUTPUT.PUT_LINE('Hello World!');
END;
-- pro. çalıştırma
BEGIN
HELLO_MESAJI;
END;

--
DECLARE
   A NUMBER;
   B NUMBER;
   C NUMBER;

   PROCEDURE FINDMIN(X IN NUMBER, Y IN NUMBER, Z OUT NUMBER) IS
   BEGIN
      IF X < Y THEN
         Z := X;
      ELSE
         Z := Y;
      END IF;
   END;

BEGIN
   A := 23;
   B := 45;
   FINDMIN(A, B, C);
   DBMS_OUTPUT.PUT_LINE(' Minimum of (23, 45) : ' || C);
END;

-- kare hesaplayan proc.
DECLARE
   A NUMBER;
   B NUMBER;
   PROCEDURE CALCSQUARE(A IN NUMBER) IS
   BEGIN
      B := A * A;
   END;
BEGIN
   A := 4;
   CALCSQUARE(A);
   DBMS_OUTPUT.PUT_LINE('square of ' || A || ' is ' || B);
END;

-- fonksiyon kullanımı
CREATE OR REPLACE FUNCTION FONK_GETIR1 RETURN NUMBER IS TOTAL NUMBER(2) := 0;
BEGIN
   SELECT COUNT(*) INTO TOTAL FROM DEMOTABLE;
   RETURN TOTAL;
END;

-- fonk. çağırma
DECLARE
   A NUMBER(2);
BEGIN
   A := FONK_GETIR1();
   DBMS_OUTPUT.PUT_LINE('Total no. of items : ' || A);
END;

--
DECLARE
   A NUMBER;
   B NUMBER;
   C NUMBER;
   FUNCTION FINDMAX(X IN NUMBER, Y IN NUMBER) RETURN NUMBER IS
      Z NUMBER;
   BEGIN
      IF X > Y THEN
         Z := X;
      ELSE
         Z := Y;
      END IF;
   
      RETURN Z;
   END;
BEGIN
   A := 23;
   B := 45;

   C := FINDMAX(A, B);
   DBMS_OUTPUT.PUT_LINE(' Maximum of (23,45): ' || C);
END;

-- faktöriyel hesaplayan fonk.
DECLARE
   A NUMBER;
   FUNCTION FAK(A IN NUMBER) RETURN NUMBER IS
   BEGIN
      IF A = 0 THEN
         RETURN 1;
      ELSE
         RETURN A * FAK(A - 1);
      END IF;
   END;
BEGIN
   DBMS_OUTPUT.PUT_LINE('fak. : ' || FAK(4));
END;

-- cursor kullanımı
DECLARE
   TOTAL_ROWS NUMBER(2);
BEGIN
   UPDATE DEMOTABLE SET SALARY = SALARY + 500;
   IF SQL%NOTFOUND THEN
      DBMS_OUTPUT.PUT_LINE('no record selected');
   ELSIF SQL%FOUND THEN
      TOTAL_ROWS := SQL%ROWCOUNT;
      DBMS_OUTPUT.PUT_LINE(TOTAL_ROWS || ' record selected ');
   END IF;
END;

-- Tüm kayıtlar
DECLARE
   DEMO_REC DEMOTABLE%ROWTYPE;
BEGIN
   SELECT * INTO DEMO_REC FROM DEMOTABLE WHERE DEMO_ID = 1;

   DBMS_OUTPUT.PUT_LINE('Record ID: ' || DEMO_REC.DEMO_ID);
   DBMS_OUTPUT.PUT_LINE('Record Name: ' || DEMO_REC.DEMO_NAME);
   DBMS_OUTPUT.PUT_LINE('Record City: ' || DEMO_REC.CITY);
   DBMS_OUTPUT.PUT_LINE('Record Salary: ' || DEMO_REC.SALARY);
END;

-- Cursor bazlı tüm kayıtlar
DECLARE
   CURSOR DEMO_CUR IS
      SELECT DEMO_ID, DEMO_NAME, CITY FROM DEMOTABLE;
   DEMO_REC DEMO_CUR%ROWTYPE;
BEGIN
   OPEN DEMO_CUR;
   LOOP
      FETCH DEMO_CUR
         INTO DEMO_REC;
      EXIT WHEN DEMO_CUR%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(DEMO_REC.DEMO_ID || ' - ' || DEMO_REC.DEMO_NAME);
   END LOOP;
END;

-- cursor örneği
DECLARE
   CURSOR CUR_BILGI IS
      SELECT * FROM DEMOTABLE WHERE DEMO_ID = 1;
   REC CUR_BILGI%ROWTYPE;
BEGIN
   OPEN CUR_BILGI;
   FETCH CUR_BILGI
      INTO REC;
   DBMS_OUTPUT.PUT_LINE(REC.CITY);
   CLOSE CUR_BILGI;
END;

-- Hata Yakalama -- Exception 
DECLARE
   C_ID   DEMOTABLE.DEMO_ID%TYPE := 1;
   C_NAME DEMOTABLE.DEMO_NAME%TYPE;
BEGIN
   SELECT DEMO_NAME INTO C_NAME FROM DEMOTABLE WHERE DEMO_ID = C_ID;
   DBMS_OUTPUT.PUT_LINE('Name: ' || C_NAME);
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No such customer!');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error!');
END;

-- Exception Örneği, kullanıcı tanımlı hata
DECLARE
   C_ID   DEMOTABLE.DEMO_ID%TYPE := &DEGER; -- &deger: kullanıcıdan değer alma
   C_NAME DEMOTABLE.DEMO_NAME%TYPE;
   EX_INVALID_ID EXCEPTION; -- exception tanımlama
BEGIN
   IF C_ID <= 0 THEN
      RAISE EX_INVALID_ID;
   ELSE
      SELECT DEMO_NAME INTO C_NAME FROM DEMOTABLE WHERE DEMO_ID = C_ID;
      DBMS_OUTPUT.PUT_LINE('Name: ' || C_NAME);
   END IF;
EXCEPTION
   WHEN EX_INVALID_ID THEN
      DBMS_OUTPUT.PUT_LINE('ID must be greater than zero!');
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No such customer!');
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error!');
END;

-- sayı kontrolü yapan fonk.
CREATE OR REPLACE FUNCTION IS_NUMBER(P_STR IN VARCHAR2) RETURN VARCHAR2
   DETERMINISTIC
   PARALLEL_ENABLE IS
   L_NUM NUMBER;
BEGIN
   L_NUM := TO_NUMBER(P_STR);
   RETURN 'Y';
EXCEPTION
   WHEN VALUE_ERROR THEN
      RETURN 'N';
END IS_NUMBER;

DECLARE A VARCHAR2(100);
BEGIN
A := IS_NUMBER('sdf'); DBMS_OUTPUT.PUT_LINE(A);
END;
------------

-- Trigger
CREATE OR REPLACE TRIGGER DISPLAY_SALARY_CHANGES
   BEFORE DELETE OR INSERT OR UPDATE ON DEMOTABLE
   FOR EACH ROW
   WHEN (NEW.DEMO_ID > 0)
DECLARE
   SAL_DIFF NUMBER;
BEGIN
   SAL_DIFF := :NEW.SALARY - :OLD.SALARY;
   DBMS_OUTPUT.PUT_LINE('Old salary: ' || :OLD.SALARY);
   DBMS_OUTPUT.PUT_LINE('New salary: ' || :NEW.SALARY);
   DBMS_OUTPUT.PUT_LINE('Salary difference: ' || SAL_DIFF);
END;

--*******************************************--
-- Trigger ve sequence için örnek
-- hesap tablosu
CREATE TABLE DEMOHESAP
(
   HESAP_ID       NUMBER (10),
   SAHIP_AD       VARCHAR2 (50),
   SAHIP_SOYAD    VARCHAR2 (50),
   ACILIS_TARIH   DATE,
   PRIMARY KEY (HESAP_ID)
)

-- hareket tablosu
CREATE TABLE DEMOHAREKET
(
   HAREKET_ID    NUMBER (12),
   HESAP_ID      NUMBER (10),
   YENI_BAKIYE   NUMBER (15, 5),
   ESKI_BAKIYE   NUMBER (15, 5),
   TARIH         DATE,
   IP            VARCHAR (30),
   PRIMARY KEY (HAREKET_ID),
   FOREIGN KEY (HESAP_ID) REFERENCES DEMOHESAP (HESAP_ID)
)

-- Oracle 12c ile beraber AUTO_INCREMENT çıktı
-- hesap tablosu için sequence
CREATE SEQUENCE DEMOHESAP_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 9999

-- hareket tablosu için sequence
CREATE SEQUENCE DEMOHAREKET_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 9999

-- hesap tablosu için trigger
CREATE TRIGGER DEMOHESAP_SEQ_TRIG
   BEFORE INSERT ON DEMOHESAP
   REFERENCING NEW AS NEW
   FOR EACH ROW
BEGIN
   SELECT DEMOHESAP_SEQ.NEXTVAL INTO :NEW.HESAP_ID FROM DUAL;
END;

-- hareket tablosu için trigger
CREATE OR REPLACE TRIGGER DEMOHAREKET_SEQ_TRIG
   BEFORE INSERT ON DEMOHAREKET
   REFERENCING NEW AS NEW
   FOR EACH ROW
BEGIN
   SELECT DEMOHAREKET_SEQ.NEXTVAL INTO :NEW.HAREKET_ID FROM DUAL;
END;
   
-- hesap için insert 
INSERT INTO DEMOHESAP
   (SAHIP_AD, SAHIP_SOYAD, ACILIS_TARIH)
VALUES
   ('cetin', 'coban', TO_DATE('10102015', 'DDMMYYYY'));

-- hareket için insert
INSERT INTO DEMOHAREKET
   (HESAP_ID, YENI_BAKIYE, ESKI_BAKIYE, TARIH, IP)
VALUES
   (2,
    1000,
    500,
    TO_DATE('10102015', 'DDMMYYYY'),
    UTL_INADDR.GET_HOST_ADDRESS);

SELECT * FROM DEMOHESAP
       
SELECT * FROM DEMOHAREKET
                
UPDATE DEMOHAREKET
   SET IP = UTL_INADDR.GET_HOST_ADDRESS
 WHERE HAREKET_ID = 2;

--*******************************************--

-- Package
-- Creating package
CREATE OR REPLACE PACKAGE DEMOPACKAGE AS
   -- Adds a record
   PROCEDURE ADDRECORD(C_ID    DEMOTABLE.DEMO_ID%TYPE,
                       C_NAME  DEMOTABLE.DEMO_NAME%TYPE,
                       C_MAIL  DEMOTABLE.MAIL%TYPE,
                       C_CITY  DEMOTABLE.CITY%TYPE,
                       C_BIRTH DEMOTABLE.BIRTH%TYPE,
                       C_SAL   DEMOTABLE.SALARY%TYPE);

   -- Removes a record
   PROCEDURE DELRECORD(C_ID DEMOTABLE.DEMO_ID%TYPE);
   -- Lists all records
   PROCEDURE LISTRECORDS;
END DEMOPACKAGE;

-- Creating package body
CREATE OR REPLACE PACKAGE BODY DEMOPACKAGE AS
   PROCEDURE ADDRECORD(C_ID    DEMOTABLE.DEMO_ID%TYPE,
                       C_NAME  DEMOTABLE.DEMO_NAME%TYPE,
                       C_MAIL  DEMOTABLE.MAIL%TYPE,
                       C_CITY  DEMOTABLE.CITY%TYPE,
                       C_BIRTH DEMOTABLE.BIRTH%TYPE,
                       C_SAL   DEMOTABLE.SALARY%TYPE) IS
   BEGIN
      INSERT INTO DEMOTABLE
      VALUES
         (C_ID, C_NAME, C_MAIL, C_CITY, C_BIRTH, C_SAL);
   END ADDRECORD;

   PROCEDURE DELRECORD(C_ID DEMOTABLE.DEMO_ID%TYPE) IS
   BEGIN
      DELETE FROM DEMOTABLE WHERE DEMO_ID = C_ID;
   END DELRECORD;

   PROCEDURE LISTRECORDS IS
      CURSOR C_DEMOTABLE IS
         SELECT DEMO_NAME FROM DEMOTABLE;
      TYPE C_LIST IS TABLE OF DEMOTABLE.DEMO_NAME%TYPE;
      NAME_LIST C_LIST := C_LIST();
      COUNTER   INTEGER := 0;
   BEGIN
      FOR N IN C_DEMOTABLE LOOP
         COUNTER := COUNTER + 1;
         NAME_LIST.EXTEND;
         NAME_LIST(COUNTER) := N.DEMO_NAME;
         DBMS_OUTPUT.PUT_LINE('Record(' || COUNTER || ')' ||
                              NAME_LIST(COUNTER));
      END LOOP;
   END LISTRECORDS;
END DEMOPACKAGE;

--
DECLARE
   CODE DEMOTABLE.DEMO_ID%TYPE := 10;
BEGIN
   DEMOPACKAGE.ADDRECORD(9,
                         'fatma',
                         'fatma.com',
                         'konya',
                         TO_DATE('10102015', 'DDMMYYYY'),
                         1000);
   DEMOPACKAGE.ADDRECORD(10,
                         'Subham',
                         's',
                         'Delhi',
                         TO_DATE('10102015', 'DDMMYYYY'),
                         7500);
   DEMOPACKAGE.LISTRECORDS;
   DEMOPACKAGE.DELRECORD(CODE);
   DEMOPACKAGE.LISTRECORDS;
END;

-- Date and Time
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(CURRENT_DATE, 'DD-MM-YYYY HH:MI:SS') FROM DUAL;
select current_date.get from dual;
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;
SELECT LOCALTIMESTAMP FROM DUAL;

-- Java Source
create or replace and compile java source named helloworld as
public class helloworld
{
  public static String say_hello()
  {
         return "Hello World";
  }
}

-- Function for calling java source class
CREATE OR REPLACE FUNCTION HELLOWORLD RETURN VARCHAR2 AS
   LANGUAGE JAVA NAME 'helloworld.say_hello() return java.lang.String';

