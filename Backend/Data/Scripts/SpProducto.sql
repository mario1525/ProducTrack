-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla Product de la DB 
--              ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla Producto
PRINT 'Creacion procedimientos tabla Producto'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProducto%')
BEGIN
    DROP PROCEDURE dbo.dbSpProductoGet
    DROP PROCEDURE dbo.dbSpProductoSet
    DROP PROCEDURE dbo.dbSpProductoDel
END

PRINT 'Creacion procedimiento Producto Get '
GO
CREATE PROCEDURE dbo.dbSpProductoGet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @IdProceso VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, IdCompania, IdProceso, Estado, Fecha_log     
    FROM dbo.Producto
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE @IdCompania END
    AND IdProceso = CASE WHEN ISNULL(@IdProceso,'')='' THEN IdProceso ELSE @IdProceso END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento Producto Set '
GO
CREATE PROCEDURE dbo.dbSpProductoSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @IdProceso VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.Producto(Id, Nombre, IdCompania, IdProceso, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdCompania, @IdProceso, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Producto
        SET Nombre = @Nombre, IdCompania = @IdCompania, IdProceso = @IdProceso, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento Producto Del '
GO
CREATE PROCEDURE dbo.dbSpProductoDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Producto
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END
