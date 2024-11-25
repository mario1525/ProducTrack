-- ===========================================================
-- Author:        Mario Beltran
-- Create Date:   2024/11/24
-- Description:   Creación de procedimientos almacenados para
--                la tabla OrdenSMTPPlant.
-- ===========================================================

PRINT 'Creacion procedimientos tabla OrdenSMTPPlant  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpOrdenSMTPPlant%')
BEGIN
    DROP PROCEDURE dbo.dbSpOrdenSMTPPlantGet
	DROP PROCEDURE dbo.dbSpOrdenSMTPPlantSet
	DROP PROCEDURE dbo.dbSpOrdenSMTPPlantDel
	DROP PROCEDURE dbo.dbSpOrdenSMTPPlantActive    
END
-- Procedimiento para obtener registros (GET)
PRINT 'Creación del procedimiento dbSpOrdenSMTPPlantGet'
GO
CREATE PROCEDURE dbo.dbSpOrdenSMTPPlantGet
    @Id             VARCHAR(36) = NULL,
    @IdSMTPPlant    VARCHAR(36) = NULL,
    @IdOrden        VARCHAR(36) = NULL,
    @Estado         BIT = NULL
AS
BEGIN
    SELECT Id, IdSMTPPlant, IdOrden, Estado, Eliminado, Fecha_log
    FROM dbo.OrdenSMTPPlant
    WHERE (@Id IS NULL OR Id = @Id)
      AND (@IdSMTPPlant IS NULL OR IdSMTPPlant = @IdSMTPPlant)
      AND (@IdOrden IS NULL OR IdOrden = @IdOrden)
      AND (@Estado IS NULL OR Estado = @Estado)
      AND Eliminado = 0;
END
GO

-- Procedimiento para insertar o actualizar registros (SET)
PRINT 'Creación del procedimiento dbSpOrdenSMTPPlantSet'
GO
CREATE PROCEDURE dbo.dbSpOrdenSMTPPlantSet
    @Id             VARCHAR(36),
    @IdSMTPPlant    VARCHAR(36),
    @IdOrden        VARCHAR(36),
    @Estado         BIT,
    @Operacion      CHAR(1) -- 'I' para Insertar, 'A' para Actualizar
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.OrdenSMTPPlant (Id, IdSMTPPlant, IdOrden, Estado, Fecha_log, Eliminado)
        VALUES (@Id, @IdSMTPPlant, @IdOrden, @Estado, DEFAULT, 0);
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.OrdenSMTPPlant
        SET IdSMTPPlant = @IdSMTPPlant,
            IdOrden = @IdOrden,
            Estado = @Estado
        WHERE Id = @Id;
    END
    ELSE
    BEGIN
        RAISERROR('Operación no válida. Use ''I'' para Insertar o ''A'' para Actualizar.', 16, 1);
    END
END
GO

-- Procedimiento para marcar registros como eliminados (DEL)
PRINT 'Creación del procedimiento dbSpOrdenSMTPPlantDel'
GO
CREATE PROCEDURE dbo.dbSpOrdenSMTPPlantDel
    @Id VARCHAR(36)
AS
BEGIN
    UPDATE dbo.OrdenSMTPPlant
    SET Eliminado = 1
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró el registro con el Id especificado.', 16, 1);
    END
END
GO

-- Procedimiento para activar/desactivar registros (ACTIVE)
PRINT 'Creación del procedimiento dbSpOrdenSMTPPlantActive'
GO
CREATE PROCEDURE dbo.dbSpOrdenSMTPPlantActive
    @Id     VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.OrdenSMTPPlant
    SET Estado = @Estado
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró el registro con el Id especificado.', 16, 1);
    END
END
GO