-- ===========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
--           para la tabla VariablePlant de la DB ProductTrack
-- ===========================================================

PRINT 'Creacion procedimientos tabla VariablePlant  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpVariablePlant%')
BEGIN
    DROP PROCEDURE dbo.dbSpVariablePlantGet
	DROP PROCEDURE dbo.dbSpVariablePlantSet
	DROP PROCEDURE dbo.dbSpVariablePlantDel
	DROP PROCEDURE dbo.dbSpVariablePlantActive    
END

PRINT 'Creacion procedimiento VariablePlant Get '
GO
CREATE PROCEDURE dbo.dbSpVariablePlantGet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @IdReportePlant VARCHAR(36),
    @Estado         INT
AS 
BEGIN
    SELECT Id, Nombre, Descripcion, IdReportePlant, TipoDato, Estado, Fecha_log     
    FROM dbo.VariablePlant
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END   
    AND IdReportePlant = CASE WHEN ISNULL(@IdReportePlant,'')='' THEN IdReportePlant ELSE @IdReportePlant END    
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento VariablePlant Set '
GO
CREATE PROCEDURE dbo.dbSpVariablePlantSet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @Descripcion    VARCHAR(255),
    @IdReportePlant VARCHAR(36),
    @TipoDato       VARCHAR(30),
    @Estado         INT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.VariablePlant(Id, Nombre, Descripcion, IdReportePlant, TipoDato, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @Descripcion, @IdReportePlant, @TipoDato, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.VariablePlant
        SET Nombre = @Nombre,  Descripcion = @Descripcion,  IdReportePlant = @IdReportePlant, TipoDato = @TipoDato, Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento VariablePlant Del '
GO
CREATE PROCEDURE dbo.dbSpVariablePlantDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.VariablePlant
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.VariablePlant
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento VariablePlant Active '
GO
CREATE PROCEDURE dbo.dbSpVariablePlantActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.VariablePlant
    SET Estado = @Estado
    WHERE Id = @Id
END
GO