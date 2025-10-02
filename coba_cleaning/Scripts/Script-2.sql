select * 
from customers_dirty

-- 1. Buat tabel hasil cleaning tanpa duplikat ID
CREATE TABLE customers_clean AS
SELECT DISTINCT ON (id) *
FROM customers_dirty
ORDER BY id;

-- 2. Rapikan kolom full_name (hapus spasi berlebih)
UPDATE customers_clean
SET full_name = TRIM(full_name)
WHERE full_name IS NOT NULL;

-- 3. Normalisasi kolom city (jadikan kapital di awal kata, contoh: "New York")
UPDATE customers_clean
SET city = INITCAP(city)
WHERE city IS NOT NULL;

-- 4. Ubah kolom email jadi huruf kecil semua
UPDATE customers_clean
SET email = LOWER(email)
WHERE email IS NOT NULL;

-- 6. Hapus baris yang critical NULL (nama atau email kosong)
DELETE FROM customers_clean
WHERE full_name IS NULL
   OR email IS NULL;

DELETE FROM customers_clean
WHERE full_name IS NULL OR TRIM(full_name) = ''
   OR email IS NULL OR TRIM(email) = '';

SELECT *
FROM customers_clean



