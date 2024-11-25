-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla ProductAsig de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla ProductAsig
PRINT 'Creacion procedimientos tabla ProductAsig'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProductAsig%')
BEGIN
    DROP PROCEDURE dbo.dbSpProductAsigGet
    DROP PROCEDURE dbo.dbSpProductAsigSet
    DROP PROCEDURE dbo.dbSpProductAsigDel
END

PRINT 'Creacion procedimiento ProductAsig Get '
GO
CREATE PROCEDURE dbo.dbSpProductAsigGet
    @Id VARCHAR(36),
    @IdRegisProduct VARCHAR(36),
    @IdProcesEtap VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, IdRegisProduct, IdProcesEtap, IdUsuario, Estado, Fecha_log     
    FROM dbo.ProductAsig
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND IdRegisProduct = CASE WHEN ISNULL(@IdRegisProduct,'')='' THEN IdRegisProduct ELSE @IdRegisProduct END
    AND IdProcesEtap = CASE WHEN ISNULL(@IdProcesEtap,'')='' THEN IdProcesEtap ELSE @IdProcesEtap END
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento ProductAsig Set '
GO
CREATE PROCEDURE dbo.dbSpProductAsigSet
    @Id VARCHAR(36),
    @IdRegisProduct VARCHAR(36),
    @IdProcesEtap VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProductAsig(Id, IdRegisProduct, IdProcesEtap, IdUsuario, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdRegisProduct, @IdProcesEtap, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProductAsig
        SET IdRegisProduct = @IdRegisProduct, IdProcesEtap = @IdProcesEtap, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento ProductAsig Del '
GO
CREATE PROCEDURE dbo.dbSpProductAsigDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ProductAsig
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END
