-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla Orden de la DB 
--              ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla Orden'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpOrden%')
BEGIN
    DROP PROCEDURE dbo.dbSpOrdenGet
    DROP PROCEDURE dbo.dbSpOrdenSet
    DROP PROCEDURE dbo.dbSpOrdenDel
    DROP PROCEDURE dbo.dbSpOrdenActive
END

PRINT 'Creacion procedimiento Orden Get '
GO
CREATE PROCEDURE dbo.dbSpOrdenGet
    @IdOrden VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @IdProceso VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT O.Id, O.Nombre, C.Nombre AS Compania, O.Estado, O.IdProceso, O.Fecha_log     
    FROM Orden O
	LEFT JOIN Compania C ON O.IdCompania = C.Id
    WHERE O.Id = CASE WHEN ISNULL(@IdOrden,'')='' THEN O.Id ELSE @IdOrden END
    AND O.Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN O.Nombre ELSE '%'+@Nombre+'%' END
    AND O.IdProceso LIKE CASE WHEN ISNULL(@IdProceso,'')='' THEN O.IdProceso ELSE '%'+@IdProceso+'%' END
    AND O.IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN O.IdCompania ELSE @IdCompania END
    AND O.Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND O.Eliminado = 0
END

GO
PRINT 'Creacion procedimiento Orden Set '
GO
CREATE PROCEDURE dbo.dbSpOrdenSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @IdProceso VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.Orden(Id, Nombre, IdCompania, IdProceso, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdCompania, @IdProceso, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Orden
        SET Nombre = @Nombre, IdCompania = @IdCompania, IdProceso = @IdProceso, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento Orden Del '
GO
CREATE PROCEDURE dbo.dbSpOrdenDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Orden
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.Orden
    WHERE Id = @Id;    
END

GO
PRINT 'Creacion procedimiento Orden Active '
GO
CREATE PROCEDURE dbo.dbSpOrdenActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.Orden
    SET Estado = @Estado
    WHERE Id = @Id
END
GO
