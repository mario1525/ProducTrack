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

CREATE TYPE CampoProductType AS TABLE
(
    id NVARCHAR(50),
    nombre NVARCHAR(50),
    tipodato NVARCHAR(20),
    Obligatorio BIT       
);

PRINT 'Creacion procedimiento Producto Get '
GO
CREATE PROCEDURE dbo.dbSpProductoGet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdProyecto VARCHAR(36),
    @IdProceso VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, IdProyecto, IdProceso, Estado, Fecha_log     
    FROM dbo.Producto
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND IdProyecto = CASE WHEN ISNULL(@IdProyecto,'')='' THEN IdProyecto ELSE @IdProyecto END
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
    @IdProyecto VARCHAR(36),
    @IdProceso VARCHAR(36),
    @Estado BIT,
    @Campos CampoProductType READONLY,
    @Operacion VARCHAR(1)
AS
BEGIN
    BEGIN TRY
        IF @Operacion = 'I'
        BEGIN
            BEGIN TRANSACTION;

            -- Operación 1: Insertar en la tabla producto
            INSERT INTO dbo.Producto(Id, Nombre, IdProyecto, IdProceso, Estado, Fecha_log, Eliminado)
        	VALUES(@Id, @Nombre, @IdProyecto, @IdProceso, @Estado, DEFAULT, 0)

            -- Operación 2: Insertar en la tabla productCamp
            INSERT INTO dbo.ProductCamp(Id, Nombre, TipoDato, Obligatorio, IdProduct, Estado, Fecha_log, Eliminado)
            SELECT id, nombre, tipodato, obligatorio, @Id, @Estado, GETDATE(), 0
            FROM @Campos;

            COMMIT;
            PRINT 'Transacción completada exitosamente.';
        END
        ELSE IF @Operacion = 'A'
        BEGIN
            -- Actualización en la tabla producto
            UPDATE dbo.Producto
        	SET Nombre = @Nombre, 	
	        	IdProyecto = @IdProyecto,
    	    	IdProceso = @IdProceso, 
        		Estado = @Estado
        	WHERE Id = @Id

            PRINT 'Actualización completada exitosamente.';
        END
    END TRY
    BEGIN CATCH
        -- En caso de error, se hace rollback
        IF @@TRANCOUNT > 0
            ROLLBACK;

        -- Mostrar el error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        PRINT 'Error en la transacción: ' + @ErrorMessage;
    END CATCH;
END;

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

