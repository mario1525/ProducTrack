-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
-- para la tabla ReportePlant de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla ReportePlant'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpReportePlant%')
BEGIN
    DROP PROCEDURE dbo.dbSpReportePlantGet
	DROP PROCEDURE dbo.dbSpReportePlantSet
	DROP PROCEDURE dbo.dbSpReportePlantDet
	DROP PROCEDURE dbo.dbSpReportePlantActive
    DROP PROCEDURE dbo.dbSpReportePlantGetVista
END

PRINT 'Creacion procedimiento ReportePlant Get '
GO
CREATE PROCEDURE dbo.dbSpReportePlantGet
    @Id          VARCHAR(36),
    @Nombre      VARCHAR(255),
    @IdCompania  VARCHAR(36),
    @IdUsuario   VARCHAR(36),
    @Estado      INT
AS 
BEGIN
    SELECT Id, Nombre, IdCompania, IdUsuario, Estado, Fecha_log     
    FROM dbo.ReportePlant
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END   
    AND IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE @IdCompania END 
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento ReportePlant Set '
GO
CREATE PROCEDURE dbo.dbSpReportePlantSet
    @Id          VARCHAR(36),
    @Nombre      VARCHAR(255),
    @IdCompania  VARCHAR(36),
    @IdUsuario   VARCHAR(36),
    @Estado      BIT,
    @Operacion   VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ReportePlant(Id, Nombre, IdCompania, IdUsuario,  Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdCompania, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ReportePlant
        SET Nombre = @Nombre, IdCompania = @IdCompania, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento ReportePlant Del '
GO
CREATE PROCEDURE dbo.dbSpReportePlantDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ReportePlant
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.ReportePlant
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento ReportePlant Active '
GO
CREATE PROCEDURE dbo.dbSpReportePlantActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.ReportePlant
    SET Estado = @Estado
    WHERE Id = @Id
END
GO