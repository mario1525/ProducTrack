-- ==================================================
-- Author:		Mario Beltran
-- Create Date: 2024/05/15
-- Description: creacion de la DB ProductTrack
-- ==================================================

PRINT 'Creacion procedimientos tabla Usuarios'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'db_sp_Usuarios%')
BEGIN
    DROP PROCEDURE dbo.dbSpUsuarioGet
	DROP PROCEDURE dbo.dbSpUsuariosSet
	DROP PROCEDURE dbo.dbSpUsuariosDet
	DROP PROCEDURE dbo.dbSpUsuariosActive
END

PRINT 'Creacion procedimiento usuario Get '
GO
CREATE PROCEDURE dbo.dbSpUsuarioGet
	@Id								VARCHAR(36),
	@Usuario 						VARCHAR(40),
	@Usuario_validacion				VARCHAR(40),
	@Contraseña						VARCHAR(60),
	@Contraseña_validacion			VARCHAR(60),
	@Rol							VARCHAR(200),
	@Estado							INT 
AS 
BEGIN
	SELECT Id, Usuario, Contraseña, Rol, Estado, Eliminado, Fecha_log		
		FROM dbo.Usuarios
		WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
		AND Usuario LIKE CASE WHEN ISNULL(@Usuario,'')='' THEN Usuario ELSE '%'+@Usuario+'%' END
		AND Usuario = CASE WHEN ISNULL(@Usuario_validacion,'')='' THEN Usuario ELSE @Usuario_validacion END
		AND Contraseña LIKE CASE WHEN ISNULL(@Contraseña,'')='' THEN Contraseña ELSE '%'+@Contraseña+'%' END
		AND Contraseña = CASE WHEN ISNULL(@Contraseña_validacion,'')='' THEN Contraseña ELSE @Contraseña_validacion END
		AND Rol LIKE CASE WHEN ISNULL(@Rol,'')='' THEN Rol ELSE '%'+@Rol+'%' END
		AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE
			CASE WHEN ISNULL(@Estado,0) = 0 THEN 0 ELSE Estado END END
		AND Eliminado = 0
END

PRINT 'Creacion procedimiento usuario Set '
GO
CREATE PROCEDURE dbo.dbSpUsuarioSet
	@Id				VARCHAR(36),
	@Usuario 		VARCHAR(40),
	@Contraseña		VARCHAR(60), 
	@Rol			VARCHAR(200), 
	@Estado			BIT,
	@Operacion		VARCHAR(01)
AS
BEGIN
	IF @Operacion = 'I'
	BEGIN
			INSERT INTO dbo.Usuarios(Id, Usuario, Contraseña, Rol)
			VALUES(@Id, @Usuario, @Contraseña, @Rol)
	END
	ELSE
	BEGIN
		IF @Operacion = 'A'
		BEGIN
			UPDATE dbo.Usuarios
			SET Usuario = @Usuario, Contraseña = @Contraseña, @Rol = Rol, Estado = @Estado
			WHERE Id = @Id
		END
	END
END

PRINT 'Creacion procedimiento usuario Del '
GO
CREATE PROCEDURE dbo.dbSpUsuarioDel
	@Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Usuarios
    SET Eliminado = 1
    WHERE Id = @Id;
	
	-- Obtiene el estado "Eliminado" despues de la actualizacion 
    SELECT Eliminado
    FROM dbo.Usuarios
    WHERE Id = @Id;    
END 

PRINT 'Creacion procedimiento usuario Active '
GO
CREATE PROCEDURE dbo.dbSpUsuarioActive
	@Id VARCHAR(36),
	@Estado BIT
AS
BEGIN
	UPDATE dbo.Usuarios
	SET Estado = @Estado
	WHERE Id = @Id
END
GO
	