-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/17
-- Description: creacion de los procedimientos almacenados
-- para la tabla Proyecto de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla Proyecto'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProyecto%')
BEGIN
    DROP PROCEDURE dbo.dbSpProyectoGet
	DROP PROCEDURE dbo.dbSpProyectoSet
	DROP PROCEDURE dbo.dbSpProyectoDet
	DROP PROCEDURE dbo.dbSpProyectoActive
    DROP PROCEDURE dbo.dbSpProyectoGetVista
END

PRINT 'Creacion procedimiento Proyecto Get '
GO
CREATE PROCEDURE dbo.dbSpProyectoGet
    @Id          VARCHAR(36),
    @Nombre      VARCHAR(255),
    @IdCompania  VARCHAR(36),
    @IdUsuario   VARCHAR(36),
    @Estado      INT
AS 
BEGIN
    SELECT Id, Nombre, IdCompania, IdUsuario, Estado, Fecha_log     
    FROM dbo.Proyecto
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END   
    AND IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE @IdCompania END 
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO

PRINT 'Creacion procedimiento Proyecto Set '
GO
CREATE PROCEDURE dbo.dbSpProyectoSet
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
        INSERT INTO dbo.Proyecto(Id, Nombre, IdCompania, IdUsuario,  Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdCompania, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Proyecto
        SET Nombre = @Nombre, IdCompania = @IdCompania, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento Proyecto Del '
GO
CREATE PROCEDURE dbo.dbSpProyectoDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Proyecto
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.Proyecto
    WHERE Id = @Id;    
END

GO 
PRINT 'Creacion procedimiento Proyecto Active '
GO
CREATE PROCEDURE dbo.dbSpProyectoActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.Proyecto
    SET Estado = @Estado
    WHERE Id = @Id
END
GO