-- ===========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
--           para la tabla ProductReport de la DB ProductTrack
-- ===========================================================

PRINT 'Creacion procedimientos tabla ProductReport  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProductReport%')
BEGIN
    DROP PROCEDURE dbo.dbSpProductReportGet
	DROP PROCEDURE dbo.dbSpProductReportSet
	DROP PROCEDURE dbo.dbSpProductReportDel
	DROP PROCEDURE dbo.dbSpProductReportActive    
END

PRINT 'Creacion procedimiento ProductReport Get '
GO
CREATE PROCEDURE dbo.dbSpProductReportGet
    @Id             VARCHAR(36),    
    @IdProduct        VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @Estado         INT
AS 
BEGIN
    SELECT Id, Nombre, IdProduct, IdReportePlant, Estado, Fecha_log     
    FROM dbo.ProductReport
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END    
    AND IdProduct = CASE WHEN ISNULL(@IdProduct,'')='' THEN IdProduct ELSE @IdProduct END 
    AND IdReportePlant = CASE WHEN ISNULL(@IdReportePlant,'')='' THEN IdReportePlant ELSE @IdReportePlant END    
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento ProductReport Set '
GO
CREATE PROCEDURE dbo.dbSpProductReportSet
    @Id             VARCHAR(36),    
    @IdProduct        VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @Estado         INT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProductReport(Id, IdProduct, IdReportePlant, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdProduct, @IdReportePlant, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProductReport
        SET
            IdProduct = @IdProduct,
            IdReportePlant = @IdReportePlant, 
            Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento ProductReport Del '
GO
CREATE PROCEDURE dbo.dbSpProductReportDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ProductReport
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.ProductReport
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento ProductReport Active '
GO
CREATE PROCEDURE dbo.dbSpProductReportActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.ProductReport
    SET Estado = @Estado
    WHERE Id = @Id
END
GO