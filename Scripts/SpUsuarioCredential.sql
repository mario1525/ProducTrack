﻿-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/05/15
-- Description: creacion de los procedimientos almacenados
-- para la tabla UsuarioCredencial de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla UsuarioCredencial'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpUsuarioCredencial%')
BEGIN
    DROP PROCEDURE dbo.dbSpUsuarioCredencialGet
    DROP PROCEDURE dbo.dbSpUsuarioCredencialSet
    DROP PROCEDURE dbo.dbSpUsuarioCredencialDel
    DROP PROCEDURE dbo.dbSpUsuarioCredencialActive
END

PRINT 'Creacion procedimiento UsuarioCredencial Get '
GO
CREATE PROCEDURE dbo.dbSpUsuarioCredencialGet
    @IdUsuarioCredencial VARCHAR(36),
    @Usuario VARCHAR(255),
    @Estado INT
AS 
BEGIN
    SELECT Id, Usuario, Contrasenia, IdUsuario, Estado, Fecha_log     
    FROM dbo.UsuarioCredencial
    WHERE Id = CASE WHEN ISNULL(@IdUsuarioCredencial,'')='' THEN Id ELSE @IdUsuarioCredencial END
    AND Usuario LIKE CASE WHEN ISNULL(@Usuario,'')='' THEN Usuario ELSE '%'+@Usuario+'%' END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento UsuarioCredencial Set '
GO
CREATE PROCEDURE dbo.dbSpUsuarioCredencialSet
    @Id              VARCHAR(36),
    @Usuario         VARCHAR(255),
    @Contrasenia     VARCHAR(255),
    @IdUsuario       VARCHAR(36),
    @Estado          BIT,
    @Operacion       VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.UsuarioCredencial(Id, Usuario, Contrasenia, IdUsuario, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Usuario, @Contrasenia, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.UsuarioCredencial
        SET Usuario = @Usuario, Contrasenia = @Contrasenia, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END


GO
PRINT 'Creacion procedimiento UsuarioCredencial Del '
GO
CREATE PROCEDURE dbo.dbSpUsuarioCredencialDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.UsuarioCredencial
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.UsuarioCredencial
    WHERE Id = @Id;    
END

GO
PRINT 'Creacion procedimiento UsuarioCredencial Active '
GO
CREATE PROCEDURE dbo.dbSpUsuarioCredencialActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.UsuarioCredencial
    SET Estado = @Estado
    WHERE Id = @Id
END
GO

PRINT 'Creacion procedimiento Validate Credencial '
GO
CREATE PROCEDURE dbo.dbSpValidateUsuarioCredencial
    @IdUsuario VARCHAR(36)
AS 
BEGIN
    DECLARE @Resultado BIT;

    -- Verifica si existe el usuario que cumple con las condiciones
    SELECT @Resultado = CASE 
                            WHEN EXISTS (
                                SELECT 1    
                                FROM dbo.UsuarioCredencial
                                WHERE IdUsuario = CASE WHEN ISNULL(@IdUsuario, '') = '' THEN IdUsuario ELSE @IdUsuario END  
                                AND Estado = 1
                                AND Eliminado = 0
                            ) 
                            THEN 1 
                            ELSE 0 
                        END;

    -- Retorna el resultado
    SELECT @Resultado AS EsValido;
END