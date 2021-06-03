CREATE TABLE ZIP (
   zip_code numeric(3,0) PRIMARY KEY CHECK (zip_code > 99),
   city varchar(30)
);
 
 
-----------------------------------------------------------------------------------
INSERT INTO zip VALUES(100,'Tórshavn');
INSERT INTO zip VALUES(160,'Argir');
INSERT INTO zip VALUES(175,'Kirkjubøur');
INSERT INTO zip VALUES(176,'Velbastaður');
INSERT INTO zip VALUES(177,'Syðradalur');
INSERT INTO zip VALUES(178,'Norðradalur');
INSERT INTO zip VALUES(180,'Kaldbak');
INSERT INTO zip VALUES(185,'Kaldbaksbotnur');
INSERT INTO zip VALUES(186,'Sund');
INSERT INTO zip VALUES(187,'Hvítanes');
INSERT INTO zip VALUES(188,'Hoyvík');
INSERT INTO zip VALUES(210,'Sandur');
INSERT INTO zip VALUES(220,'Skálavík');
INSERT INTO zip VALUES(230,'Húsavík');
INSERT INTO zip VALUES(235,'Dalur');
INSERT INTO zip VALUES(236,'Skarvanes');
INSERT INTO zip VALUES(240,'Skopun');
INSERT INTO zip VALUES(260,'Skúvoy');
INSERT INTO zip VALUES(270,'Nólsoy');
INSERT INTO zip VALUES(280,'Hestur');
INSERT INTO zip VALUES(285,'Koltur');
INSERT INTO zip VALUES(286,'Stóra Dímun');
INSERT INTO zip VALUES(330,'Stykkið');
INSERT INTO zip VALUES(335,'Leynar');
INSERT INTO zip VALUES(336,'Skælingur');
INSERT INTO zip VALUES(340,'Kvívík');
INSERT INTO zip VALUES(350,'Vestmanna');
INSERT INTO zip VALUES(358,'Válur');
INSERT INTO zip VALUES(360,'Sandavágur');
INSERT INTO zip VALUES(370,'Miðvágur');
INSERT INTO zip VALUES(380,'Sørvágur');
INSERT INTO zip VALUES(385,'Vatnsoyrar');
INSERT INTO zip VALUES(386,'Bøur');
INSERT INTO zip VALUES(387,'Gásadalur');
INSERT INTO zip VALUES(388,'Mykines');
INSERT INTO zip VALUES(400,'Oyrarbakki');
INSERT INTO zip VALUES(410,'Kollafjørður');
INSERT INTO zip VALUES(415,'Oyrareingir');
INSERT INTO zip VALUES(416,'Signabøur');
INSERT INTO zip VALUES(420,'Hósvík');
INSERT INTO zip VALUES(430,'Hvalvík');
INSERT INTO zip VALUES(435,'Streymnes');
INSERT INTO zip VALUES(436,'Saksun');
INSERT INTO zip VALUES(437,'Nesvík');
INSERT INTO zip VALUES(438,'Langasandur');
INSERT INTO zip VALUES(440,'Haldarsvík');
INSERT INTO zip VALUES(445,'Tjørnuvík');
INSERT INTO zip VALUES(450,'Oyri');
INSERT INTO zip VALUES(460,'Norðskáli');
INSERT INTO zip VALUES(465,'Svínáir');
INSERT INTO zip VALUES(466,'Ljósá');
INSERT INTO zip VALUES(470,'Eiði');
INSERT INTO zip VALUES(475,'Funningur');
INSERT INTO zip VALUES(476,'Gjógv');
INSERT INTO zip VALUES(477,'Funningsfjørður');
INSERT INTO zip VALUES(478,'Elduvík');
INSERT INTO zip VALUES(480,'Skáli');
INSERT INTO zip VALUES(485,'Skálabotnur');
INSERT INTO zip VALUES(490,'Strendur');
INSERT INTO zip VALUES(494,'Innan Glyvur');
INSERT INTO zip VALUES(495,'Kolbanargjógv');
INSERT INTO zip VALUES(496,'Morskranes');
INSERT INTO zip VALUES(497,'Selatrað');
INSERT INTO zip VALUES(510,'Gøta');
INSERT INTO zip VALUES(511,'Gøtugjógv');
INSERT INTO zip VALUES(512,'Norðragøta');
INSERT INTO zip VALUES(513,'Syðrugøta');
INSERT INTO zip VALUES(520,'Leirvík');
INSERT INTO zip VALUES(530,'Fuglafjørður');
INSERT INTO zip VALUES(600,'Saltangará');
INSERT INTO zip VALUES(620,'Runavík');
INSERT INTO zip VALUES(625,'Glyvrar');
INSERT INTO zip VALUES(626,'Lambareiði');
INSERT INTO zip VALUES(627,'Lambi');
INSERT INTO zip VALUES(640,'Rituvík');
INSERT INTO zip VALUES(645,'Æðuvík');
INSERT INTO zip VALUES(650,'Toftir');
INSERT INTO zip VALUES(655,'Nes');
INSERT INTO zip VALUES(656,'Saltnes');
INSERT INTO zip VALUES(660,'Søldarfjørður');
INSERT INTO zip VALUES(665,'Skipanes');
INSERT INTO zip VALUES(666,'Gøtueiði');
INSERT INTO zip VALUES(690,'Oyndarfjørður');
INSERT INTO zip VALUES(695,'Hellur');
INSERT INTO zip VALUES(700,'Klaksvík');
INSERT INTO zip VALUES(725,'Norðoyri');
INSERT INTO zip VALUES(726,'Ánir');
INSERT INTO zip VALUES(727,'Árnafjørður');
INSERT INTO zip VALUES(730,'Norðdepil');
INSERT INTO zip VALUES(735,'Depil');
INSERT INTO zip VALUES(736,'Norðtoftir');
INSERT INTO zip VALUES(737,'Múli');
INSERT INTO zip VALUES(740,'Hvannasund');
INSERT INTO zip VALUES(750,'Viðareiði');
INSERT INTO zip VALUES(765,'Svínoy');
INSERT INTO zip VALUES(766,'Kirkja');
INSERT INTO zip VALUES(767,'Hattarvík');
INSERT INTO zip VALUES(780,'Kunoy');
INSERT INTO zip VALUES(785,'Haraldssund');
INSERT INTO zip VALUES(795,'Syðradalur');
INSERT INTO zip VALUES(796,'Húsar');
INSERT INTO zip VALUES(797,'Mikladalur');
INSERT INTO zip VALUES(798,'Trøllanes');
INSERT INTO zip VALUES(800,'Tvøroyri');
INSERT INTO zip VALUES(825,'Froðba');
INSERT INTO zip VALUES(826,'Trongisvágur');
INSERT INTO zip VALUES(827,'Øravík');
INSERT INTO zip VALUES(850,'Hvalba');
INSERT INTO zip VALUES(860,'Sandvík');
INSERT INTO zip VALUES(870,'Fámjin');
INSERT INTO zip VALUES(900,'Vágur');
INSERT INTO zip VALUES(925,'Nes');
INSERT INTO zip VALUES(926,'Lopra');
INSERT INTO zip VALUES(927,'Akrar');
INSERT INTO zip VALUES(928,'Víkarbyrgi');
INSERT INTO zip VALUES(950,'Porkeri');
INSERT INTO zip VALUES(960,'Hov');
INSERT INTO zip VALUES(970,'Sumba');
-----------------------------------------------------------------------------------
 
