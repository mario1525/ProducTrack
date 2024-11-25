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
    @Id VARCHAR(36),
    @IdProductAsig VARCHAR(36),   
    @IdUsuario VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, IdProductAsig, Observacion, IdUsuario, Estado, Fecha_log     
    FROM dbo.RegisProductProcesEtap
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END    
    AND IdProductAsig = CASE WHEN ISNULL(@IdProductAsig,'')='' THEN IdProductAsig ELSE @IdProductAsig END
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento RegisProductProcesEtap Set '
GO
CREATE PROCEDURE dbo.dbSpRegisProductProcesEtapSet
    @Id                 VARCHAR(36),
    @IdProductAsig      VARCHAR(36),   
    @IdUsuario          VARCHAR(36),
    @Observacion        VARCHAR(255),
    @Estado             INT,
    @Operacion          VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.RegisProductProcesEtap(Id, IdProductAsig, Observacion, IdUsuario, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdProductAsig, @Observacion, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.RegisProductProcesEtap
        SET  IdProductAsig = @IdProductAsig, Observacion = @Observacion, IdUsuario = @IdUsuario, Estado = @Estado
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
