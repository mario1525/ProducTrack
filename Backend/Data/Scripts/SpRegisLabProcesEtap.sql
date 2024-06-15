-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla RegisLabProcesEtap de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla RegisLabProcesEtap
PRINT 'Creacion procedimientos tabla RegisLabProcesEtap'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpRegisLabProcesEtap%')
BEGIN
    DROP PROCEDURE dbo.dbSpRegisLabProcesEtapGet
    DROP PROCEDURE dbo.dbSpRegisLabProcesEtapSet
    DROP PROCEDURE dbo.dbSpRegisLabProcesEtapDel
END

PRINT 'Creacion procedimiento RegisLabProcesEtap Get '
GO
CREATE PROCEDURE dbo.dbSpRegisLabProcesEtapGet
    @Id VARCHAR(36),
    @IdRegisProductProcesEtap VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @IdLab VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, IdRegisProductProcesEtap, IdUsuario, IdLab, Estado, Fecha_log     
    FROM dbo.RegisLabProcesEtap
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND IdRegisProductProcesEtap = CASE WHEN ISNULL(@IdRegisProductProcesEtap,'')='' THEN IdRegisProductProcesEtap ELSE @IdRegisProductProcesEtap END
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND IdLab = CASE WHEN ISNULL(@IdLab,'')='' THEN IdLab ELSE @IdLab END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento RegisLabProcesEtap Set '
GO
CREATE PROCEDURE dbo.dbSpRegisLabProcesEtapSet
    @Id VARCHAR(36),
    @IdRegisProductProcesEtap VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @IdLab VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.RegisLabProcesEtap(Id, IdRegisProductProcesEtap, IdUsuario, IdLab, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdRegisProductProcesEtap, @IdUsuario, @IdLab, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.RegisLabProcesEtap
        SET IdRegisProductProcesEtap = @IdRegisProductProcesEtap, IdUsuario = @IdUsuario, IdLab = @IdLab, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento RegisLabProcesEtap Del '
GO
CREATE PROCEDURE dbo.dbSpRegisLabProcesEtapDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.RegisLabProcesEtap
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END
