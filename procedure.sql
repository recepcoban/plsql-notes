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
