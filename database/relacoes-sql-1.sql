-- Active: 1687820486203@@127.0.0.1@3306
-- Práticas
CREATE TABLE if NOT EXISTS licenses(
    id TEXT PRIMARY KEY NOT NULL,
    resgister_number TEXT NOT NULL UNIQUE,
    category TEXT NOT NULL
);
CREATE TABLE if NOT EXISTS tableDrivers(
    id TEXT PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    license_id TEXT NOT NULL UNIQUE,
    FOREIGN KEY (license_id) REFERENCES licenses(id)
);
-- Populando a tabela licenses
INSERT INTO licenses (id, resgister_number, category)
VALUES ('l001', '123456', 'A'),
    ('l002', '789012', 'B'),
    ('l003', '345678', 'C');
-- Populando a tabela drivers
INSERT INTO tableDrivers (id, name, email, password, license_id)
VALUES (
        'd001',
        'John Doe',
        'john@example.com',
        'password123',
        'l001'
    ),
    (
        'd002',
        'Jane Smith',
        'jane@example.com',
        'password456',
        'l002'
    ),
    (
        'd003',
        'David Johnson',
        'david@example.com',
        'password789',
        'l003'
    );
SELECT *
FROM licenses;
SELECT *
FROM tableDrivers;
SELECT *
FROM tableDrivers
    INNER JOIN licenses ON tableDrivers.license_id = licenses.id;
--trazendo dados das duas tabelas
/* SELECT nome_colunas
 FROM nome_tabela 
 JOIN tabela_simples(sem foriegn key) on tabela_principal = tabela_simples
 */
SELECT licenses.id AS lincenseID,
    tableDrivers.name AS driversName,
    tableDrivers.license_id AS driversID
FROM tableDrivers
    JOIN licenses ON tableDrivers.license_id = licenses.id;
CREATE TABLE if NOT EXISTS users(
    id TEXT PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);
CREATE TABLE if NOT EXISTS phones(
    id TEXT PRIMARY KEY NOT NULL,
    phone_number TEXT NOT NULL,
    user_id TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
INSERT INTO users (id, name, email, password)
VALUES (
        '1',
        'Usuário 1',
        'usuario1@example.com',
        'senha1'
    ),
    (
        '2',
        'Usuário 2',
        'usuario2@example.com',
        'senha2'
    ),
    (
        '3',
        'Usuário 3',
        'usuario3@example.com',
        'senha3'
    );
INSERT INTO phones (id, phone_number, user_id)
VALUES ('phone1', '1111111111', '1'),
    ('phone2', '2222222222', '1'),
    ('phone3', '3333333333', '2'),
    ('phone4', '4444444444', '2'),
    ('phone5', '5555555555', '3'),
    ('phone6', '6666666666', '3');
SELECT *
FROM users
    INNER JOIN phones ON phones.user_id = users.id;
CREATE TABLE IF NOT EXISTS addresses (
    id TEXT PRIMARY KEY NOT NULL,
    user_id TEXT NOT NULL,
    street TEXT NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
CREATE TABLE IF NOT EXISTS orders (
    id TEXT PRIMARY KEY NOT NULL,
    user_id TEXT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
INSERT INTO addresses (id, user_id, street, city, state, postal_code)
VALUES (
        '1',
        '1',
        'Rua A',
        'Cidade 1',
        'Estado 1',
        '12345-678'
    ),
    (
        '2',
        '1',
        'Rua B',
        'Cidade 2',
        'Estado 2',
        '98765-432'
    ),
    (
        '3',
        '2',
        'Rua C',
        'Cidade 3',
        'Estado 3',
        '54321-876'
    ),
    (
        '4',
        '2',
        'Rua D',
        'Cidade 4',
        'Estado 4',
        '67890-123'
    ),
    (
        '5',
        '3',
        'Rua E',
        'Cidade 5',
        'Estado 5',
        '23456-789'
    ),
    (
        '6',
        '3',
        'Rua F',
        'Cidade 6',
        'Estado 6',
        '87654-321'
    );
INSERT INTO orders (id, user_id, order_date, total_amount, status)
VALUES ('1', '1', '2023-06-01', 50.00, 'Em andamento'),
    ('2', '1', '2023-06-05', 25.00, 'Entregue'),
    ('3', '2', '2023-06-10', 100.00, 'Em andamento'),
    ('4', '2', '2023-06-15', 75.00, 'Entregue'),
    ('5', '3', '2023-06-20', 200.00, 'Em andamento'),
    ('6', '3', '2023-06-25', 150.00, 'Cancelado');
SELECT *
FROM addresses
    INNER JOIN orders ON orders.user_id = addresses.id;