CREATE TABLE Person (
 ptal varchar(9) PRIMARY KEY,
 first_name varchar(30) NOT NULL,
 middle_name varchar(30),
 last_name varchar(30) NOT NULL,
 street_name varchar(30) NOT NULL,
 street_number NUMERIC(3,0) NOT NULL CHECK (street_number > 0),
 email varchar(50) UNIQUE NOT NULL,
 phone_number numeric(6,0) NOT NULL,
 zip_code numeric(3,0),
 FOREIGN KEY (zip_code) REFERENCES ZIP
);
 
INSERT INTO Person
VALUES ('000000000', 'Bank', null, 'AAAE', 'Bankagøta', 4, 'aaae@bank.fo',
444444, 100);
 
CREATE TABLE Customer (
   customer_id SERIAL PRIMARY KEY,
   creation_date DATE DEFAULT CURRENT_DATE,
   ptal varchar(9) UNIQUE,
  FOREIGN KEY (ptal) REFERENCES Person
);
 
insert into customer
values (default, default, '000000000');
 
CREATE TABLE Employee (
  employee_id SERIAL PRIMARY KEY,
  job_title varchar(30) NOT NULL,
  employment_date DATE DEFAULT CURRENT_DATE,
  ptal varchar(9) UNIQUE,
  FOREIGN KEY (ptal) REFERENCES Person
);
 
