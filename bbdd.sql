-- Script de creación de la Base de Datos
drop database if exists TechCorp;
create database if not exists TechCorp;
use TechCorp;
create table if not exists PROVEEDORES(
	Codigo int unsigned primary key,
    Nombre varchar(50),
    Direccion varchar(255),
    Telefono int unsigned,
    Correo varchar(255),
    Codigo_Postal smallint unsigned,
    Nombre_Contacto varchar(50)
);

create table if not exists CATEGORIA(
	Codigo int unsigned primary key,
    Nombre varchar(50),
    Precio_Medio float unsigned
);

create table if not exists PRODUCTOS(
	Codigo int unsigned primary key,
    Nombre varchar(255),
    Precio float unsigned,
    Stock int unsigned,
    Codigo_Proveedor int unsigned not null,
    Codigo_Categoria int unsigned not null,
    constraint fk_producto_proveedor foreign key (Codigo_Proveedor) references PROVEEDORES(Codigo) on delete restrict on update cascade,
    constraint fk_producto_categoria foreign key (Codigo_Categoria) references CATEGORIA(Codigo) on delete restrict on update cascade
);

create table if not exists CLIENTES(
	Codigo_Cliente varchar(10) primary key,
    Nombre varchar(50),
    Apellidos varchar(100),
    Direccion varchar(100),
    Ciudad varchar(30),
    Mail varchar(100),
    Telefono int unsigned,
    Fecha_Alta date
);

create table if not exists PEDIDOS(
	Codigo int unsigned primary key,
    Fecha_Pedido date,
    Fecha_Entrega date,
    Total float unsigned,
    Estado enum('Entregado','Pendiente','Cancelado'),
    Codigo_Cliente varchar(10) not null,
    constraint fk_pedidos_clientes foreign key (Codigo_Cliente) references CLIENTES(Codigo_Cliente) on delete restrict on update cascade
);

create table if not exists DETALLEPEDIDO(
	Codigo_Producto int unsigned not null,
    Codigo_Pedido int unsigned not null,
    Cantidad int unsigned,
    Precio float unsigned,
    constraint pk_detallepedido primary key (Codigo_Producto,Codigo_Pedido),
	constraint fk_detallepedido_producto foreign key (Codigo_Producto) references PRODUCTOS(Codigo) on delete restrict on update cascade,
	constraint fk_detallepedido_pedido foreign key (Codigo_Pedido) references PEDIDOS(Codigo) on delete restrict on update cascade
);
