-- ===========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
--           para la tabla OrdenReport de la DB ProductTrack
-- ===========================================================

PRINT 'Creacion procedimientos tabla OrdenReport  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpOrdenReport%')
BEGIN
    DROP PROCEDURE dbo.dbSpOrdenReportGet
	DROP PROCEDURE dbo.dbSpOrdenReportSet
	DROP PROCEDURE dbo.dbSpOrdenReportDel
	DROP PROCEDURE dbo.dbSpOrdenReportActive    
END

PRINT 'Creacion procedimiento OrdenReport Get '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportGet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @IdOrden        VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @Estado         INT
AS 
BEGIN
    SELECT Id, Nombre, IdOrden, IdReportePlant, Estado, Fecha_log     
    FROM dbo.OrdenReport
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END  
    AND IdOrden = CASE WHEN ISNULL(@IdOrden,'')='' THEN IdOrden ELSE @IdOrden END 
    AND IdReportePlant = CASE WHEN ISNULL(@IdReportePlant,'')='' THEN IdReportePlant ELSE @IdReportePlant END    
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento OrdenReport Set '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportSet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @IdOrden        VARCHAR(36),
    @IdReportePlant VARCHAR(36),
    @Estado         INT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.OrdenReport(Id, Nombre, IdOrden, IdReportePlant, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdOrden, @IdReportePlant, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.OrdenReport
        SET Nombre = @Nombre,
            IdOrden = @IdOrden,
            IdReportePlant = @IdReportePlant, 
            Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento OrdenReport Del '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.OrdenReport
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.OrdenReport
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento OrdenReport Active '
GO
CREATE PROCEDURE dbo.dbSpOrdenReportActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.OrdenReport
    SET Estado = @Estado
    WHERE Id = @Id
END
GO