CREATE TABLE AccountType (
   account_type numeric(2,0) PRIMARY KEY CHECK (account_type > 9),
   name varchar(30) NOT NULL,
   rent numeric(10,2) NOT NULL
);
 
CREATE TABLE Account (
   account_id numeric(11,0) PRIMARY KEY,
   balance numeric(10,2) DEFAULT 0,
   creation_date DATE DEFAULT CURRENT_DATE,
   account_type numeric(2,0),
   customer_id SERIAL,
   FOREIGN KEY (account_type) REFERENCES AccountType,
   FOREIGN KEY (customer_id) REFERENCES Customer
);
 
CREATE TABLE Bank (
   vtal numeric(6,0) PRIMARY KEY,
   name varchar(50) NOT NULL,
   street_name varchar(50) NOT NULL,
   street_number numeric(3,0) NOT NULL,
   email varchar(50) NOT NULL,
   phone_number numeric(6) CHECK (phone_number > 99999) NOT NULL,
   zip_code numeric(3,0),
   equity numeric(11,0),
   balance numeric(11,0),
   FOREIGN KEY (zip_code) REFERENCES ZIP,
   FOREIGN KEY (equity) REFERENCES Account,
   FOREIGN KEY (balance) REFERENCES Account
);
 
CREATE TABLE Transactions (
   transaction_id NUMERIC PRIMARY KEY,
   amount numeric(12,2) NOT NULL,
   creation_date DATE NOT NULL DEFAULT CURRENT_DATE,
   account_id NUMERIC,
   balance NUMERIC(10,2),
   FOREIGN KEY (account_id) REFERENCES Account
);
 
CREATE TABLE Relation (
 Relation_type varchar(30) PRIMARY KEY,
 Partner_or_parent varchar(9),
 Partner_or_child varchar(9),
 FOREIGN KEY (Partner_or_parent) REFERENCES Person,
 FOREIGN KEY (Partner_or_child) REFERENCES Person
);
 
CREATE TABLE Cashdraft (
 operator SERIAL PRIMARY KEY,
 date DATE NOT NULL DEFAULT CURRENT_DATE,
 balance numeric(12,2),
 account_id numeric(7,0),
 employee_id SERIAL,
 FOREIGN KEY (account_id) REFERENCES Account,
 FOREIGN KEY (employee_id) REFERENCES Employee
);
 
CREATE TABLE Customerlogin (
username varchar(50) PRIMARY KEY,
customer_id SERIAL,
FOREIGN KEY (customer_id) REFERENCES Customer
);
 
CREATE TABLE Employeelogin (
username int PRIMARY KEY,
employee_id SERIAL,
FOREIGN KEY (employee_id ) REFERENCES Employee
);
 
CREATE TABLE RENTUROKNING
   (	FRA_DATO DATE NOT NULL, 
	TIL_DATO DATE NOT NULL, 
	SUM_RENTA numeric(12,2), 
	RENTUPROSENT numeric(2,0), 
	PRIMARY KEY (FRA_DATO)
   );
 
INSERT INTO renturokning
VALUES ('2021-01-01', '2021-01-01', 0, 3);
 
 
-----------------------------TRIGGER insert_account--------------------------------
CREATE SEQUENCE account_id_seq;
 
CREATE FUNCTION public.insert_account()
    RETURNS trigger
    LANGUAGE 'plpgsql'
	
