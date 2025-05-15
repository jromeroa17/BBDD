drop procedure avg_precio_categoria;
delimiter $$

create procedure avg_precio_categoria()
begin
	declare contador int default 0;
	declare total_filas int;
    select count(*) into total_filas from categoria;
    while contador<=total_filas do
		select Codigo into @codcategoria from categoria limit contador,1;
		select avg(Precio) into @media from productos where Codigo_Categoria=@codcategoria;
        update categoria set Precio_Medio=@media where Codigo=@codcategoria;
        set contador = contador +1;
    end while;
    
    
end
$$

delimiter ;
call avg_precio_categoria();