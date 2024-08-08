-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla RegisOrden de la DB 
--              ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla RegisOrden
PRINT 'Creacion procedimientos tabla RegisOrden'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpRegisOrden%')
BEGIN
    DROP PROCEDURE dbo.dbSpRegisOrdenGet
    DROP PROCEDURE dbo.dbSpRegisOrdenSet
    DROP PROCEDURE dbo.dbSpRegisOrdenDel
    DROP PROCEDURE dbo.dbSpRegisOrdenActive
END

PRINT 'Creacion procedimiento RegisOrden Get '
GO
CREATE PROCEDURE dbo.dbSpRegisOrdenGet
    @IdRegisOrden VARCHAR(36),
    @IdOrden VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, IdOrden, IdUsuario, Estado, Fecha_log     
    FROM dbo.RegisOrden
    WHERE Id = CASE WHEN ISNULL(@IdRegisOrden,'')='' THEN Id ELSE @IdRegisOrden END
    AND IdOrden = CASE WHEN ISNULL(@IdOrden,'')='' THEN IdOrden ELSE @IdOrden END
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento RegisOrden Set '
GO
CREATE PROCEDURE dbo.dbSpRegisOrdenSet
    @Id VARCHAR(36),
    @IdOrden VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.RegisOrden(Id, IdOrden, IdUsuario, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdOrden, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.RegisOrden
        SET IdOrden = @IdOrden, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento RegisOrden Del '
GO
CREATE PROCEDURE dbo.dbSpRegisOrdenDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.RegisOrden
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.RegisOrden
    WHERE Id = @Id;    
END

GO
PRINT 'Creacion procedimiento RegisOrden Active '
GO
CREATE PROCEDURE dbo.dbSpRegisOrdenActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.RegisOrden
    SET Estado = @Estado
    WHERE Id = @Id
END
GO

