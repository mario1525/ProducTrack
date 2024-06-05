-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla OrdenCamp de la DB 
--              ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla OrdenCamp
PRINT 'Creacion procedimientos tabla OrdenCamp'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpOrdenCamp%')
BEGIN
    DROP PROCEDURE dbo.dbSpOrdenCampGet
    DROP PROCEDURE dbo.dbSpOrdenCampSet
    DROP PROCEDURE dbo.dbSpOrdenCampDel
    DROP PROCEDURE dbo.dbSpOrdenCampActive
END

PRINT 'Creacion procedimiento OrdenCamp Get '
GO
CREATE PROCEDURE dbo.dbSpOrdenCampGet
    @IdOrdenCamp VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoDato VARCHAR(60),
    @Obligatorio BIT,
    @IdOrden VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, TipoDato, Obligatorio, IdOrden, Estado, Fecha_log     
    FROM dbo.OrdenCamp
    WHERE Id = CASE WHEN ISNULL(@IdOrdenCamp,'')='' THEN Id ELSE @IdOrdenCamp END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND TipoDato = CASE WHEN ISNULL(@TipoDato,'')='' THEN TipoDato ELSE @TipoDato END
    AND Obligatorio = CASE WHEN ISNULL(@Obligatorio,0) = 1 THEN 1 ELSE 0 END
    AND IdOrden = CASE WHEN ISNULL(@IdOrden,'')='' THEN IdOrden ELSE @IdOrden END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

PRINT 'Creacion procedimiento OrdenCamp Set '
GO
CREATE PROCEDURE dbo.dbSpOrdenCampSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoDato VARCHAR(60),
    @Obligatorio BIT,
    @IdOrden VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.OrdenCamp(Id, Nombre, TipoDato, Obligatorio, IdOrden, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @TipoDato, @Obligatorio, @IdOrden, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.OrdenCamp
        SET Nombre = @Nombre, TipoDato = @TipoDato, Obligatorio = @Obligatorio, IdOrden = @IdOrden, Estado = @Estado
        WHERE Id = @Id
    END
END

PRINT 'Creacion procedimiento OrdenCamp Del '
GO
CREATE PROCEDURE dbo.dbSpOrdenCampDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.OrdenCamp
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.OrdenCamp
    WHERE Id = @Id;    
END

PRINT 'Creacion procedimiento OrdenCamp Active '
GO
CREATE PROCEDURE dbo.dbSpOrdenCampActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.OrdenCamp
    SET Estado = @Estado
    WHERE Id = @Id
END
GO
