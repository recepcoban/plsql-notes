/* ----- DDL ----- */
/* creating table */
create table demotable (
id number(10) not null, /* not null -> not empty */
name varchar2(100) not null,
mail varchar2(100),
city varchar2(50),
constraint pk primary key (id) /* constraint primary key */
);

/* drop table */
drop table rcoban_demo /* geri dönüşüm yapılabilir */
drop table rcoban_demo purge; /* geri dönüşüm yapılamaz */

/* insert */
insert into demotable values(2,'recep','recep@mail.com','istanbul',to_date('20121010','YYYYMMDD'));

/* rename table */
rename rcoban_demo to demotable

/* update */
update demotable set city='izmir' where id=1

/* delete */
delete from demotable where id=2

/* select */
select * from demotable

/* select(rename columns) */
select id as ID, Name as Name, MAIL as Mail, CITY as City, birthday as Birthday from demotable

/* alter operations */ 
alter table demotable add salary number default 0

alter table demotable modify (mail varchar2(100))

alter table demotable drop column salary

alter table demotable rename column name to demo_name

/* procedure */
CREATE OR REPLACE PROCEDURE pro_insert_demo(
     demo_id IN demotable.demo_id%TYPE,
     demo_name IN demotable.demo_name%TYPE,
     mail IN demotable.mail%TYPE,
     city IN demotable.city%TYPE,
     birth IN demotable.birth%TYPE)
IS
BEGIN
  INSERT INTO demotable 
  VALUES (demo_id, demo_name, mail, city, birth);
END;

-- execute the proc
/* right click on proc name select test enter the value and ok */

-------------

-- anonim bir sorgu, yapı olarak genellikle bu şekildedir.
declare 
tarih date;
begin 
select sysdate into tarih from dual;
dbms_output.put_line(tarih);
end;

-- değişken tanımlama
declare
deger varchar2(100) := 'hello';
begin
dbms_output.put_line(deger || ' world');
end;

-- for döngüsü kullanımı
begin
for i in (select * from demotable where demo_name like 'r%')
loop
dbms_output.put_line(i.demo_name);
end loop;
end;

-- if then yapısı kullanımı
declare
myage number := 28;
begin
if myage < 11
 then
    dbms_output.put_line(myage ||', I am a child '); 
 else
    dbms_output.put_line(myage ||', I am not a child ');
end if;
end;

-- fonksiyon kullanımı
create function fonk(deger in varchar2)
return varchar2
is
begin 
return deger;
end;

-- constant kullanımı
declare 
num constant number(5,2) := 100.15;
begin
-- num := 20;
dbms_output.put_line(num);
end;

-- aritmetik operatörler
declare 
num1 number := 10;
num2 number := 5;
num3 number;
begin
num3 := num1 + num2; -- +
dbms_output.put_line(num3);
num3 := num1 - num2; -- -
dbms_output.put_line(num3);
num3 := num1 * num2; -- * 
dbms_output.put_line(num3);
num3 := num1 / num2; -- /
dbms_output.put_line(num3);
num3 := num1 ** num2; -- **
dbms_output.put_line(num3);
end;

-- karşılaştırma operatörleri
declare
num1 number := 10;
num2 number := 20;
begin 
if num1 > num2 then -- buyuk , < kucuk , = esit , != esit degil , >= buyuk esit ,
dbms_output.put_line('buyuk');
else
dbms_output.put_line('''kucuk''');
end if;
end;

-- for döngüsü kullanımı
DECLARE
   i number(1);
   j number(1);
BEGIN
   << outer_loop >> -- zorunlu degil
   FOR i IN 1..3 LOOP
      << inner_loop >> -- zorunlu degil
      FOR j IN 1..3 LOOP
          if j = 2 then
             -- exit;  -- exit
             continue; -- continue
          end if;
         dbms_output.put_line('i is: '|| i || ' and j is: ' || j);
      END loop inner_loop;
   END loop outer_loop;
END;

-- diziler
-- pl/sql de dizilerin isdisleri 1 den başlar
DECLARE
   type namesarray IS VARRAY(5) OF VARCHAR2(10);
   type grades IS VARRAY(5) OF INTEGER;
   names namesarray;
   marks grades;
   total integer;
