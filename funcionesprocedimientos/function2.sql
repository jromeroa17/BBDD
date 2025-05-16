-- Calcular Descuento Pedido: Esta función recibe como entrada el ID de un pedido y
-- calcula el importe de un cheque regalo para la próxima compra según el precio total del
-- pedido de la siguiente forma:
-- • Si el precio total del pedido es superior a 3000€ se le genera un cheque regalo
-- de 100€
-- • Si el precio total del pedido es superior a 1000€ se le genera un cheque regalo
-- de 50€

drop function calcular_descuento_pedido;
delimiter $$
create function fa_calcular_descuento_pedido(pedidoID int unsigned) returns float
begin
	declare total_pedido float;
    declare descuento float default 0;
    select fa_precio_total_pedido(pedidoID) into total_pedido;
    if total_pedido>3000 then set descuento=100;
    elseif total_pedido>1000 then set descuento=50;
    end if;
    return descuento;
end
$$

delimiter ;
select distinct Codigo_pedido, fa_precio_total_pedido(codigo_pedido), fa_calcular_descuento_pedido(codigo_pedido) from detallepedido;