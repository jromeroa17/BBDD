-- Actualizar Stock Producto: Este procedimiento actualiza la cantidad en stock de un
-- producto después de que se ha realizado una venta. Toma como parámetros el ID del
-- producto vendido y la cantidad vendida, y reduce la cantidad en stock en consecuencia

drop procedure pa_actualizar_stock;

delimiter $$

create procedure pa_actualizar_stock(in productoID int unsigned, in cantidad_vendida int unsigned)
begin
	update productos set stock=stock-cantidad_vendida where codigo=productoID;
end
$$

delimiter ;

call pa_actualizar_stock(1,1);
select * from productos;