BEGIN
   names := namesarray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
   marks := grades(98, 97, 78, 87, 92);
   total := names.count;
   dbms_output.put_line('Total '|| total || ' Students');
   FOR i in 1 .. total LOOP
      dbms_output.put_line('Student: ' || names(i) || '
      Marks: ' || marks(i));
   END LOOP;
END;

-- dizi örneği
DECLARE
   CURSOR c_demo is
   SELECT  demo_name FROM demotable;
   type c_list is varray (6) of demotable.demo_name%type;
   name_list c_list := c_list();
   counter integer :=0;
BEGIN
   FOR n IN c_demo LOOP
      counter := counter + 1;
      name_list.extend;
      name_list(counter)  := n.demo_name;
      dbms_output.put_line('Demo('||counter ||'):'||name_list(counter));
   END LOOP;
END;

-- prosedür kullanımı
CREATE OR REPLACE PROCEDURE hello_mesaji
AS
BEGIN
   dbms_output.put_line('Hello World!');
END;
-- pro. çalıştırma
begin
hello_mesaji;
end;

--
DECLARE
   a number;
   b number;
   c number;

PROCEDURE findMin(x IN number, y IN number, z OUT number) IS
BEGIN
   IF x < y THEN
      z:= x;
   ELSE
      z:= y;
   END IF;
END; 

BEGIN
   a:= 23;
   b:= 45;
   findMin(a, b, c);
   dbms_output.put_line(' Minimum of (23, 45) : ' || c);
END;

-- kare hesaplayan proc.
declare
  a number;
  b number;
  procedure calcSquare(a in number) is
  begin
    b := a * a;
  end;
begin
  a := 4;
  calcSquare(a);
  dbms_output.put_line('square of ' || a || ' is ' || b);
end;

  -- fonksiyon kullanımı
create or replace function fonk_getir1 return number is
  total number(2) := 0;
begin
  select count(*) into total from demotable;
  return total;
end;

-- fonk. çağırma
DECLARE
   a number(2);
BEGIN
   a := fonk_getir1();
   dbms_output.put_line('Total no. of items : ' || a);
END;

--
DECLARE
   a number;
   b number;
   c number;
FUNCTION findMax(x IN number, y IN number) 
RETURN number
IS
    z number;
BEGIN
   IF x > y THEN
      z:= x;
   ELSE
      z:= y;
   END IF;

   RETURN z;
END; 
BEGIN
   a:= 23;
   b:= 45;

   c := findMax(a, b);
   dbms_output.put_line(' Maximum of (23,45): ' || c);
END;

-- faktöriyel hesaplayan fonk.
declare
  a number;
  function fak(a in number) return number is
  begin
    if a = 0 then
      return 1;
    else
      return a * fak(a - 1);
    end if;
  end;
begin
  dbms_output.put_line('fak. : ' || fak(4));
end;

-- cursor kullanımı
DECLARE 
   total_rows number(2);
BEGIN
   UPDATE demotable
   SET salary = salary + 500;
   IF sql%notfound THEN
      dbms_output.put_line('no record selected');
   ELSIF sql%found THEN
      total_rows := sql%rowcount;
      dbms_output.put_line( total_rows || ' record selected ');
   END IF; 
END;

-- Tüm kayıtlar
DECLARE
  demo_rec demotable%rowtype;
BEGIN
  SELECT * into demo_rec FROM demotable WHERE demo_id = 1;

  dbms_output.put_line('Record ID: ' || demo_rec.demo_id);
  dbms_output.put_line('Record Name: ' || demo_rec.demo_name);
  dbms_output.put_line('Record City: ' || demo_rec.city);
  dbms_output.put_line('Record Salary: ' || demo_rec.salary);
END;

-- Cursor bazlı tüm kayıtlar
DECLARE
  CURSOR demo_cur is
    SELECT demo_id, demo_name, city FROM demotable;
  demo_rec demo_cur%rowtype;
BEGIN
  OPEN demo_cur;
  LOOP
    FETCH demo_cur
      into demo_rec;
    EXIT WHEN demo_cur%notfound;
    DBMS_OUTPUT.put_line(demo_rec.demo_id || ' - ' || demo_rec.demo_name);
  END LOOP;
END;

-- cursor örneği
DECLARE
  CURSOR cur_bilgi IS
    SELECT * FROM demotable WHERE demo_id = 1;
  rec cur_bilgi%rowtype;
BEGIN
  OPEN cur_bilgi;
  FETCH cur_bilgi
    INTO rec;
  DBMS_OUTPUT.put_line(rec.city);
  CLOSE cur_bilgi;
END;

-- Hata Yakalama -- Exception 
DECLARE
  c_id   demotable.demo_id%type := 1;
  c_name demotable.demo_name%type;
BEGIN
  SELECT demo_name INTO c_name FROM demotable WHERE demo_id = c_id;
  DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
EXCEPTION
  WHEN no_data_found THEN
    dbms_output.put_line('No such customer!');
  WHEN others THEN
    dbms_output.put_line('Error!');
END;

-- Exception Örneği, kullanıcı tanımlı hata
DECLARE
   c_id   demotable.demo_id%type := &deger; -- &deger: kullanıcıdan değer alma
   c_name demotable.demo_name%type;
   ex_invalid_id EXCEPTION; -- exception tanımlama
BEGIN
   IF c_id <= 0 THEN
      RAISE ex_invalid_id;
   ELSE
      SELECT demo_name INTO c_name FROM demotable WHERE demo_id = c_id;
      DBMS_OUTPUT.PUT_LINE('Name: ' || c_name);
   END IF;
EXCEPTION
   WHEN ex_invalid_id THEN
      dbms_output.put_line('ID must be greater than zero!');
   WHEN no_data_found THEN
      dbms_output.put_line('No such customer!');
   WHEN others THEN
      dbms_output.put_line('Error!');
END;

-- sayı kontrolü yapan fonk.
CREATE OR REPLACE FUNCTION is_number(p_str IN VARCHAR2) RETURN VARCHAR2
   DETERMINISTIC
   PARALLEL_ENABLE IS
   l_num NUMBER;
BEGIN
   l_num := to_number(p_str);
   RETURN 'Y';
EXCEPTION
   WHEN value_error THEN
      RETURN 'N';
END is_number;

DECLARE a varchar2(100);
BEGIN
a := is_number('sdf'); dbms_output.put_line(a);
END;
------------

-- Trigger
CREATE OR REPLACE TRIGGER display_salary_changes
BEFORE DELETE OR INSERT OR UPDATE ON demotable
FOR EACH ROW
when (NEW.DEMO_ID > 0)
DECLARE
   sal_diff number;
BEGIN
   sal_diff := :NEW.salary  - :OLD.salary;
   dbms_output.put_line('Old salary: ' || :OLD.salary);
   dbms_output.put_line('New salary: ' || :NEW.salary);
   dbms_output.put_line('Salary difference: ' || sal_diff);
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


