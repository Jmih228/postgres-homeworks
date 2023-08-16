-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

-- Не нашел каким образом  связать таблицу shippers и orders (я так понимаю таблицы customers и employees нужно связывать
-- именно через нее) и где вообще указана информация по тому, какая компания ведет доставку заказа и с какой таблицей
--  связана таблица shippers. Подскажите пожалуйста как решить вышеуказанные проблемы, заранее спасибо

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT product_name, units_in_stock, contact_name, phone
FROM categories JOIN products USING(category_id) JOIN suppliers USING(supplier_id)
WHERE units_in_stock < 25 AND discontinued = 0 AND
(category_name = 'Condiments' OR category_name = 'Dairy Products')
ORDER BY units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name
FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM customers
				  INTERSECT
				  SELECT DISTINCT(customer_id) FROM orders)
-- Хотел решить через функцию EXISTS, но в таблице orders информация только по customer_id, а не company_name, поэтому
-- решил таким образом

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT(product_name)
FROM products
WHERE product_id IN (SELECT product_id FROM order_details
					 WHERE quantity = 10)