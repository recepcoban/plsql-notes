# Oracle - PL/SQL Notlarım

<b>DDL : (Data Definition Language):</b>
* CREATE       -- Veritabanında nesne yaratır.
* ALTER        -- Veritabanının yapısını değiştirir.
* DROP         -- Veritabanından obje siler.
* TRUNCATE     -- Tablodaki kayıtları içerdikleri alan ile birlikte siler.
* COMMENT      -- Yorum ekler.
* RENAME       -- Nesnenin asını değiştirir.

<b>DML : (Data Manipulation Language):</b>
* SELECT       -- Veritabanından kayıt okur.
* INSERT       -- Tabloya kayıt ekler.
* UPDATE       -- Tablodaki kayıdı günceller.
* DELETE       -- Tablodan kayırları siler ancak kapladığı alan kalır.
* MERGE        -- UPSERT işlemi (ekleme veya güncelleme)
* CALL         -- PL/SQL veya Java alt programı çalıştırır.

<b>TCL : (Transaction Control Language):</b>
* COMMIT       -- Yapılanları kayıt eder.
* SAVEPOINT    -- Daha sonra geri dönülecek bir dönüş noktası belirler.
* ROLLBACK     -- Son COMMIT’e kadar olan yeri geri alır.

<b>DCL : (Data Control Language):</b>
* GRANT        -- Kullanıcıya veritabanı erişim yetkisi verir.
* REVOKE       -- GRANT ile verilen yetkiyi geri alır.
