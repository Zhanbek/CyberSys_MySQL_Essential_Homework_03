 -- Створення бази даних
CREATE DATABASE IF NOT EXISTS MilitaryUnit;
USE MilitaryUnit;
-- 
-- Взвод
CREATE TABLE platoon (
    id INT PRIMARY KEY,
    number INT NOT NULL UNIQUE
);
--
-- Командири взводів
CREATE TABLE commander (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    rank_name VARCHAR(50) NOT NULL
);
--
-- Зброя
CREATE TABLE weapon (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);
--
-- Солдат
CREATE TABLE soldier (
    soldier_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    platoon_id INT NOT NULL,
    weapon_id INT NOT NULL,
    commander_id INT NOT NULL,

    FOREIGN KEY (platoon_id) REFERENCES platoon(id),
    FOREIGN KEY (weapon_id) REFERENCES weapon(id),
    FOREIGN KEY (commander_id) REFERENCES commander(id)
);
--
-- Взводи
INSERT INTO platoon (id, number) VALUES
(1, 200),
(2, 201),
(3, 205),
(4, 212),
(5, 232);
--
--  Командири
INSERT INTO commander (id, full_name, rank_name) VALUES
(1, 'Буров О.С.', 'майор'),
(2, 'Рибаков Н.Г.', 'майор'),
(3, 'Деребанов В.Я.', 'підполковник');
--
--  Зброя
INSERT INTO weapon (id, name) VALUES
(1, 'АК-47'),
(2, 'Глок20'),
(3, 'АК-74');
--
-- Солдати
INSERT INTO soldier
(full_name, platoon_id, weapon_id, commander_id)
VALUES
('Петров В.А.',    3, 1, 1),
('Петров В.А.',    3, 2, 2),
('Лодарев П.С.',   5, 3, 3),
('Лодарев П.С.',   5, 2, 2),
('Іващенко А.А.',  4, 1, 1),
('Іващенко А.А.',  4, 2, 2),
('Духов Р.М.',     1, 1, 1);