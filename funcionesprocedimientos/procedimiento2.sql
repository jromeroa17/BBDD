-- Actualizar Estado Pedidos: Este procedimiento actualiza el estado de los pedidos en
-- función de su fecha de entrega asegurándose que la información siempre sea coherente,
-- de forma que si existe fecha de entrega el estado del pedido debe ser “Entregado” y si
-- no existe dicha fecha el estado debe ser “Pendiente”. Hay que tener cuidado de no
-- alterar nunca aquellas filas que tengan estado “Cancelado”

drop procedure pa_actualizar_estado_pedidos;

delimiter $$

create procedure pa_actualizar_estado_pedidos()
begin
    update PEDIDOS set Estado = 'Entregado' where Fecha_Entrega is not null and Estado != 'Cancelado';
    update PEDIDOS set Estado = 'Pendiente' where Fecha_Entrega is null and Estado != 'Cancelado';
end
$$

delimiter ;
call pa_actualizar_estado_pedidos();
select * from pedidos;