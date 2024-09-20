-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla RegisOrdenProcesEtap de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla RegisProductProcesEtap
PRINT 'Creacion procedimientos tabla RegisOrdenProcesEtap'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpRegisOrdenProcesEtap%')
BEGIN
    DROP PROCEDURE dbo.dbSpRegisOrdenProcesEtapGet
    DROP PROCEDURE dbo.dbSpRegisOrdenProcesEtapSet
    DROP PROCEDURE dbo.dbSpRegisOrdenProcesEtapDel
END

PRINT 'Creacion procedimiento RegisOrdenProcesEtap Get '
GO
CREATE PROCEDURE dbo.dbSpRegisOrdenProcesEtapGet
    @Id VARCHAR(36),
    @IdRegisOrden VARCHAR(36),
    @IdProcesEtap VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, IdRegisOrden, IdProcesEtap, IdUsuario, Estado, Fecha_log     
    FROM dbo.RegisOrdenProcesEtap
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND IdRegisOrden = CASE WHEN ISNULL(@IdRegisOrden,'')='' THEN IdRegisOrden ELSE @IdRegisOrden END
    AND IdProcesEtap = CASE WHEN ISNULL(@IdProcesEtap,'')='' THEN IdProcesEtap ELSE @IdProcesEtap END
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento RegisOrdenProcesEtap Set '
GO
CREATE PROCEDURE dbo.dbSpRegisOrdenProcesEtapSet
    @Id VARCHAR(36),
    @IdRegisOrden VARCHAR(36),
    @IdProcesEtap VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.RegisOrdenProcesEtap(Id, IdRegisOrden, IdProcesEtap, IdUsuario, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdRegisOrden, @IdProcesEtap, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.RegisOrdenProcesEtap
        SET IdRegisOrden = @IdRegisOrden, IdProcesEtap = @IdProcesEtap, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento RegisOrdenProcesEtap Del '
GO
CREATE PROCEDURE dbo.dbSpRegisOrdenProcesEtapDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.RegisOrdenProcesEtap
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END
