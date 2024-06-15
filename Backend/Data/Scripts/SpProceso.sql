-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/4
-- Description: creacion de los procedimientos almacenados
-- para la tabla Proceso de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla Proceso'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProceso%')
BEGIN
    DROP PROCEDURE dbo.dbSpProcesoGet
    DROP PROCEDURE dbo.dbSpProcesoSet
    DROP PROCEDURE dbo.dbSpProcesoDel
    DROP PROCEDURE dbo.dbSpProcesoActive
END

PRINT 'Creacion procedimiento Proceso Get '
GO
CREATE PROCEDURE dbo.dbSpProcesoGet
    @IdProceso VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, IdCompania, Estado, Fecha_log     
    FROM dbo.Proceso
    WHERE Id = CASE WHEN ISNULL(@IdProceso,'')='' THEN Id ELSE @IdProceso END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE @IdCompania END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento Proceso Set '
GO
CREATE PROCEDURE dbo.dbSpProcesoSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.Proceso(Id, Nombre, IdCompania, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdCompania, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Proceso
        SET Nombre = @Nombre, IdCompania = @IdCompania, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento Proceso Del '
GO
CREATE PROCEDURE dbo.dbSpProcesoDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Proceso
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.Proceso
    WHERE Id = @Id;    
END

GO
PRINT 'Creacion procedimiento Proceso Active '
GO
CREATE PROCEDURE dbo.dbSpProcesoActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.Proceso
    SET Estado = @Estado
    WHERE Id = @Id
END
GO
