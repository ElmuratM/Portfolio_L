# ////////////////// ЗАДАНИЕ №1 ///////////////////
DROP DATABASE users_adverts;
CREATE DATABASE users_adverts;

DROP TABLE users;
CREATE TABLE users (
date DATE,
user_id VARCHAR (100),
view_adverts INT
)
SELECT * FROM users;

#1 Напишите запрос SQL, выводящий одним числом количество уникальных пользователей в этой таблице в период с 2023-11-07 по 2023-11-15.
SELECT COUNT(DISTINCT user_id)
FROM users
WHERE date BETWEEN '2023-11-07' AND '2023-11-15';

#2 Определите пользователя, который за весь период посмотрел наибольшее количество объявлений. 
SELECT user_id, view_adverts
FROM users
ORDER BY view_adverts DESC
LIMIT 1;

#3 Определите день с наибольшим средним количеством просмотренных рекламных объявлений на пользователя, но учитывайте только дни с более чем 500 уникальными пользователями.
SELECT date, AVG(view_adverts) AS avg_views
FROM users
GROUP BY date
HAVING COUNT(DISTINCT user_id) > 500
ORDER BY avg_views DESC
LIMIT 1;

#4 Напишите запрос возвращающий LT (продолжительность присутствия пользователя на сайте) по каждому пользователю. Отсортировать LT по убыванию.
SELECT 
	user_id,
	TIMESTAMPDIFF (DAY, MIN(date), MAX(date)) AS LT_days
FROM users
GROUP BY user_id
ORDER BY LT_days DESC;

#5 Для каждого пользователя подсчитайте среднее количество просмотренной рекламы за день, а затем выясните, у кого самый высокий средний показатель среди тех, кто был активен как минимум в 5 разных дней.
SELECT 
	user_id, 
	AVG(view_adverts) AS avg_ads_per_day
FROM users
GROUP BY user_id
HAVING COUNT(DISTINCT date) >= 5
ORDER BY avg_ads_per_day DESC
LIMIT 1;




# ////////////////// ЗАДАНИЕ №2 ///////////////////
DROP DATABASE mini_project;
CREATE DATABASE mini_project;

# Таблица №1
DROP TABLE T_TAB1;
CREATE TABLE T_TAB1 (
ID INT UNIQUE,
GOODS_TYPE VARCHAR (50),
QUANTITY INT,
AMOUNT INT,
SELLER_NAME VARCHAR (50)
)
SELECT * FROM T_TAB1;

INSERT INTO t_tab1 (ID, GOODS_TYPE, QUANTITY, AMOUNT, SELLER_NAME)
VALUES (1, 'MOBILE PHONE', 2, 400000, 'MIKE'),
	   (2, 'KEYBOARD', 1, 10000, 'MIKE'),
	   (3, 'MOBILE PHONE', 1, 50000, 'JANE'),
       (4, 'MONITOR', 1, 110000, 'JOE'),
       (5, 'MONITOR', 2, 80000, 'JANE'),
	   (6, 'MOBILE PHONE', 1, 130000, 'JOE'),
       (7, 'MOBILE PHONE', 1, 60000, 'ANNA'),
       (8, 'PRINTER', 1, 90000, 'ANNA'),
       (9, 'KEYBOARD', 2, 10000, 'ANNA'),
       (10, 'PRINTER', 1, 80000, 'MIKE');
       
# Таблица №2
DROP TABLE T_TAB2;
CREATE TABLE T_TAB2 (
ID INT UNIQUE,
NAME VARCHAR (50),
SALARY INT,
AGE INT
)
SELECT * FROM T_TAB2;
       
INSERT INTO T_TAB2 (ID, NAME, SALARY, AGE)
VALUES
    (1, 'ANNA', 110000, 27),
    (2, 'JANE', 80000, 25),
    (3, 'MIKE', 120000, 25),
    (4, 'JOE', 70000, 24),
    (5, 'RITA', 120000, 29);      

#1 Напишите запрос, который вернёт список уникальных категорий товаров (GOODS_TYPE). Какое количество уникальных категорий товаров вернёт запрос?
SELECT COUNT(DISTINCT GOODS_TYPE)
FROM T_TAB1;

#2 Напишите запрос, который вернет суммарное количество и суммарную стоимость проданных мобильных телефонов. Какое суммарное количество и суммарную стоимость вернул запрос?
SELECT 
	SUM(QUANTITY), 
	SUM(AMOUNT)
FROM T_TAB1
WHERE GOODS_TYPE = 'MOBILE PHONE';

#3 Напишите запрос, который вернёт список сотрудников с заработной платой > 100000. Какое кол-во сотрудников вернул запрос?
SELECT COUNT(NAME)
FROM T_TAB2
WHERE SALARY > 100000;

#4 Напишите запрос, который вернёт минимальный и максимальный возраст сотрудников, а также минимальную и максимальную заработную плату.
SELECT 
	MAX(AGE) as max_age,
    MIN(AGE) as min_age,
    MAX(SALARY) as max_salary,
	MIN(SALARY) as min_salary
FROM t_tab2;

#5 Напишите запрос, который вернёт среднее количество проданных клавиатур и принтеров.
SELECT 
	GOODS_TYPE,
	AVG(QUANTITY)
FROM t_tab1
WHERE GOODS_TYPE IN ('KEYBOARD', 'PRINTER')
GROUP BY GOODS_TYPE;

#6 Напишите запрос, который вернёт имя сотрудника и суммарную стоимость проданных им товаров.
SELECT SELLER_NAME, SUM(AMOUNT) AS TOTAL_AMOUNT
FROM t_tab1
GROUP BY SELLER_NAME
ORDER BY TOTAL_AMOUNT DESC
LIMIT 1;

#7 Напишите запрос, который вернёт имя сотрудника, тип товара, кол-во товара, стоимость товара, заработную плату и возраст сотрудника MIKE.
SELECT a.*, b.SALARY, b.AGE
FROM t_tab1 a
JOIN t_tab2 b ON a.ID = b.ID
WHERE SELLER_NAME = 'MIKE';

#8 Напишите запрос, который вернёт имя и возраст сотрудника, который ничего не продал. Сколько таких сотрудников?
SELECT a.NAME, a.AGE
FROM t_tab2 a
LEFT JOIN T_TAB1 b ON b.SELLER_NAME = a.NAME
WHERE b.SELLER_NAME IS NULL;

#9 Напишите запрос, который вернёт имя сотрудника и его заработную плату с возрастом меньше 26 лет? Какое количество строк вернул запрос? 
SELECT NAME, SALARY, AGE
FROM t_tab2
WHERE AGE <26;
# Ответ на второй вопрос: вернет 3 строки

#10 Сколько строк вернёт следующий запрос:
SELECT * FROM T_TAB1 t
JOIN T_TAB2 t2 ON t2.name = t.seller_name
WHERE t2.name = 'RITA';
# Ответ: вернет 0 строк