AS $BODY$
DECLARE
next_account NUMERIC;
tvorsum NUMERIC;
rest NUMERIC;
acc VARCHAR(11);
BEGIN
loop
select nextval('account_id_seq') into next_account;
-- skrásetingarnummar er 6460 og kontonummar byrjar við 41 fyri vanligar konti
-- síðan kemur eitt raðtal frá teljaranum
acc := '6460' || trim(to_char(new.account_type, '00')) || trim(to_char(next_account, '0000'));
new.account_id := acc;
tvorsum := 5 * to_number(substr(acc, 1, 1), '9') +
           4 * to_number(substr(acc, 2, 1), '9') +
           3 * to_number(substr(acc, 3, 1), '9') +
           2 * to_number(substr(acc, 4, 1), '9') +
           7 * to_number(substr(acc, 5, 1), '9') +
           6 * to_number(substr(acc, 6, 1), '9') +
           5 * to_number(substr(acc, 7, 1), '9') +
           4 * to_number(substr(acc, 8, 1), '9') +
           3 * to_number(substr(acc, 9, 1), '9') +
           2 * to_number(substr(acc, 10, 1), '9');
rest := 11 - mod(tvorsum,11);
exit when rest < 10; -- endurtak um rest er 10
end loop;
new.account_id := to_number(acc, '99999999999') * 10 + rest;
  return new;
END;
$BODY$;
 
CREATE TRIGGER insert_account
    BEFORE INSERT ON Account
    FOR EACH ROW
    EXECUTE PROCEDURE insert_account();
-----------------------------------------------------------------------------------
 
-----------------------------TRIGGER check_ptal------------------------------------
 
create function is_valid_date(days varchar(2), months varchar(2))
    RETURNS BOOLEAN
	LANGUAGE 'plpgsql'
AS $$
 
BEGIN
	IF months IN ('02') THEN
		IF (to_number(days, '99') <= 28) THEN
			return TRUE;
		ELSE
			return FALSE;
		END IF;
	ELSEIF months IN ('04', '06', '09', '11') THEN
		IF (to_number(days, '99') <= 30) THEN
			return TRUE;
		ELSE
			return FALSE;
		END IF;
	ELSEIF months IN ('01', '03', '05', '07', '08', '10', '12') THEN
		IF (to_number(days, '99') <= 31) THEN
			return TRUE;
		ELSE
			return FALSE;
		END IF;
	ELSE
		return false;
	END IF;
END;
$$;
 
 
CREATE FUNCTION public.check_ptal()
    RETURNS trigger
    LANGUAGE 'plpgsql'
AS $$
 
DECLARE
days VARCHAR(2);
months VARCHAR(2);
tvorsum NUMERIC;
rest NUMERIC;
BEGIN
	days := substr(new.ptal, 1, 2);
	months := substr(new.ptal, 3, 2);
	IF LENGTH(new.ptal) = 9 AND is_valid_date(days, months) THEN
		tvorsum := 3 * to_number(substr(new.ptal, 1, 1), '9') +
				   2 * to_number(substr(new.ptal, 2, 1), '9') +
				   7 * to_number(substr(new.ptal, 3, 1), '9') +
				   6 * to_number(substr(new.ptal, 4, 1), '9') +
				   5 * to_number(substr(new.ptal, 5, 1), '9') +
				   4 * to_number(substr(new.ptal, 6, 1), '9') +
				   3 * to_number(substr(new.ptal, 7, 1), '9') +
				   2 * to_number(substr(new.ptal, 8, 1), '9') +
				   1 * to_number(substr(new.ptal, 9, 1), '9');
 
		rest := mod(tvorsum,11);
	END IF;
	IF (rest = 0) THEN
		return new;
	ELSE
		raise exception '% is a invalid ptal', new.ptal;
	END IF;
END;
$$;
 
CREATE TRIGGER check_ptal
    BEFORE INSERT ON Person
    FOR EACH ROW
    EXECUTE PROCEDURE check_ptal();
 
 
 
insert into accounttype
values (11, 'Vanlig konta', 0.5);
 
