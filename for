-- for döngüsü kullanımı
BEGIN
   FOR I IN (SELECT * FROM DEMOTABLE WHERE DEMO_NAME LIKE 'r%') LOOP
      DBMS_OUTPUT.PUT_LINE(I.DEMO_NAME);
   END LOOP;
END;

-- for örnek
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
