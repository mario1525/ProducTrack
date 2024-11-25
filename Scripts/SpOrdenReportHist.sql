-- ===========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
--           para la tabla OrdenReportHist de la DB ProductTrack
-- ===========================================================

PRINT 'Creacion procedimientos tabla OrdenReportHist  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpOrdenReportHist%')
BEGIN
    DROP PROCEDURE dbo.dbSpOrdenReportHistGet
	DROP PROCEDURE dbo.dbSpOrdenReportHistSet
	DROP PROCEDURE dbo.dbSpOrdenReportHistDel
	DROP PROCEDURE dbo.dbSpOrdenReportHistActive    
END

PRINT 'Creacion procedimiento OrdenReportHist Get '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportHistGet
    @Id             VARCHAR(36),
    @IdRegisOrden   VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @Estado         INT
AS 
BEGIN
    SELECT Id, IdRegisOrden, IdReportePlant, DatosRellenados, Estado, Fecha_log     
    FROM dbo.OrdenReportHist
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END    
    AND IdRegisOrden = CASE WHEN ISNULL(@IdRegisOrden,'')='' THEN IdRegisOrden ELSE @IdRegisOrden END 
    AND IdReportePlant = CASE WHEN ISNULL(@IdReportePlant,'')='' THEN IdReportePlant ELSE @IdReportePlant END    
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento OrdenReportHist Set '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportHistHistSet
    @Id             VARCHAR(36),   
    @IdRegisOrden   VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @DatosRellenados VARCHAR(MAX),
    @Estado         INT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.OrdenReportHist(Id, IdRegisOrden, IdReportePlant, DatosRellenados, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdRegisOrden, @IdReportePlant, @DatosRellenados, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.OrdenReportHist
        SET 
            IdRegisOrden = @IdRegisOrden,
            IdReportePlant = @IdReportePlant, 
            DatosRellenados = @DatosRellenados,
            Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento OrdenReportHist Del '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportHistDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.OrdenReportHist
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.OrdenReportHist
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento OrdenReportHist Active '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportHistActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.OrdenReportHist
    SET Estado = @Estado
    WHERE Id = @Id
END
GO