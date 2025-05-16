-- Obtener Precio Total Pedido: Esta función toma como parámetro el ID de un pedido y
-- calcula el precio total del pedido
drop function fa_precio_total_pedido;
delimiter $$

create function fa_precio_total_pedido(pedidoID int unsigned) returns float
begin 
	declare total_precio float;
    select sum(cantidad * precio) into total_precio from detallepedido where codigo_pedido=pedidoID;
    return total_precio;
end
$$

delimiter ;
select distinct codigo_pedido, fa_precio_total_pedido(codigo_pedido) from detallepedido; 
