 -- Створення бази даних
CREATE DATABASE IF NOT EXISTS CompanyHR;
USE CompanyHR;
--
-- Довідник відділів
CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
--
-- Довідник посад
CREATE TABLE positions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    base_salary DECIMAL(10,2) NOT NULL
);
--
-- Працівники
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    birth_date DATE,
    hire_date DATE NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    salary DECIMAL(10,2) NOT NULL,
    department_id INT NOT NULL,
    position_id INT NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES departments(id),
    FOREIGN KEY (position_id)
        REFERENCES positions(id)
);
--
-- Керівники відділів
CREATE TABLE department_managers (
    department_id INT PRIMARY KEY,
    employee_id INT UNIQUE,
    FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE CASCADE,
    FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE
);
--
-- Види освіти
CREATE TABLE education_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
--
-- Рівень освіти
CREATE TABLE education_level (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
--
-- Установа освіти
CREATE TABLE education_institution (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    level_id INT NOT NULL,
    FOREIGN KEY (level_id)
        REFERENCES education_level(id)
                ON DELETE CASCADE
);
--
-- Освіта працівників
CREATE TABLE employee_max_education (
    education_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    education_level_id INT NOT NULL,
    education_institution_id  INT NOT NULL,
    specialty VARCHAR(150),
    graduation_year YEAR,
    FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE,
    FOREIGN KEY (education_level_id)
        REFERENCES education_level(id)
                ON DELETE CASCADE,
    FOREIGN KEY (education_institution_id)
        REFERENCES  education_institution(id)
                ON DELETE CASCADE
);
--
-- Типи відпусток
CREATE TABLE vacation_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);
--
-- Відпустки працівників
CREATE TABLE employee_vacations (
	vacation_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    vacation_type_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE,
    FOREIGN KEY (vacation_type_id)
        REFERENCES vacation_types(id)
);
-- 
-- Історія роботи
CREATE TABLE employment_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    department_id INT NOT NULL,
    position_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    FOREIGN KEY (employee_id)
        REFERENCES employees(id)
        ON DELETE CASCADE,
    FOREIGN KEY (department_id)
        REFERENCES departments(id),
    FOREIGN KEY (position_id)
        REFERENCES positions(id)
);
--
-- Заповнення таблиць даними
--
INSERT INTO departments (name) VALUES
('Бухгалтерія'),
('IT-відділ'),
('Відділ кадрів'),
('Юридичний відділ'),
('Відділ маркетингу');
--
INSERT INTO positions (name, base_salary) VALUES
('Директор', 250000.00),
('Керівник відділу', 220000.00),
('Програміст', 180000.00),
('Системний адміністратор', 170000.00),
('HR-менеджер', 160000.00),
('Бухгалтер', 150000.00),
('Юрист', 170000.00),
('Маркетолог', 155000.00);
--
INSERT INTO education_level (name) VALUES
('Середня'),
('Середня спеціальна'),
('Бакалавр'),
('Магістр'),
('Доктор філософії');
--
INSERT INTO education_types (name) VALUES
('Школа'),
('Коледж'),
('Технікум'),
('Університет');
--
INSERT INTO education_institution (name, level_id) VALUES
('КНУ ім. Тараса Шевченка', 4),
('НТУУ "КПІ ім. Ігоря Сікорського"', 4),
('Львівська політехніка', 4),
('Харківський національний університет', 4),
('Алматинський університет енергетики та зв''язку', 4),
('Політехнічний коледж №1', 2);
--
INSERT INTO vacation_types (name) VALUES
('Щорічна'),
('Без збереження зарплати'),
('Навчальна'),
('Декретна'),
('Додаткова');
--
INSERT INTO employees
(last_name, first_name, middle_name, birth_date, hire_date, phone, email, salary, department_id, position_id)
VALUES
('Іваненко', 'Іван', 'Іванович', '1990-03-15', '2021-05-10', '+380501111111', 'ivanenko@company.ua', 185000, 2, 3),
('Петренко', 'Олена', 'Сергіївна', '1988-07-22', '2019-03-18','+380502222222','petrenko@company.ua',225000, 1, 2),
('Сидоренко', 'Андрій', 'Петрович', '1995-11-03', '2022-01-12', '+380503333333', 'sydorenko@company.ua', 170000, 2, 4),
('Коваль', 'Марина', 'Ігорівна', '1992-02-10', '2020-09-01', '+380504444444', 'koval@company.ua', 160000, 3, 5),
('Шевченко', 'Олександр', 'Васильович', '1985-12-05', '2018-04-15', '+380505555555', 'shevchenko@company.ua', 250000, 4, 1);
--
INSERT INTO department_managers (department_id, employee_id) VALUES
(1, 2),
(3, 4),
(4, 5);
-- 
INSERT INTO employee_max_education
(employee_id, education_level_id, education_institution_id, specialty, graduation_year)
VALUES
(1, 4, 2, 'Комп''ютерні науки', 2013),
(2, 4, 1, 'Фінанси', 2011),
(3, 3, 3, 'Інженерія програмного забезпечення', 2018),
(4, 4, 1, 'Управління персоналом', 2015),
(5, 4, 4, 'Право', 2008);
--
INSERT INTO employee_vacations
(employee_id, vacation_type_id, start_date, end_date)
VALUES
(1, 1, '2025-07-01', '2025-07-14'),
(2, 3, '2025-08-05', '2025-08-20'),
(3, 1, '2025-09-10', '2025-09-24'),
(4, 2, '2025-10-01', '2025-10-05'),
(5, 5, '2025-11-15', '2025-11-20');
-- 
INSERT INTO employment_history
(employee_id, department_id, position_id, start_date, end_date)
VALUES
(1, 2, 3, '2021-05-10', NULL),
(2, 1, 2, '2019-03-18', NULL),
(3, 2, 4, '2022-01-12', NULL),
(4, 3, 5, '2020-09-01', NULL),
(5, 4, 1, '2018-04-15', NULL);
