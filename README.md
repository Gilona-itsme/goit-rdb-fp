# goit-rdb-fp — Pandemic (Final Project, Relational Databases)

🇺🇦 [Українською](#-українською) · 🇬🇧 [English](#-english)

---

## 🇺🇦 Українською

### Опис

Фінальний проєкт з реляційних баз даних (MySQL). Робота з датасетом `infectious_cases.csv` про інфекційні захворювання за країнами та роками: завантаження даних, нормалізація до 3-ї нормальної форми, аналітичні запити, вбудовані та власні функції SQL.

### Структура репозиторію

```
goit-rdb-fp/
├── csv_file/
│   └── infectious_cases.csv   # вихідні дані
├── sql/
│   ├── P1.sql                 # завантаження даних
│   ├── P2.sql                 # нормалізація до 3НФ
│   ├── P3.sql                 # аналіз Number_rabies
│   ├── P4.sql                 # колонка різниці в роках (вбудовані функції)
│   └── P5.sql                 # власна функція calculate_year_difference
└── screens/
    ├── P1.png
    ├── P2_1.png, P2_2.png, P2_3.png
    ├── P3.png
    ├── P4.png
    └── P5_1.png, P5_2.png     # скріншоти виконання кожного завдання
```

### Що відбувається по завданнях

**1. Завантаження даних (`P1.sql`)**
- Схема `pandemic` створюється командою `CREATE SCHEMA IF NOT EXISTS` і обирається за замовчуванням через `USE pandemic`.
- CSV імпортується через Table Data Import Wizard у таблицю `infectious_cases`.
- `SELECT COUNT(*) FROM infectious_cases;` — завантажено **10 521** рядок.
- `SELECT * FROM infectious_cases LIMIT 20;` — перегляд даних. Атрибути `Entity` та `Code` постійно повторюються, тому потрібна нормалізація.

**2. Нормалізація до 3НФ (`P2.sql`)**
- Створено таблицю `entities` (`id` AUTO_INCREMENT PK, `Entity`, `Code`, `UNIQUE (Entity, Code)`) і заповнено через `INSERT ... SELECT DISTINCT` — **245** унікальних комбінацій.
- Створено таблицю `infectious_data` з `id`, зовнішнім ключем `entity_id` → `entities.id`, `Year` та всіма показниками захворювань.
- Дані перенесено з `infectious_cases` через `INSERT ... SELECT` з `JOIN entities` за `Entity` та `Code` (порівняння `<=>`, яке коректно працює з `NULL`). `Year` приводиться до числа через `CAST(... AS UNSIGNED)`.
- Перенесено **10 521** рядок — стільки ж, як у вихідній таблиці. Таблиці `entities` та `infectious_data` лежать у тій самій схемі `pandemic`; `infectious_cases` залишається для перевірки `COUNT(*)`.

**3. Аналіз даних (`P3.sql`)**
- Для кожної унікальної комбінації `Entity` + `Code` обчислюються `AVG`, `MIN`, `MAX`, `SUM` для `Number_rabies` (через `CAST(... AS DECIMAL(20, 2))`).
- Порожні значення `''` та `NULL` фільтруються у `WHERE`.
- Сортування за середнім за спаданням, `LIMIT 10`. Перший рядок результату — `World` (середнє ≈ 20 192,37).

**4. Різниця в роках — вбудовані функції (`P4.sql`)**
- `MAKEDATE(Year, 1)` → `year_start` (наприклад, `1996` → `1996-01-01`).
- `CURDATE()` → `today`.
- `TIMESTAMPDIFF(YEAR, MAKEDATE(Year, 1), CURDATE())` → `years_difference`.
- Аліас `current_date` не підходить — це зарезервоване слово MySQL (помилка 1064), тому використано `today`.

**5. Власна функція (`P5.sql`)**
- Створено функцію `calculate_year_difference(input_year INT) RETURNS INT` (`NOT DETERMINISTIC`, `NO SQL`), яка повертає `TIMESTAMPDIFF(YEAR, MAKEDATE(input_year, 1), CURDATE())`.
- Створюється через `DELIMITER //`.
- Виклик: `SELECT Year, calculate_year_difference(Year) AS years_difference FROM infectious_data;` — результат збігається із завданням 4.

### Як запустити

1. Встановити MySQL Server та MySQL Workbench.
2. Створити схему (`P1.sql`) та імпортувати `csv_file/infectious_cases.csv` через Import Wizard у `pandemic.infectious_cases`.
3. Послідовно виконати `P2.sql` → `P5.sql`.

> ⚠️ Не запускайте в `P1.sql` рядок `DROP SCHEMA IF EXISTS pandemic;` після імпорту — він видалить усі таблиці з даними.

### Технології

MySQL 8 · MySQL Workbench · SQL (DDL, DML, JOIN, агрегатні та дата-функції, UDF)

---

## 🇬🇧 English

### Overview

Final project for the Relational Databases course (MySQL). It works with the `infectious_cases.csv` dataset of infectious diseases by country and year: data loading, normalization to the 3rd normal form, analytical queries, built-in and custom SQL functions.

### Repository structure

```
goit-rdb-fp/
├── csv_file/
│   └── infectious_cases.csv   # source data
├── sql/
│   ├── P1.sql                 # data loading
│   ├── P2.sql                 # normalization to 3NF
│   ├── P3.sql                 # Number_rabies analysis
│   ├── P4.sql                 # year-difference column (built-in functions)
│   └── P5.sql                 # custom function calculate_year_difference
└── screens/
    ├── P1.png
    ├── P2_1.png, P2_2.png, P2_3.png
    ├── P3.png
    ├── P4.png
    └── P5_1.png, P5_2.png     # execution screenshots for each task
```

### What happens in each task

**1. Loading data (`P1.sql`)**
- The `pandemic` schema is created with `CREATE SCHEMA IF NOT EXISTS` and set as default via `USE pandemic`.
- The CSV is imported through the Table Data Import Wizard into the `infectious_cases` table.
- `SELECT COUNT(*) FROM infectious_cases;` — **10,521** rows loaded.
- `SELECT * FROM infectious_cases LIMIT 20;` — data preview. `Entity` and `Code` repeat constantly, so normalization is needed.

**2. Normalization to 3NF (`P2.sql`)**
- Table `entities` is created (`id` AUTO_INCREMENT PK, `Entity`, `Code`, `UNIQUE (Entity, Code)`) and filled with `INSERT ... SELECT DISTINCT` — **245** unique combinations.
- Table `infectious_data` is created with `id`, a foreign key `entity_id` → `entities.id`, `Year` and all disease metrics.
- Data is migrated from `infectious_cases` via `INSERT ... SELECT` with a `JOIN entities` on `Entity` and `Code` (using the `NULL`-safe `<=>` operator). `Year` is converted with `CAST(... AS UNSIGNED)`.
- **10,521** rows migrated — the same as in the source table. `entities` and `infectious_data` live in the same `pandemic` schema; `infectious_cases` is kept for the `COUNT(*)` check.

**3. Data analysis (`P3.sql`)**
- For each unique `Entity` + `Code` combination, `AVG`, `MIN`, `MAX`, `SUM` of `Number_rabies` are calculated (via `CAST(... AS DECIMAL(20, 2))`).
- Empty values `''` and `NULL` are filtered out in `WHERE`.
- Sorted by the average in descending order, `LIMIT 10`. The top row is `World` (average ≈ 20,192.37).

**4. Year difference — built-in functions (`P4.sql`)**
- `MAKEDATE(Year, 1)` → `year_start` (e.g. `1996` → `1996-01-01`).
- `CURDATE()` → `today`.
- `TIMESTAMPDIFF(YEAR, MAKEDATE(Year, 1), CURDATE())` → `years_difference`.
- The alias `current_date` doesn't work — it is a reserved MySQL word (error 1064), so `today` is used.

**5. Custom function (`P5.sql`)**
- Function `calculate_year_difference(input_year INT) RETURNS INT` (`NOT DETERMINISTIC`, `NO SQL`) is created; it returns `TIMESTAMPDIFF(YEAR, MAKEDATE(input_year, 1), CURDATE())`.
- Created using `DELIMITER //`.
- Usage: `SELECT Year, calculate_year_difference(Year) AS years_difference FROM infectious_data;` — the result matches task 4.

### How to run

1. Install MySQL Server and MySQL Workbench.
2. Create the schema (`P1.sql`) and import `csv_file/infectious_cases.csv` via the Import Wizard into `pandemic.infectious_cases`.
3. Run `P2.sql` → `P5.sql` in order.

> ⚠️ Don't run the `DROP SCHEMA IF EXISTS pandemic;` line from `P1.sql` after the import — it deletes all tables with data.

### Tech stack

MySQL 8 · MySQL Workbench · SQL (DDL, DML, JOIN, aggregate and date functions, UDF)
