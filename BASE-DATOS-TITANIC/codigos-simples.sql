insert into genero (id_genero,genero) values (1,'Femenino');
insert into genero (id_genero,genero) values (2,'Masculino');



UPDATE pasajeros SET id_genero = 2 WHERE id_pasajero = 1;

--- Insertamos los valores de la tabla embarque ---

insert into embarque (id_embarque,puerto_embarque) values (1,'C');
insert into embarque (id_embarque,puerto_embarque) values (2,'Q');
insert into embarque (id_embarque,puerto_embarque) values (3,'S');

--- Actualizamos el embarque del pasajero 1 ---

UPDATE pasajeros SET id_embarque = 3 WHERE id_pasajero = 1;

--- Visualizamos la tabla pasajeros ---
select * from pasajeros order by id_pasajero asc ; 

--- Agregramos el valor 0 como nuelo en este caso (N/A) ya que no existe registro encontrado---

insert into embarque (id_embarque,puerto_embarque) values (0,'N/A')


--- Visualizamos la tabla pasajero_cabina ---

select * from pasajero_cabina order by id_pasajero asc;


--- Agremos el id_embarque = 0 para el pasajero con id_pasajero = 62, porque no tiene embarque, 0 = N/A---
UPDATE pasajeros SET id_embarque = 0 WHERE id_pasajero = 62 ;

--- Agregamos el id_embarque = 0 para el pasajero con id_pasajero = 830, porque no tiene embarque, 0 = N/A--
update pasajeros set id_embarque = 0 where  id_pasajero = 830 ;

--- Eliminamos la columna id_cabina en la tabla pasajeros , porque ya lo tebemos en la relacion pasajero_cabina 
alter table pasajeros drop column id_cabina ; 

