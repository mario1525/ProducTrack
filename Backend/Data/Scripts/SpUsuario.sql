-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/05/15
-- Description: creacion de los procedimientos almacenados
-- para la tabla usuarios de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla Usuarios'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpUsuario%')
BEGIN
    DROP PROCEDURE dbo.dbSpUsuarioGet
	DROP PROCEDURE dbo.dbSpUsuariosSet
	DROP PROCEDURE dbo.dbSpUsuariosDet
	DROP PROCEDURE dbo.dbSpUsuariosActive
END

PRINT 'Creacion procedimiento usuario Get '
GO
CREATE PROCEDURE dbo.dbSpUsuarioGet
    @Id                               VARCHAR(36),
    @Nombre                           VARCHAR(40),
    @Apellido						  VARCHAR(40),
    @Correo						      VARCHAR(60),    
	@IdCompania                       VARCHAR(60),
	@Cargo                            VARCHAR(60),
    @Rol                              VARCHAR(200),
    @Estado                           INT 
AS 
BEGIN
    SELECT Id, Nombre, Apellido, Correo, IdCompania, Cargo, Rol, Estado, Fecha_log     
    FROM dbo.Usuario
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END    
    AND Apellido LIKE CASE WHEN ISNULL(@Apellido,'')='' THEN Apellido ELSE '%'+@Apellido+'%' END
	AND Correo LIKE CASE WHEN ISNULL(@Correo,'')='' THEN Correo ELSE '%'+@Correo+'%' END
	AND IdCompania LIKE CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE '%'+@IdCompania+'%' END
    AND Cargo LIKE CASE WHEN ISNULL(@Cargo,'')='' THEN Cargo ELSE '%'+@Cargo+'%' END
	AND Rol LIKE CASE WHEN ISNULL(@Rol,'')='' THEN Rol ELSE '%'+@Rol+'%' END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento usuario Set '
GO
CREATE PROCEDURE dbo.dbSpUsuarioSet
    @Id             VARCHAR(36),
    @Nombre         VARCHAR(40),
    @Apellido       VARCHAR(40),
    @Correo         VARCHAR(60),
    @IdCompania     VARCHAR(36),
    @Cargo          VARCHAR(60),
    @Rol            VARCHAR(200),
    @Estado         BIT,
    @Operacion      VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.Usuario(Id, Nombre, Apellido, Correo, IdCompania, Cargo, Rol, Estado, Eliminado, Fecha_log)
        VALUES(@Id, @Nombre, @Apellido, @Correo, @IdCompania, @Cargo, @Rol, @Estado, 0, GETDATE());
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Usuario
        SET Nombre = @Nombre,
            Apellido = @Apellido,
            Correo = @Correo,
            IdCompania = @IdCompania,
            Cargo = @Cargo,
            Rol = @Rol,
            Estado = @Estado
        WHERE Id = @Id;
    END
END;
GO


GO
PRINT 'Creacion procedimiento usuario Del '
GO
CREATE PROCEDURE dbo.dbSpUsuarioDel
	@Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Usuario
    SET Eliminado = 1
    WHERE Id = @Id;
	
	-- Obtiene el estado "Eliminado" despues de la actualizacion 
    SELECT Eliminado
    FROM dbo.Usuario
    WHERE Id = @Id;    
END 

GO
PRINT 'Creacion procedimiento usuario Active '
GO
CREATE PROCEDURE dbo.dbSpUsuarioActive
	@Id VARCHAR(36),
	@Estado BIT
AS
BEGIN   
    UPDATE dbo.Usuario
        SET Estado = @Estado           
        WHERE Id = @Id;
END;

   

