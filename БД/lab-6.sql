-- 1 Добавить внешние ключи.
ALTER TABLE booking
    ADD PRIMARY KEY (id_booking);
ALTER TABLE client
    ADD PRIMARY KEY (id_client);
ALTER TABLE hotel
    ADD PRIMARY KEY (id_hotel);
ALTER TABLE room
    ADD PRIMARY KEY (id_room);
ALTER TABLE room_category
    ADD PRIMARY KEY (id_room_category);
ALTER TABLE room_in_booking
    ADD PRIMARY KEY (id_room_in_booking);

ALTER TABLE booking
    ADD FOREIGN KEY (id_client) REFERENCES client (id_client);
ALTER TABLE room
    ADD FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel);
ALTER TABLE room
    ADD FOREIGN KEY (id_room_category) REFERENCES room_category (id_room_category);
ALTER TABLE room_in_booking
    ADD FOREIGN KEY (id_room) REFERENCES room (id_room);
ALTER TABLE room_in_booking
    ADD FOREIGN KEY (id_booking) REFERENCES booking (id_booking);

--2 Выдать информацию о клиентах гостиницы “Космос”, проживающих в номерах
--категории “Люкс” на 1 апреля 2019г.

SELECT client.name AS client_name
FROM client
         JOIN booking ON client.id_client = booking.id_client
         JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking
         JOIN room ON room_in_booking.id_room = room.id_room
         JOIN room_category ON room.id_room_category = room_category.id_room_category
         JOIN hotel ON room.id_hotel = hotel.id_hotel
WHERE hotel.name = 'Космос'
  AND room_category.name = 'Люкс'
  AND (room_in_booking.checkin_date <= '2019-04-01' AND '2019-04-01' < room_in_booking.checkout_date);

--3 Дать список свободных номеров всех гостиниц на 22 апреля.

SELECT hotel.name, room.number
FROM room
         JOIN hotel ON room.id_hotel = hotel.id_hotel
WHERE room.id_room NOT IN (SELECT id_room
                           FROM room_in_booking
                           WHERE room_in_booking.checkin_date <= '2019-04-22'
                             AND '2019-04-22' < room_in_booking.checkout_date);

--4 Дать количество проживающих в гостинице “Космос” на 23 марта по каждой
--категории номеров

SELECT room_category.name, COUNT(client.name)
FROM hotel
         JOIN room ON hotel.id_hotel = room.id_hotel AND hotel.name = 'Космос'
         JOIN room_category ON room.id_room_category = room_category.id_room_category
         JOIN room_in_booking ON room.id_room = room_in_booking.id_room
         JOIN booking ON room_in_booking.id_booking = booking.id_booking
         JOIN client ON booking.id_client = client.id_client
WHERE room_in_booking.checkin_date <= '2019-03-23'
  AND '2019-03-23' < room_in_booking.checkout_date
GROUP BY room_category.name;

-- 5 Дать список последних проживавших клиентов по всем комнатам гостиницы
-- “Космос”, выехавшим в апреле с указанием даты выезда.

SELECT client.name, room_in_booking.checkout_date, room.number
FROM client
         JOIN booking ON client.id_client = booking.id_client
         JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking
         JOIN room ON room_in_booking.id_room = room.id_room
         JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = 'Космос'
         JOIN (SELECT room.id_room, MAX(room_in_booking.checkout_date) AS max_checkout
               FROM room
                        JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = 'Космос'
                        JOIN room_in_booking ON room.id_room = room_in_booking.id_room
               WHERE checkout_date >= '2019-04-01'
                 AND checkout_date <= '2019-04-30'
               GROUP BY room.id_room) as max_checkout_room ON room.id_room = max_checkout_room.id_room
WHERE room_in_booking.checkout_date = max_checkout_room.max_checkout;

-- 6 Продлить на 2 дня дату проживания в гостинице “Космос” всем клиентам
-- комнат категории “Бизнес”, которые заселились 10 мая.

