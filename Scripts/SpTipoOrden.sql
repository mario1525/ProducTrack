-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/11/18
-- Description: creacion de los procedimientos almacenados
-- para la tabla TipoOrden de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla TipoOrdens'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpTipoOrden%')
BEGIN
    DROP PROCEDURE dbo.dbSpTipoOrdenGet
	DROP PROCEDURE dbo.dbSpTipoOrdensSet
	DROP PROCEDURE dbo.dbSpTipoOrdensDet
	DROP PROCEDURE dbo.dbSpTipoOrdensActive
END

PRINT 'Creacion procedimiento tipoorden Get '
GO
CREATE PROCEDURE dbo.dbSpTipoOrdenGet
    @Id                               VARCHAR(36), 
    @Nombre                           VARCHAR(255),
	@IdProyecto                       VARCHAR(36),	
    @Estado                           INT 
AS 
BEGIN
    SELECT Id, Nombre, Descripcion, IdProyecto, Estado, Fecha_log     
    FROM dbo.TipoOrden
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END   
    AND IdProyecto LIKE CASE WHEN ISNULL(@IdProyecto,'')='' THEN IdProyecto ELSE '%'+@IdProyecto+'%' END   
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT'Creacion procedimiento tipoorden Set '
GO
CREATE PROCEDURE dbo.dbSpTipoOrdenSet
    @Id                 VARCHAR(36),
    @Nombre             VARCHAR(40),
    @Descripcion        VARCHAR(255),    
	@IdProyecto         VARCHAR(36),
    @Estado             BIT,
    @Operacion          VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.TipoOrden(Id, Nombre, Descripcion, IdProyecto, Estado, Eliminado, Fecha_log)
        VALUES(@Id, @Nombre, @Descripcion, @IdProyecto, @Estado, 0, GETDATE());
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.TipoOrden
        SET Nombre         = @Nombre, 
            Descripcion    = @Descripcion,           
            IdProyecto     = @IdProyecto,
            Estado         = @Estado
        WHERE Id           = @Id;
    END
END;
GO


GO
PRINT 'Creacion procedimiento tipoorden Del '
GO
CREATE PROCEDURE dbo.dbSpTipoOrdenDel
	@Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.TipoOrden
    SET Eliminado = 1
    WHERE Id = @Id;
	
	-- Obtiene el estado "Eliminado" despues de la actualizacion 
    SELECT Eliminado
    FROM dbo.TipoOrden
    WHERE Id = @Id;    
END 

GO
PRINT 'Creacion procedimiento tipoorden Active '
GO
CREATE PROCEDURE dbo.dbSpTipoOrdenActive
	@Id VARCHAR(36),
	@Estado BIT
AS
BEGIN   
    UPDATE dbo.TipoOrden
        SET Estado = @Estado           
        WHERE Id = @Id;
END;

