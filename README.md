# Proyecto-Programacion-logica-y-funcional
Proyecto 9 
%------------------------------------------------------------------------------
% Módulo:       hola_mundo
% Propósito:    construir una base de datos distribuida utilizando Mnesia. En el cual Se implemente un CRUD  proporcionando una comprensión práctica de cómo funciona Mnesia 
                y cómo puede ser utilizado en aplicaciones distribuidas.Se aprendera como configurar la replicación de datos entre nodos, manejar la
                persistencia en memoria y disco, y explorarán cómo 
                Mnesia puede ser integrada con otros componentes de un sistema basado en Erlang
%
% Autor:        Escalante Hernandez Kevin Ulises 21211937
                Castro Alvarado Jorge Luis 22211533
                Hernandez Hernandez Manuela 22210768
                Diaz Morales Katherine Giselle
                
% Fecha:        24 de Septiembre de 2024
%
% Descripción:
% Este Proyecto Permite Crear Un CRUD en lo que se conoce como Mnesia.
% Es un ejemplo introductorio para mostrar la estructura básica de un programa

% Dependencias:
% Ninguna.
%
% Codigo:
-module(base_de_datos).
-compile(export_all).

% Iniciar Mnesia
iniciar() ->
    mnesia:create_schema([node()]), % Crear el esquema de Mnesia
    mnesia:start(). % Iniciar el sistema Mnesia

% Crear una tabla con nombre y atributos dinamicos
crear_tabla(NombreTabla, Atributos) ->
    mnesia:create_table(NombreTabla, 
    [{attributes, Atributos}, % Definir atributos dinamicos
     {disc_copies, [node()]}]). % Almacenamiento en disco

% Crear un registro usando una tupla
crear_registro(NombreTabla, Registro) ->
    F = fun() ->
        mnesia:write(Registro)  % Insertar el registro como una tupla
    end,
    mnesia:transaction(F).

% Leer un registro por clave
leer_registro(NombreTabla, Clave) ->
    F = fun() ->
        mnesia:read({NombreTabla, Clave})
    end,
    {atomic, Resultado} = mnesia:transaction(F),
    Resultado.

% Actualizar un registro
actualizar_registro(NombreTabla, RegistroActualizado) ->
    F = fun() ->
        mnesia:write(RegistroActualizado)
    end,
    mnesia:transaction(F).

% Eliminar un registro
eliminar_registro(NombreTabla, Clave) ->
    F = fun() ->
        mnesia:delete({NombreTabla, Clave})
    end,
    mnesia:transaction(F).

% Listar todas las tablas
listar_tablas() ->
    mnesia:system_info(tables).

% Borrar una tabla
borrar_tabla(NombreTabla) ->
    mnesia:delete_table(NombreTabla).

% Parar Mnesia
detener() ->
    mnesia:stop().

%Codigo documentando:
%1. Módulo y compilación

-module(base_de_datos).
-compile(export_all).

-module(base_de_datos). define el nombre del módulo.
-compile(export_all). permite que todas las funciones del módulo sean accesibles desde fuera.

%2. Iniciar Mnesia
iniciar() ->
    mnesia:create_schema([node()]), % Crear el esquema de Mnesia
    mnesia:start(). % Iniciar el sistema Mnesia
iniciar/0 crea el esquema de Mnesia para el nodo actual y lo inicia.

%3. Crear una tabla
crear_tabla(NombreTabla, Atributos) ->
    mnesia:create_table(NombreTabla, 
    [{attributes, Atributos}, % Definir atributos dinamicos
     {disc_copies, [node()]}]). % Almacenamiento en disco
crear_tabla/2 crea una tabla con el nombre y atributos dinámicos dados. Los atributos son definidos como una lista y la tabla se almacena en disco.

%4. Crear un registro

crear_registro(NombreTabla, Registro) ->
    F = fun() -> mnesia:write(Registro)  % Insertar el registro como una tupla
    end,
    mnesia:transaction(F).
crear_registro/2 inserta un registro en la tabla especificada. Utiliza una función anónima para realizar la escritura dentro de una transacción, garantizando que la operación sea atómica.

%5. Leer un registro

leer_registro(NombreTabla, Clave) ->
    F = fun() -> mnesia:read({NombreTabla, Clave}) end,
    {atomic, Resultado} = mnesia:transaction(F),
    Resultado.
leer_registro/2 lee un registro de la tabla especificada usando una clave. La operación se realiza dentro de una transacción, y el resultado se devuelve al final.

%6. Actualizar un registro

actualizar_registro(NombreTabla, RegistroActualizado) ->
    F = fun() -> mnesia:write(RegistroActualizado) end,
    mnesia:transaction(F).
actualizar_registro/2 actualiza un registro en la tabla, escribiendo el registro actualizado en una transacción.

%7. Eliminar un registro

eliminar_registro(NombreTabla, Clave) ->
    F = fun() -> mnesia:delete({NombreTabla, Clave}) end,
    mnesia:transaction(F).
eliminar_registro/2 elimina un registro de la tabla usando la clave, dentro de una transacción.

%8. Listar todas las tablas

listar_tablas() ->
    mnesia:system_info(tables).
   
listar_tablas/0 devuelve una lista de todas las tablas en la base de datos Mnesia.



%10. Borrar una tabla

borrar_tabla(NombreTabla) ->
    mnesia:delete_table(NombreTabla).
borrar_tabla/1 elimina la tabla especificada de Mnesia.
%11. Parar Mnesia

detener() ->
    mnesia:stop().
detener/0 detiene el sistema Mnesia.



