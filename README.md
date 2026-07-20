### Шаг 1. Поднять контейнер PostgreSQL
### команды в терминале
### запускаем контейнер:

docker run --name pg-shop -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=shop -p 5432:5432 -d postgres:16

#вывод:
5f74cba0d690747e63f95997503a725328604b735e2acd40e8a444a301f67e65 
### (это id нового Docker-контейнера)

### проверяем, что контейнер запустился:

docker ps

#вывод: 
CONTAINER ID   IMAGE         COMMAND                  CREATED         STATUS         PORTS                                         NAMES
5f74cba0d690   postgres:16   "docker-entrypoint.s…"   9 seconds ago   Up 9 seconds   0.0.0.0:5432->5432/tcp, [::]:5432->5432/tcp   pg-shop

### Шаг 2. Подключиться к базе данных
### у меня DBeaver (могут быть другие инструменты)

в DBeaver создаем новое соединение с бд (значок под File), выбираем PostgreSQL
вводим следующие данные при настройке соединения:

- хост: `localhost`
- порт: `5432`
- база: `shop`
- пользователь: `postgres`
- пароль: `secret`

Можно сделать Connection test (скрин успешного теста во вложениях)

Бонусное задание В.
1) Ограничение check_title_not_empty на создание товаров с названием пустой строкой (''), или строкой из n-го количества пробелов.
   Необходимо, чтобы при отображении в каталоге, например, на сайте, не было товаров с пустым названием
2) Ограничение unique_products_title на уникальность названия товара.
   Необходимо, чтобы не возникло путаницы при формировании заказов пользователем на сайте, например.
   
Бонусное задание С.
1) План без индекса
	Seq Scan on big_orders  (cost=0.00..3582.00 rows=20 width=16)
2) План с индексом
	Bitmap Heap Scan on big_orders  (cost=4.45..76.54 rows=20 width=16)
  Recheck Cond: (customer_id = 100)
  ->  Bitmap Index Scan on idx_big_orders_customer_id  (cost=0.00..4.45 rows=20 width=0)
        Index Cond: (customer_id = 100)
        
Если вкратце, как я поняла, Seq Scan сканит всю таблицу, стоимость запросы при этом 3582.00.
Когда мы добавили идендекс: Bitmap Index Scan (открывается индекс, находятся строки, стоимость 4.45) -> адреса строк из индекса передаются Bitmap Heap Scan, из таблицы достаем данные (76.54 финальная стоимость).

