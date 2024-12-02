-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Update Date: 
--        - Date: 2024/11/18
--        - Description: actualizacion de la DB para nuevo enfoque del 
--                       software
--                                                          
--                                                         
-- Description: creacion de los procedimientos almacenados
--              para la tabla Orden de la DB 
--              ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla Orden'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpOrden%')
BEGIN
    DROP PROCEDURE dbo.dbSpOrdenGet
    DROP PROCEDURE dbo.dbSpOrdenSet
    DROP PROCEDURE dbo.dbSpOrdenDel
    DROP PROCEDURE dbo.dbSpOrdenActive
END

CREATE TYPE CampoOrdenType AS TABLE
(
    id NVARCHAR(50),
    nombre NVARCHAR(50),
    tipodato NVARCHAR(20),
    Obligatorio BIT       
);

PRINT 'Creacion procedimiento Orden Get '
GO
CREATE PROCEDURE dbo.dbSpOrdenGet
    @Id           VARCHAR(36),
    @Nombre       VARCHAR(255),
    @IdProyecto   VARCHAR(36),
    @IdCompania   VARCHAR(36),
    @IdTipoOrden  VARCHAR(36),
    @IdProceso    VARCHAR(36),
    @Estado       INT
AS 
BEGIN
    SELECT 
        O.Id, 
        O.Nombre, 
        P.Nombre AS Proyecto,         
        O.IdTipoOrden,  
        O.IdProceso, 
        O.Estado, 
        O.Fecha_log     
    FROM Orden O
    LEFT JOIN Proyecto P ON O.IdProyecto = P.Id
    LEFT JOIN Compania C ON P.IdCompania = C.Id -- Relación adicional con Compania
    WHERE O.Id = CASE WHEN ISNULL(@Id, '') = '' THEN O.Id ELSE @Id END
    AND O.Nombre LIKE CASE WHEN ISNULL(@Nombre, '') = '' THEN O.Nombre ELSE '%' + @Nombre + '%' END
    AND O.IdProceso LIKE CASE WHEN ISNULL(@IdProceso, '') = '' THEN O.IdProceso ELSE '%' + @IdProceso + '%' END
    AND O.IdTipoOrden LIKE CASE WHEN ISNULL(@IdTipoOrden, '') = '' THEN O.IdTipoOrden ELSE '%' + @IdTipoOrden + '%' END
    AND O.IdProyecto = CASE WHEN ISNULL(@IdProyecto, '') = '' THEN O.IdProyecto ELSE @IdProyecto END
    AND C.Id = CASE WHEN ISNULL(@IdCompania, '') = '' THEN C.Id ELSE @IdCompania END -- Filtro por compañía
    AND O.Estado = CASE WHEN ISNULL(@Estado, 0) = 1 THEN 1 ELSE 0 END
    AND O.Eliminado = 0
END


GO
PRINT 'Creacion procedimiento Orden Set '
GO
CREATE PROCEDURE dbo.dbSpOrdenSet
    @Id                     VARCHAR(36),
    @Nombre                 VARCHAR(255),
    @IdProyecto             VARCHAR(36),
    @IdTipoOrden            VARCHAR(36),
    @IdProceso              VARCHAR(36),
    @Estado                 BIT,
    @Campos CampoOrdenType  READONLY,
    @Operacion              VARCHAR(1)
AS
BEGIN
    BEGIN TRY
        IF @Operacion = 'I'
        BEGIN
            BEGIN TRANSACTION;

            -- Operación 1: Insertar en la tabla Orden
            INSERT INTO dbo.Orden(Id, Nombre, IdProyecto, IdTipoOrden, IdProceso, Estado, Fecha_log, Eliminado)
            VALUES(@Id, @Nombre, @IdProyecto, @IdTipoOrden, @IdProceso, @Estado, DEFAULT, 0);

            -- Operación 2: Insertar en la tabla OrdenCamp
            INSERT INTO dbo.OrdenCamp(Id, Nombre, TipoDato, Obligatorio, IdOrden, Estado, Fecha_log, Eliminado)
            SELECT id, nombre, tipodato, obligatorio, @Id, @Estado, GETDATE(), 0
            FROM @Campos;

            COMMIT;
            PRINT 'Transacción completada exitosamente.';
        END
        ELSE IF @Operacion = 'A'
        BEGIN
            -- Actualización en la tabla Orden
            UPDATE dbo.Orden
            SET Nombre          = @Nombre, 
                IdProyecto      = @IdProyecto, 
                IdTipoOrden     = @IdTipoOrden,
                IdProceso       = @IdProceso, 
                Estado          = @Estado
            WHERE Id = @Id;

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
PRINT 'Creacion procedimiento Orden Del '
GO
CREATE PROCEDURE dbo.dbSpOrdenDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Orden
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.Orden
    WHERE Id = @Id;    
END

GO
PRINT 'Creacion procedimiento Orden Active '
GO
CREATE PROCEDURE dbo.dbSpOrdenActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.Orden
    SET Estado = @Estado
    WHERE Id = @Id
END
GO