insert into accounttype
values (12, 'Uppsparing', 3.0);
 
insert into accounttype
values (13, 'Barnakonta', 4.0);
 
insert into accounttype
values (14, 'Fíggjarkonta', 0.5);
 
insert into accounttype
values (20, 'Balance', 0.0);
 
insert into accounttype
values (30, 'Equity', 0.0);
 
 
insert into person
values ('240395037', 'Kim', 'Michael', 'Hansen', 'Heygavegur', 12, 'kmh@gmail.com', 271809, 530);
 
insert into person
values ('241144089', 'Hans', 'Emil', 'Joensen', 'Innandalsvegur', 6, 'hmj@gmail.com', 271988, 100);
 
insert into person
values ('280762016', 'Maria', 'Hansa', 'Petersen', 'Dalavegur', 13, 'map@gmail.com', 580907, 100);
 
insert into person
values ('220688011', 'Jens', 'Julian', 'Hansen', 'Gaddavegur', 20, 'jjh@hotmail.com', 276605, 655);
 
 
 
 
 
 
 
 
----------- Procedure for creating customer and customerlogin ---------------------
create procedure create_customer(temp_ptal VARCHAR)
language plpgsql   
as $$
DECLARE
temp_username VARCHAR(50);
temp_customer_id int;
begin
   INSERT INTO customer(ptal)
   VALUES(temp_ptal);
  
   SELECT email INTO temp_username
   FROM person
   WHERE ptal = temp_ptal;
 
   SELECT customer_id INTO temp_customer_id
   FROM customer
   WHERE ptal = temp_ptal;
 
   INSERT INTO customerlogin(username, customer_id)
   VALUES (temp_username, temp_customer_id);
end;$$;
-----------------------------------------------------------------------------------
call create_customer('240395037');
 
call create_customer('280762016');
 
call create_customer('241144089');
 
call create_customer('220688011');
 
insert into account (account_type, customer_id)
VALUES (20, 1);
 
insert into account (account_type, customer_id)
VALUES (30, 1);
 
insert into account (account_type, customer_id)
VALUES (11, 2);
 
insert into account (account_type, customer_id)
VALUES (11, 3);
 
insert into account (account_type, customer_id)
VALUES (11, 4);
insert into account (account_type, customer_id)
VALUES (11, 5);
--------
create sequence trans_seq;
 
CREATE FUNCTION public.transaction_insert()
   RETURNS trigger
   LANGUAGE 'plpgsql'
AS $$
 
BEGIN
   select nextval('trans_seq') into new.transaction_id;
   select CURRENT_DATE into new.creation_date;
   return new;
END;
$$;
CREATE TRIGGER transaction_insert
   BEFORE INSERT ON transactions
   FOR EACH ROW
   EXECUTE PROCEDURE transaction_insert();
--------
 
CREATE FUNCTION public.transaction_saldo()
   RETURNS trigger
   LANGUAGE 'plpgsql'
AS $$
 
BEGIN
   update account
   set balance = balance + new.amount
   where account_id = new.account_id;
   return new;
END;
$$;
 
create trigger transaction_saldo
   after insert on transactions
   for each row
   EXECUTE PROCEDURE transaction_saldo();
 
------
 
create procedure flyting(fra_konto numeric, til_konto numeric, upphaedd numeric)
language plpgsql
as $$
DECLARE
temp_konto numeric(12,0);
fra_balance numeric(10,2);
til_balance numeric(10,2);
begin
select account_id into temp_konto
from account
where account_id = fra_konto
for update;
 
select balance into fra_balance
from account
where account_id = fra_konto
for update;
 
select account_id into temp_konto
from account
where account_id = til_konto
for update;
 
select balance into til_balance
from account
where account_id = til_konto
for update;
raise notice 'Flytir kr. % frá konto % til konto %', upphaedd, fra_konto, til_konto;
insert into transactions
(amount, account_id, balance)
values
(-upphaedd, fra_konto, fra_balance - upphaedd);
insert into transactions
(amount, account_id, balance)
values
(upphaedd, til_konto, til_balance + upphaedd);
exception
 WHEN OTHERS THEN
 ROLLBACK;
 raise exception 'Inserts were rolled back - SKRIVA RÆTT KONTONUMMAR';
