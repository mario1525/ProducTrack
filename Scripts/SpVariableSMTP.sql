-- ===========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
--           para la tabla VariableSMTP de la DB ProductTrack
-- ===========================================================

PRINT 'Creacion procedimientos tabla VariableSMTP  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpVariableSMTP%')
BEGIN
    DROP PROCEDURE dbo.dbSpVariableSMTPGet
	DROP PROCEDURE dbo.dbSpVariableSMTPSet
	DROP PROCEDURE dbo.dbSpVariableSMTPDel
	DROP PROCEDURE dbo.dbSpVariableSMTPActive    
END

PRINT 'Creacion procedimiento VariableSMTP Get '
GO
CREATE PROCEDURE dbo.dbSpVariableSMTPGet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @IdSMTPPlant  VARCHAR(36),
    @Estado         INT
AS 
BEGIN
    SELECT Id, Nombre, Descripcion, IdSMTPPlant , TipoDato, Estado, Fecha_log     
    FROM dbo.VariableSMTP
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END   
    AND IdSMTPPlant  = CASE WHEN ISNULL(@IdSMTPPlant ,'')='' THEN IdSMTPPlant  ELSE @IdSMTPPlant  END    
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento VariableSMTP Set '
GO
CREATE PROCEDURE dbo.dbSpVariableSMTPSet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(255),
    @Descripcion    VARCHAR(255),
    @IdSMTPPlant    VARCHAR(36),
    @TipoDato       VARCHAR(30),
    @Estado         INT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.VariableSMTP(Id, Nombre, Descripcion, IdSMTPPlant , TipoDato, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @Descripcion, @IdSMTPPlant , @TipoDato, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.VariableSMTP
        SET Nombre = @Nombre,  Descripcion = @Descripcion,  IdSMTPPlant  = @IdSMTPPlant, TipoDato = @TipoDato, Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento VariableSMTP Del '
GO
CREATE PROCEDURE dbo.dbSpVariableSMTPDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.VariableSMTP
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.VariableSMTP
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento VariableSMTP Active '
GO
CREATE PROCEDURE dbo.dbSpVariableSMTPActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.VariableSMTP
    SET Estado = @Estado
    WHERE Id = @Id
END
GO