-- 3.1 INSERT

-- a. Без указания списка полей
-- INSERT INTO table_name VALUES (value1, value2, value3, ...);
INSERT INTO cinema
VALUES (DEFAULT, 'New cinema', 'Moscow', '54-34-65');

-- b. С указанием списка полей
-- INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2,
-- value3, ...);
INSERT INTO cinema (name, location, number_phone)
VALUES ('New Cinema', 'Moscow', '80-80-80');

-- c. С чтением значения из другой таблицы
-- INSERT INTO table2 (column_name(s)) SELECT column_name(s) FROM table1;
INSERT INTO cinema (name)
SELECT (name)
FROM movie;

-- 3.2. DELETE
-- a. Всех записей
DELETE
FROM cinema;

-- b. По условию
-- DELETE FROM table_name WHERE condition;
DELETE
FROM cinema
WHERE number_phone = '80-80-80';

-- 3.3. UPDATE
-- a. Всех записей
UPDATE cinema
SET number_phone = '12-12-12';

-- b. По условию обновляя один атрибут
-- UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE
-- condition;
UPDATE cinema
SET number_phone = '36-38-36'
WHERE name = 'New cinema';

-- c. По условию обновляя несколько атрибутов
-- UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE
-- condition;
UPDATE cinema
SET name     = 'New cinema new!!!',
    location = 'Samara'
WHERE number_phone = '36-36-36';

-- 3.4. SELECT
-- a. С набором извлекаемых атрибутов (SELECT atr1, atr2 FROM...)
SELECT name, location
FROM cinema;

-- b. Со всеми атрибутами (SELECT * FROM...)
SELECT *
FROM cinema;

-- c. С условием по атрибуту (SELECT * FROM ... WHERE atr1 = value)
SELECT *
FROM cinema
WHERE number_phone = '90-90-90';

-- 3.5. SELECT ORDER BY + TOP (LIMIT)
-- a. С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT *
FROM cinema
ORDER BY location ASC;
--по умолчанию стоит ASC, писать излишне

-- b. С сортировкой по убыванию DESC
SELECT *
FROM cinema
ORDER BY location DESC;

-- c. С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT *
FROM cinema
ORDER BY name, location DESC
LIMIT 3;

-- d. С сортировкой по первому атрибуту, из списка извлекаемых
SELECT name, location
FROM cinema
ORDER BY name DESC;

-- 3.6. Работа с датами
-- Необходимо, чтобы одна из таблиц содержала атрибут с типом DATETIME. Например,
-- таблица авторов может содержать дату рождения автора.
-- a. WHERE по дате
SELECT *
FROM movie
WHERE release_date = '2025-03-08';

-- b. WHERE дата в диапазоне
SELECT *
FROM movie
WHERE release_date BETWEEN '2025-03-08' AND '2025-03-22';

-- c. Извлечь из таблицы не всю дату, а только год. Например, год рождения автора.
-- Для этого используется функция YEAR ( https://docs.microsoft.com/en-us/sql/t-
-- sql/functions/year-transact-sql?view=sql-server-2017 )
SELECT EXTRACT(YEAR FROM release_date) as year
FROM movie;

-- 3.7. Функции агрегации
-- a. Посчитать количество записей в таблице
SELECT COUNT(*)
FROM cinema;

-- b. Посчитать количество уникальных записей в таблице
SELECT COUNT(DISTINCT location)
FROM cinema;

-- c. Вывести уникальные значения столбца
SELECT DISTINCT location
FROM cinema;

-- d. Найти максимальное значение столбца
SELECT MAX(duration)
FROM film_rental;

-- e. Найти минимальное значение столбца
SELECT MIN(duration)
FROM film_rental;

-- f. Написать запрос COUNT() + GROUP BY
SELECT name, COUNT(location)
FROM cinema
GROUP BY name;


-- 3.8. SELECT GROUP BY + HAVING

-- a. Написать 3 разных запроса с использованием GROUP BY + HAVING. Для
-- каждого запроса написать комментарий с пояснением, какую информацию
-- извлекает запрос. Запрос должен быть осмысленным, т.е. находить информацию,
-- которую можно использовать.

--Выводит города, в которых больше 1 кинотеатра
SELECT location, COUNT(*)
FROM cinema
GROUP BY location
HAVING COUNT(*) > 1;

--Выводит года, в которых количество выпущенных фильмов превышает 1
SELECT EXTRACT(YEAR FROM release_date), COUNT(*)
FROM movie
GROUP BY release_date
HAVING COUNT(*) > 1;

--Выводит номера телефонов, которые используются более чем в 3 кинотеатрах
SELECT number_phone, COUNT(*)
FROM cinema
GROUP BY number_phone
HAVING COUNT(*) > 1;


-- 3.9. SELECT JOIN
-- a. LEFT JOIN двух таблиц и WHERE по одному из атрибутов

SELECT *
FROM movie
LEFT JOIN film_rental ON movie.id = film_rental.movie_id
WHERE EXTRACT(YEAR FROM release_date) = '2025';

-- b. RIGHT JOIN. Получить такую же выборку, как и в 3.9 a
SELECT *
FROM film_rental
RIGHT JOIN movie ON film_rental.movie_id = movie.id
WHERE EXTRACT(YEAR FROM release_date) = '2025';

-- c. LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT *
FROM movie
LEFT JOIN film_rental ON film_rental.movie_id = movie.id
LEFT JOIN cinema ON film_rental.cinema_id = cinema.id
WHERE EXTRACT(YEAR FROM release_date) = '2025'
  AND film_rental.duration > 20
  AND number_phone = '12-12-12';


-- d. INNER JOIN двух таблиц
SELECT *
FROM movie
JOIN film_rental ON film_rental.movie_id = movie.id;


-- 3.10. Подзапросы
-- a. Написать запрос с условием WHERE IN (подзапрос)
SELECT *
FROM "user"
WHERE id IN (SELECT user_id
             FROM ticket);

-- b. Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
SELECT first_name,
       phone_number,
       (SELECT COUNT(*) FROM ticket WHERE "user".id = ticket.user_id) AS count_tickets
FROM "user";

-- c. Написать запрос вида SELECT * FROM (подзапрос)

SELECT *
FROM (SELECT *
      FROM film_rental
      WHERE movie_id IS NOT NULL) as rental_movies
WHERE duration > 20;

-- d. Написать запрос вида SELECT * FROM table JOIN (подзапрос) ON …

SELECT first_name, email, phone_number, tickets.purchase_date, tickets.seat_number FROM "user"
LEFT JOIN (
    SELECT * FROM ticket
) as tickets ON "user".id = tickets.user_id;