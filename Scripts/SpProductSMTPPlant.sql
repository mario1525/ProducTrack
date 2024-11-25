-- ===========================================================
-- Author:        Mario Beltran
-- Create Date:   2024/11/24
-- Description:   Creación de procedimientos almacenados para
--                la tabla ProductSMTPPlant.
-- ===========================================================

PRINT 'Creacion procedimientos tabla ProductSMTPPlant  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProductSMTPPlant%')
BEGIN
    DROP PROCEDURE dbo.dbSpProductSMTPPlantGet
	DROP PROCEDURE dbo.dbSpProductSMTPPlantSet
	DROP PROCEDURE dbo.dbSpProductSMTPPlantDel
	DROP PROCEDURE dbo.dbSpProductSMTPPlantActive    
END
-- Procedimiento para obtener registros (GET)
PRINT 'Creación del procedimiento dbSpProductSMTPPlantGet'
GO
CREATE PROCEDURE dbo.dbSpProductSMTPPlantGet
    @Id             VARCHAR(36) = NULL,
    @IdSMTPPlant    VARCHAR(36) = NULL,
    @IdProduct        VARCHAR(36) = NULL,
    @Estado         BIT = NULL
AS
BEGIN
    SELECT Id, IdSMTPPlant, IdProduct, Estado, Eliminado, Fecha_log
    FROM dbo.ProductSMTPPlant
    WHERE (@Id IS NULL OR Id = @Id)
      AND (@IdSMTPPlant IS NULL OR IdSMTPPlant = @IdSMTPPlant)
      AND (@IdProduct IS NULL OR IdProduct = @IdProduct)
      AND (@Estado IS NULL OR Estado = @Estado)
      AND Eliminado = 0;
END
GO

-- Procedimiento para insertar o actualizar registros (SET)
PRINT 'Creación del procedimiento dbSpProductSMTPPlantSet'
GO
CREATE PROCEDURE dbo.dbSpProductSMTPPlantSet
    @Id             VARCHAR(36),
    @IdSMTPPlant    VARCHAR(36),
    @IdProduct        VARCHAR(36),
    @Estado         BIT,
    @Operacion      CHAR(1) -- 'I' para Insertar, 'A' para Actualizar
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProductSMTPPlant (Id, IdSMTPPlant, IdProduct, Estado, Fecha_log, Eliminado)
        VALUES (@Id, @IdSMTPPlant, @IdProduct, @Estado, DEFAULT, 0);
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProductSMTPPlant
        SET IdSMTPPlant = @IdSMTPPlant,
            IdProduct = @IdProduct,
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
PRINT 'Creación del procedimiento dbSpProductSMTPPlantDel'
GO
CREATE PROCEDURE dbo.dbSpProductSMTPPlantDel
    @Id VARCHAR(36)
AS
BEGIN
    UPDATE dbo.ProductSMTPPlant
    SET Eliminado = 1
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró el registro con el Id especificado.', 16, 1);
    END
END
GO

-- Procedimiento para activar/desactivar registros (ACTIVE)
PRINT 'Creación del procedimiento dbSpProductSMTPPlantActive'
GO
CREATE PROCEDURE dbo.dbSpProductSMTPPlantActive
    @Id     VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.ProductSMTPPlant
    SET Estado = @Estado
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró el registro con el Id especificado.', 16, 1);
    END
END
GO