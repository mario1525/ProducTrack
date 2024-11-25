-- ===========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
--              para la tabla ProductReportHist de la DB 
--              ProductTrack
-- ===========================================================

PRINT 'Creacion procedimientos tabla ProductReportHist  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProductReportHist%')
BEGIN
    DROP PROCEDURE dbo.dbSpProductReportHistGet
	DROP PROCEDURE dbo.dbSpProductReportHistSet
	DROP PROCEDURE dbo.dbSpProductReportHistDel
	DROP PROCEDURE dbo.dbSpProductReportHistActive    
END

PRINT 'Creacion procedimiento ProductReportHist Get '
GO
CREATE PROCEDURE dbo.dbSpProductReportHistGet
    @Id             VARCHAR(36),
    @IdRegisProduct VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @Estado         INT
AS 
BEGIN
    SELECT Id, IdRegisProduct, IdReportePlant, DatosRellenados, Estado, Fecha_log     
    FROM dbo.ProductReportHist
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END    
    AND IdRegisProduct = CASE WHEN ISNULL(@IdRegisProduct,'')='' THEN IdRegisProduct ELSE @IdRegisProduct END 
    AND IdReportePlant = CASE WHEN ISNULL(@IdReportePlant,'')='' THEN IdReportePlant ELSE @IdReportePlant END    
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento ProductReportHist Set '
GO
CREATE PROCEDURE dbo.dbSpProductReportHistHistSet
    @Id             VARCHAR(36),   
    @IdRegisProduct   VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @DatosRellenados VARCHAR(MAX),
    @Estado         INT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProductReportHist(Id, IdRegisProduct, IdReportePlant, DatosRellenados, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdRegisProduct, @IdReportePlant, @DatosRellenados, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProductReportHist
        SET 
            IdRegisProduct = @IdRegisProduct,
            IdReportePlant = @IdReportePlant, 
            DatosRellenados = @DatosRellenados,
            Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento ProductReportHist Del '
GO
CREATE PROCEDURE dbo.dbSpProductReportHistDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ProductReportHist
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.ProductReportHist
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento ProductReportHist Active '
GO
CREATE PROCEDURE dbo.dbSpProductReportHistActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.ProductReportHist
    SET Estado = @Estado
    WHERE Id = @Id
END
GO