UPDATE room_in_booking
SET checkout_date = checkout_date + INTERVAL '2 days'
WHERE id_room IN (SELECT room.id_room
                  FROM room_in_booking
                           JOIN room ON room_in_booking.id_room = room.id_room
                           JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = 'Космос'
                           JOIN room_category ON room.id_room_category = room_category.id_room_category AND
                                                 room_category.name = 'Бизнес'
                           JOIN booking ON room_in_booking.id_booking = booking.id_booking
                           JOIN client ON booking.id_client = client.id_client
                  WHERE checkin_date = '2019-05-10');

-- 7 Найти все "пересекающиеся" варианты проживания. Правильное состояние: не
-- может быть забронирован один номер на одну дату несколько раз, т.к. нельзя
-- заселиться нескольким клиентам в один номер. Записи в таблице
-- room_in_booking с id_room_in_booking = 5 и 2154 являются примером
-- неправильного состояния, которые необходимо найти. Результирующий кортеж
-- выборки должен содержать информацию о двух конфликтующих номерах.

SELECT hotel.name,
       room.number,
       client_1.name,
       client_2.name,
       room_in_booking_1.checkin_date,
       room_in_booking_1.checkout_date,
       room_in_booking_2.checkin_date,
       room_in_booking_2.checkout_date
FROM room_in_booking as room_in_booking_1
         JOIN room_in_booking as room_in_booking_2 ON room_in_booking_1.id_room_in_booking < room_in_booking_2.id_room_in_booking AND room_in_booking_1.id_room = room_in_booking_2.id_room AND (
    room_in_booking_1.checkin_date < room_in_booking_2.checkout_date AND
    room_in_booking_1.checkout_date > room_in_booking_2.checkin_date
    )
         JOIN booking as booking_1 ON room_in_booking_1.id_booking = booking_1.id_booking
         JOIN booking as booking_2 ON room_in_booking_2.id_booking = booking_2.id_booking
         JOIN client as client_1 ON booking_1.id_client = client_1.id_client
         JOIN client as client_2 ON booking_2.id_client = client_2.id_client
         JOIN room ON room_in_booking_1.id_room = room.id_room
         JOIN hotel ON room.id_hotel = hotel.id_hotel
ORDER BY room.number;

-- 8 Создать бронирование в транзакции.
BEGIN TRANSACTION;

INSERT INTO client VALUES (DEFAULT, 'Новый Клиент Клиентович', '20-30-50');

SELECT id_client FROM client
ORDER BY id_client DESC LIMIT 1;

INSERT INTO booking VALUES (DEFAULT, 102, '2019-03-20');

SELECT id_booking FROM booking
ORDER BY id_booking DESC LIMIT 1;

SELECT COUNT(*) FROM room_in_booking
WHERE id_room = 8
  AND checkin_date < '2020-04-02'
  AND checkout_date > '2020-04-15';

INSERT INTO room_in_booking VALUES (DEFAULT, 2007, 8, '2020-04-02', '2020-04-15');

COMMIT;

ROLLBACK;

-- 9 Добавить необходимые индексы для всех таблиц.

CREATE INDEX IX_booking_id_client ON booking(id_client);

CREATE INDEX IX_room_id_hotel ON room(id_hotel);

CREATE INDEX IX_room_id_room_category ON room(id_room_category);

CREATE INDEX IX_room_in_booking_id_room ON room_in_booking(id_room);

CREATE INDEX IX_room_in_booking_id_booking ON room_in_booking(id_booking);

CREATE INDEX IX_hotel_name ON hotel(name);

CREATE INDEX IX_room_category_name ON room_category(name);

CREATE INDEX IX_room_in_booking_checkin_date ON room_in_booking(checkin_date);

CREATE INDEX IX_room_in_booking_checkout_date ON room_in_booking(checkout_date);
