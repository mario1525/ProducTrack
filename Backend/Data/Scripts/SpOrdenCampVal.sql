-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla OrdenCampVal de la DB 
--              ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla OrdenCampVal
PRINT 'Creacion procedimientos tabla OrdenCampVal'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpOrdenCampVal%')
BEGIN
    DROP PROCEDURE dbo.dbSpOrdenCampValGet
    DROP PROCEDURE dbo.dbSpOrdenCampValSet
    DROP PROCEDURE dbo.dbSpOrdenCampValDel
END

PRINT 'Creacion procedimiento OrdenCampVal Get '
GO
CREATE PROCEDURE dbo.dbSpOrdenCampValGet
    @IdOrdenCampVal VARCHAR(36),
    @Valor VARCHAR(255),
    @IdOrdenCamp VARCHAR(36),
    @IdRegisOrden VARCHAR(36),
    @Eliminado BIT
AS 
BEGIN
    SELECT Id, Valor, IdOrdenCamp, IdRegisOrden, Fecha_log     
    FROM dbo.OrdenCampVal
    WHERE Id = CASE WHEN ISNULL(@IdOrdenCampVal,'')='' THEN Id ELSE @IdOrdenCampVal END
    AND Valor LIKE CASE WHEN ISNULL(@Valor,'')='' THEN Valor ELSE '%'+@Valor+'%' END
    AND IdOrdenCamp = CASE WHEN ISNULL(@IdOrdenCamp,'')='' THEN IdOrdenCamp ELSE @IdOrdenCamp END
    AND IdRegisOrden = CASE WHEN ISNULL(@IdRegisOrden,'')='' THEN IdRegisOrden ELSE @IdRegisOrden END
    AND Eliminado = CASE WHEN ISNULL(@Eliminado,0) = 1 THEN 1 ELSE 0 END
END

GO
PRINT 'Creacion procedimiento OrdenCampVal Set '
GO
CREATE PROCEDURE dbo.dbSpOrdenCampValSet
    @Id VARCHAR(36),
    @Valor VARCHAR(255),
    @IdOrdenCamp VARCHAR(36),
    @IdRegisOrden VARCHAR(36),
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.OrdenCampVal(Id, Valor, IdOrdenCamp, IdRegisOrden, Fecha_log, Eliminado)
        VALUES(@Id, @Valor, @IdOrdenCamp, @IdRegisOrden, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.OrdenCampVal
        SET Valor = @Valor, IdOrdenCamp = @IdOrdenCamp, IdRegisOrden = @IdRegisOrden
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento OrdenCampVal Del '
GO
CREATE PROCEDURE dbo.dbSpOrdenCampValDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.OrdenCampVal
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END

