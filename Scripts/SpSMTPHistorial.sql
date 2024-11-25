-- ===========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/20
-- Description: creacion de los procedimientos almacenados
--           para la tabla SMTPHistorial de la DB ProductTrack
-- ===========================================================

PRINT 'Creacion procedimientos tabla SMTPHistorial  '
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpSMTPHistorial%')
BEGIN
    DROP PROCEDURE dbo.dbSpSMTPHistorialGet
	DROP PROCEDURE dbo.dbSpSMTPHistorialSet
	DROP PROCEDURE dbo.dbSpSMTPHistorialDel
	DROP PROCEDURE dbo.dbSpSMTPHistorialActive    
END

-- Procedimiento para obtener registros (GET)
PRINT 'Creación del procedimiento dbSpSMTPHistorialGet'
GO
CREATE PROCEDURE dbo.dbSpSMTPHistorialGet
    @Id             VARCHAR(36),
    @IdSMTPPlant    VARCHAR(36),
    @Para           VARCHAR(255),
    @Subjec         VARCHAR(255),
    @Estado         BIT
AS
BEGIN
    SELECT Id, IdSMTPPlant, Para, CC, Subjec, DatosRellenados, Estado, Eliminado, Fecha_log
    FROM dbo.SMTPHistorial
    WHERE (@Id IS NULL OR Id = @Id)
      AND (@IdSMTPPlant IS NULL OR IdSMTPPlant = @IdSMTPPlant)
      AND (@Para IS NULL OR Para LIKE '%' + @Para + '%')
      AND (@Subjec IS NULL OR Subjec LIKE '%' + @Subjec + '%')
      AND (@Estado IS NULL OR Estado = @Estado)
      AND Eliminado = 0;
END
GO

-- Procedimiento para insertar o actualizar registros (SET)
PRINT 'Creación del procedimiento dbSpSMTPHistorialSet'
GO
CREATE PROCEDURE dbo.dbSpSMTPHistorialSet
    @Id             VARCHAR(36),
    @IdSMTPPlant    VARCHAR(36),
    @Para           VARCHAR(255),
    @CC             VARCHAR(255),
    @Subjec         VARCHAR(255),
    @DatosRellenados VARCHAR(MAX),
    @Estado         BIT,
    @Operacion      CHAR(1) -- 'I' para Insertar, 'A' para Actualizar
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.SMTPHistorial (Id, IdSMTPPlant, Para, CC, Subjec, DatosRellenados, Estado, Fecha_log, Eliminado)
        VALUES (@Id, @IdSMTPPlant, @Para, @CC, @Subjec, @DatosRellenados, @Estado, DEFAULT, 0);
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.SMTPHistorial
        SET IdSMTPPlant = @IdSMTPPlant,
            Para = @Para,
            CC = @CC,
            Subjec = @Subjec,
            DatosRellenados = @DatosRellenados,
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
PRINT 'Creación del procedimiento dbSpSMTPHistorialDel'
GO
CREATE PROCEDURE dbo.dbSpSMTPHistorialDel
    @Id VARCHAR(36)
AS
BEGIN
    UPDATE dbo.SMTPHistorial
    SET Eliminado = 1
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró el registro con el Id especificado.', 16, 1);
    END
END
GO

-- Procedimiento para activar/desactivar registros (ACTIVE)
PRINT 'Creación del procedimiento dbSpSMTPHistorialActive'
GO
CREATE PROCEDURE dbo.dbSpSMTPHistorialActive
    @Id     VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.SMTPHistorial
    SET Estado = @Estado
    WHERE Id = @Id;

    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('No se encontró el registro con el Id especificado.', 16, 1);
    END
END
GO