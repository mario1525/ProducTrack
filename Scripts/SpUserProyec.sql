-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/05/15
-- Description: creacion de los procedimientos almacenados
-- para la tabla UserProyec de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla UserProyecs'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpUserProyec%')
BEGIN
    DROP PROCEDURE dbo.dbSpUserProyecGet
	DROP PROCEDURE dbo.dbSpUserProyecSet
	DROP PROCEDURE dbo.dbSpUserProyecDel
	DROP PROCEDURE dbo.dbSpUserProyecActive
END

PRINT 'Creacion procedimiento userproyec Get '
GO
CREATE PROCEDURE dbo.dbSpUserProyecGet
    @Id                               VARCHAR(36),
    @IdUsuario                        VARCHAR(36),
	@IdProyecto                       VARCHAR(36),	
    @Estado                           INT 
AS 
BEGIN
    SELECT Id, IdUsuario, IdProyecto, Estado, Fecha_log     
    FROM dbo.UserProyec
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END    
    AND IdUsuario  LIKE CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario  ELSE '%'+@IdUsuario+'%' END 
    AND IdProyecto LIKE CASE WHEN ISNULL(@IdProyecto,'')='' THEN IdProyecto ELSE '%'+@IdProyecto+'%' END   
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT'Creacion procedimiento userproyec Set '
GO
CREATE PROCEDURE dbo.dbSpUserProyecSet
    @Id                 VARCHAR(36),    
    @IdUsuario          VARCHAR(36),
	@IdProyecto         VARCHAR(36),
    @Estado             BIT,
    @Operacion          VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.UserProyec(Id, IdUsuario, IdProyecto, Estado, Eliminado, Fecha_log)
        VALUES(@Id, @IdUsuario, @IdProyecto, @Estado, 0, GETDATE());
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.UserProyec
        SET IdUsuario      = @IdUsuario,
            IdProyecto     = @IdProyecto,
            Estado         = @Estado
        WHERE Id           = @Id;
    END
END;
GO


GO
PRINT 'Creacion procedimiento userproyec Del '
GO
CREATE PROCEDURE dbo.dbSpUserProyecDel
	@Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.UserProyec
    SET Eliminado = 1
    WHERE Id = @Id;
	
	-- Obtiene el estado "Eliminado" despues de la actualizacion 
    SELECT Eliminado
    FROM dbo.UserProyec
    WHERE Id = @Id;    
END 

GO
PRINT 'Creacion procedimiento userproyec Active '
GO
CREATE PROCEDURE dbo.dbSpUserProyecActive
	@Id VARCHAR(36),
	@Estado BIT
AS
BEGIN   
    UPDATE dbo.UserProyec
        SET Estado = @Estado           
        WHERE Id = @Id;
END;
