-- Consultas

-- 1. Mostrar la cantidad total de productos vendidos por categoría.
select count(*) as total_productos from productos group by codigo_categoria;

-- 2. Listar el nombre y apellidos de los clientes que no han realizado ningún pedido.
select nombre, apellidos from clientes where codigo_cliente not in (select codigo_cliente from pedidos);

-- 3. Listar el nombre del producto, la cantidad vendida y el precio total de todas las ventas.
select productos.nombre, sum(DETALLEPEDIDO.cantidad) as cantidad_vendida, sum(DETALLEPEDIDO.cantidad * detallepedido.precio) as precio_total
from productos inner join detallepedido
on productos.codigo=detallepedido.codigo_producto group by productos.codigo;

-- 4. Mostrar los proveedores junto con los productos que proveen, incluso si algunos proveedores no tienen un producto asociado
select proveedores.nombre,productos.nombre 
from proveedores left join productos
on proveedores.codigo=productos.codigo_proveedor;

-- 5. Obtener los nombres de los clientes que han pedido más de tres productos diferentes.
-- Muestra también la cantidad de productos diferentes pedidos.
select clientes.nombre,clientes.apellidos,count(distinct codigo_producto) as total_prod_diferentes
from productos inner join detallepedido
on productos.codigo=detallepedido.codigo_producto
inner join pedidos
on detallepedido.codigo_pedido=pedidos.codigo 
inner join clientes
on clientes.codigo_cliente=pedidos.codigo_cliente
group by pedidos.codigo_cliente
having total_prod_diferentes > 3;


-- 6. Muestra el producto más vendido y el menos vendido junto con la cantidad vendida.
select nombre, total
from (select productos.nombre as nombre, sum(detallepedido.cantidad) as total
from DETALLEPEDIDO
inner join PRODUCTOS on detallepedido.codigo_producto = productos.Codigo
group by productos.Codigo, productos.nombre) as total_productos
where total = (select max(total_cant) from (select sum(cantidad) as total_cant
from DETALLEPEDIDO
group by codigo_producto) as submax)
union
select nombre, total
from (select productos.nombre as nombre, sum(detallepedido.cantidad) as total
from DETALLEPEDIDO
inner join PRODUCTOS on detallepedido.codigo_producto = productos.Codigo
group by productos.Codigo, productos.nombre) as total_productos
where total = (select min(total_cant) from (
select sum(cantidad) as total_cant
from DETALLEPEDIDO group by codigo_producto) as submin);


-- 7. Calcular el total de ventas realizadas hasta la fecha.
-- Pedidos entregados? Productos vendidos en total?
select sum(Total) as Total_Ventas from PEDIDOS where Estado = 'Entregado';

