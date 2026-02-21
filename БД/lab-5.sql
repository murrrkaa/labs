-- 1 Добавить внешние ключи.
    ALTER TABLE company ADD PRIMARY KEY (id_company);
    ALTER TABLE dealer ADD PRIMARY KEY (id_dealer);
    ALTER TABLE medicine ADD PRIMARY KEY (id_medicine);
    ALTER TABLE "order" ADD PRIMARY KEY (id_order);
    ALTER TABLE pharmacy ADD PRIMARY KEY (id_pharmacy);
    ALTER TABLE production ADD PRIMARY KEY (id_production);

    ALTER TABLE dealer
        ADD  FOREIGN KEY (id_company)
        REFERENCES company(id_company);

    ALTER TABLE "order"
        ADD FOREIGN KEY (id_production)
        REFERENCES production(id_production);

    ALTER TABLE "order"
        ADD FOREIGN KEY (id_dealer)
        REFERENCES dealer(id_dealer);

    ALTER TABLE "order"
    ALTER COLUMN id_pharmacy type INTEGER USING id_pharmacy::integer;

    ALTER TABLE "order"
        ADD FOREIGN KEY (id_pharmacy)
        REFERENCES pharmacy(id_pharmacy);

    ALTER TABLE production
        ADD FOREIGN KEY (id_company)
        REFERENCES company(id_company);

    ALTER TABLE production
        ADD FOREIGN KEY (id_medicine)
        REFERENCES medicine(id_medicine);

-- 2 Выдать информацию по всем заказам лекарствам “Кордерон” компании “Аргус”
-- с указанием названий аптек, дат, объема заказов.

    SELECT pharmacy.name, "order".date, "order".quantity FROM (
        SELECT id_production FROM production
        WHERE id_medicine = (SELECT id_medicine FROM medicine WHERE name = 'Кордерон')
        AND id_company = (SELECT id_company FROM company WHERE name = 'Аргус')) as production
    JOIN "order" ON "order".id_production = production.id_production
    JOIN pharmacy ON "order".id_pharmacy = pharmacy.id_pharmacy;


-- 3 Дать список лекарств компании “Фарма”, на которые не были сделаны заказы
-- до 25 января.

    SELECT company.name, medicine.name, "order".id_order FROM production
    JOIN medicine ON production.id_medicine = medicine.id_medicine
    JOIN company ON production.id_company = company.id_company
    LEFT JOIN "order"  ON production.id_production = "order".id_production AND "order".date < '2019-01-25'
    WHERE company.name = 'Фарма' AND "order".id_order IS NULL;

-- 4 Дать минимальный и максимальный баллы лекарств каждой фирмы, которая
-- оформила не менее 120 заказов.

    SELECT company.name , MIN(production.rating) AS min_rating, MAX(production.rating) AS max_rating FROM production
    JOIN "order" ON production.id_production = "order".id_production
    JOIN company ON production.id_company = company.id_company
    JOIN medicine ON production.id_medicine = medicine.id_medicine
    GROUP BY company.name HAVING COUNT("order".id_order) >= 120;


-- 5 Дать списки сделавших заказы аптек по всем дилерам компании “AstraZeneca”.
-- Если у дилера нет заказов, в названии аптеки проставить NULL.

    SELECT pharmacy.name, dealer.name, company.name, "order".id_order FROM company
    JOIN dealer ON company.id_company = dealer.id_company
    LEFT JOIN "order" ON "order".id_dealer = dealer.id_dealer
    LEFT JOIN pharmacy ON pharmacy.id_pharmacy = "order".id_pharmacy
    WHERE company.name = 'AstraZeneca';

-- 6 Уменьшить на 20% стоимость всех лекарств, если она превышает 3000, а
-- длительность лечения не более 7 дней.

    UPDATE production SET price = price * 0.8 WHERE price::numeric > 3000 AND id_medicine IN (
        SELECT id_medicine FROM medicine WHERE cure_duration <= 7
        );


-- 7 Добавить необходимые индексы.

    CREATE INDEX IX_dealer_id_company ON dealer(id_company);

    CREATE INDEX IX_order_id_production ON "order"(id_production);

    CREATE INDEX IX_order_id_dealer ON "order"(id_dealer);

    CREATE INDEX IX_order_id_pharmacy ON "order"(id_pharmacy);

    CREATE INDEX IX_production_id_company ON production(id_company);

    CREATE INDEX IX_production_id_medicine ON production(id_medicine);

    CREATE INDEX IX_company_company_name ON company(name);

    CREATE INDEX IX_medicine_medicine_name ON medicine(name);

    CREATE INDEX IX_order_order_date ON "order"(date);


