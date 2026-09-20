-- SCRIPT DE BASE DE DATOS VENTAS_TECH --

-- 1) Eliminación previa de tablas --


CREATE DATABASE Ventas_Tech_DB;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;

-- 2) Creación de la tabla de categorías --

CREATE TABLE categorias (
id_categorias int primary key,
nombre_categoria varchar (50) not null,
descripcion varchar (200) not null
);

select * from categorias

-- 3) Creación de la tabla clientes--

create table clientes (
Id_cliente int primary key,
nombre VARCHAR (100) not null,
email VARCHAR (100) unique,
ciudad varchar (50) not null,
fecha_registro date not null
);

select * from clientes

-- 4) Creación de la tabla de productos--

create table productos (
id_producto int primary key,
nombre_producto varchar (100) not null,
id_categoria int FOREIGN KEY (id_categoria) REFERENCES categorias(id_categorias),
precio decimal (10,2) not null,
stock int default (0),
activo TINYINT default (1)
);

select * from productos

-- 5) Creación de la tabla de ventas --

create table ventas (
id_venta int primary key,
id_cliente int foreign key (id_cliente) references clientes(Id_cliente),
id_producto int foreign key (id_producto) references productos(id_producto),
cantidad int not null,
precio_unitario decimal (10,2) not null,
fecha_venta date not null
);

select * from ventas

-- 6) Carga de datos en las tablas creadas--

INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

select * from categorias

INSERT INTO clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');

select * from clientes

INSERT INTO productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);

select * from productos

INSERT INTO ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');

select * from ventas

