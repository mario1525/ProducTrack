-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
-- para la tabla SMTPPlant de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla SMTPPlant'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpSMTPPlant%')
BEGIN
    DROP PROCEDURE dbo.dbSpSMTPPlantGet
	DROP PROCEDURE dbo.dbSpSMTPPlantSet
	DROP PROCEDURE dbo.dbSpSMTPPlantDel
	DROP PROCEDURE dbo.dbSpSMTPPlantActive    
END

PRINT 'Creacion procedimiento SMTPPlant Get '
GO
CREATE PROCEDURE dbo.dbSpSMTPPlantGet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @IdCompania     VARCHAR(36),
    @Estado         INT
AS 
BEGIN
    SELECT Id, Nombre, IdCompania, Subjec, mesage, Estado, Fecha_log     
    FROM dbo.SMTPPlant
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END   
    AND IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE @IdCompania END    
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento SMTPPlant Set '
GO
CREATE PROCEDURE dbo.dbSpSMTPPlantSet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @IdCompania     VARCHAR(36),
    @Subjec         VARCHAR(255),
    @mesage         VARCHAR(MAX),
    @Estado         INT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.SMTPPlant(Id, Nombre, IdCompania, Subjec, mesage, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdCompania, @Subjec, @mesage, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.SMTPPlant
        SET Nombre = @Nombre,  Subjec = @Subjec,  IdCompania = @IdCompania, mesage = @mesage, Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento SMTPPlant Del '
GO
CREATE PROCEDURE dbo.dbSpSMTPPlantDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.SMTPPlant
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.SMTPPlant
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento SMTPPlant Active '
GO
CREATE PROCEDURE dbo.dbSpSMTPPlantActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.SMTPPlant
    SET Estado = @Estado
    WHERE Id = @Id
END
GO