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
