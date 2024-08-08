-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla RegisProductProcesEtap de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla RegisProductProcesEtap
PRINT 'Creacion procedimientos tabla RegisProductProcesEtap'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpRegisProductProcesEtap%')
BEGIN
    DROP PROCEDURE dbo.dbSpRegisProductProcesEtapGet
    DROP PROCEDURE dbo.dbSpRegisProductProcesEtapSet
    DROP PROCEDURE dbo.dbSpRegisProductProcesEtapDel
END

PRINT 'Creacion procedimiento RegisProductProcesEtap Get '
GO
CREATE PROCEDURE dbo.dbSpRegisProductProcesEtapGet
    @IdRegisProductProcesEtap VARCHAR(36),
    @IdRegisProduct VARCHAR(36),
    @IdProcesEtap VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, IdRegisProduct, IdProcesEtap, IdUsuario, Estado, Fecha_log     
    FROM dbo.RegisProductProcesEtap
    WHERE Id = CASE WHEN ISNULL(@IdRegisProductProcesEtap,'')='' THEN Id ELSE @IdRegisProductProcesEtap END
    AND IdRegisProduct = CASE WHEN ISNULL(@IdRegisProduct,'')='' THEN IdRegisProduct ELSE @IdRegisProduct END
    AND IdProcesEtap = CASE WHEN ISNULL(@IdProcesEtap,'')='' THEN IdProcesEtap ELSE @IdProcesEtap END
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento RegisProductProcesEtap Set '
GO
CREATE PROCEDURE dbo.dbSpRegisProductProcesEtapSet
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
        INSERT INTO dbo.RegisProductProcesEtap(Id, IdRegisProduct, IdProcesEtap, IdUsuario, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdRegisProduct, @IdProcesEtap, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.RegisProductProcesEtap
        SET IdRegisProduct = @IdRegisProduct, IdProcesEtap = @IdProcesEtap, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento RegisProductProcesEtap Del '
GO
CREATE PROCEDURE dbo.dbSpRegisProductProcesEtapDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.RegisProductProcesEtap
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END