end; $$;
 
 
 
 
CREATE UNIQUE INDEX RENTUROKNING_TIL_DATO_IDX ON RENTUROKNING (TIL_DATO);
 
 
----CREATE FUNCTION RENTUROKNING_INS----
 
CREATE FUNCTION public.RENTUROKNING_INS()
    RETURNS trigger
    LANGUAGE 'plpgsql'
	
AS $$
 
BEGIN
	select max(til_dato)+1 into new.fra_dato 
    from renturokning;
    new.sum_renta := rokna_rentu(new.fra_dato, new.til_dato, new.rentuprosent/100);
  return new;
END;
$$;
 
 -----CREATE TRIGGER RENTUROKNING_INS------
 
CREATE TRIGGER RENTUROKNING_INS
before insert on renturokning
for each row
EXECUTE PROCEDURE RENTUROKNING_INS();
 
 
-----CREATE FUNCTION ROKNA_RENTU-----
 
create FUNCTION rokna_rentu(
    fra_dato_p  DATE,
    til_dato_p  DATE,
    rentufaktor numeric)
  RETURNS numeric
  LANGUAGE 'plpgsql'
AS $$
DECLARE
  -- Fyrst nakrir temp variablar til lokala utrokning
  sum_account numeric(12,2);
  sum_total   numeric(12,2);
  temp_saldo  numeric(12,2);
  temp_date   DATE;
  
  account_cur cursor for 
  select a.* 
  from account a
  ORDER BY account_id;
  
  
  trans_cur cursor (c_fra DATE, c_til DATE, c_account numeric) for 
  select t.* 
  from transaction t
  WHERE t.creation_date > c_fra
  AND t.creation_date  <= c_til
  AND t.account_id     = c_account
  ORDER BY t.creation_date;
 
BEGIN
  -- nullstilla sum
  sum_total :=0;
  -- renn ígjøgnum allar konti
  FOR account_rec IN account_cur LOOP
    -- nullstilla sum og frá dato, so hetta byrjar umaftur fyri hvørja konto
    sum_account := 0;
    temp_date   := fra_dato_p;
	select rentu into rentufaktor
	from accounttype
	where account_type = account_rec.account_type;
    -- finn byrjunarsaldo fyri tíðarskeið/konto
    SELECT COALESCE(SUM(t.amount),0) INTO temp_saldo
    FROM transaction t
    WHERE t.account_id  = account_rec.account_id and
          t.creation_date <= fra_dato_p;
    -- renn ígjøgnum bókingar
    FOR trans_rec IN trans_cur(fra_dato_p, til_dato_p, account_rec.account_id) LOOP
      -- rokna rentu
      sum_account := sum_account + (trans_rec.creation_date - temp_date) * temp_saldo * rentufaktor/360;
      -- dagfør saldo og dagfesting til næsta umfar
      temp_saldo  := temp_saldo + trans_rec.amount;
      temp_date   := trans_rec.creation_date;
    END LOOP;
    -- rokna rentu um har eru dagar eftir í mánaðinum
    IF temp_date   < til_dato_p THEN
      sum_account := sum_account + (til_dato_p - temp_date) * temp_saldo * rentufaktor/360;
    END IF;
    -- bóka rentu á konto
    IF sum_account != 0 THEN
      INSERT INTO transaction
        ( creation_date,  account_id, amount)
        VALUES
        (til_dato_p, account_rec.account_id, sum_account);
    END IF;
    --dagfør total
    sum_total := sum_total + abs(sum_account);
  END LOOP;
  -- returnera total til kallara
  RETURN sum_total;
END;
$$;
 
 -------------
INSERT INTO bank
VALUES (646000, 'Bank AAAE', 'Bankagøta', 4, 'aaae@bank.fo', 444444, 100, 64603000038, 64602000018);
 
INSERT INTO employee (job_title, ptal)
VALUES ('Kundaráðgevi', '240395037');
 
INSERT INTO employeelogin
VALUES (1, 1);
 
