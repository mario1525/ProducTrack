-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla ProductCampVal de la DB 
--              ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla ProductCampVal
PRINT 'Creacion procedimientos tabla ProductCampVal'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProductCampVal%')
BEGIN
    DROP PROCEDURE dbo.dbSpProductCampValGet
    DROP PROCEDURE dbo.dbSpProductCampValSet
    DROP PROCEDURE dbo.dbSpProductCampValDel
END

PRINT 'Creacion procedimiento ProductCampVal Get '
GO
CREATE PROCEDURE dbo.dbSpProductCampValGet
    @IdProductCampVal VARCHAR(36),
    @Valor VARCHAR(255),
    @IdProductCamp VARCHAR(36),
    @IdRegisProduct VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Valor, IdProductCamp, IdRegisProduct, Estado, Fecha_log     
    FROM dbo.ProductCampVal
    WHERE Id = CASE WHEN ISNULL(@IdProductCampVal,'')='' THEN Id ELSE @IdProductCampVal END
    AND Valor LIKE CASE WHEN ISNULL(@Valor,'')='' THEN Valor ELSE '%'+@Valor+'%' END
    AND IdProductCamp = CASE WHEN ISNULL(@IdProductCamp,'')='' THEN IdProductCamp ELSE @IdProductCamp END
    AND IdRegisProduct = CASE WHEN ISNULL(@IdRegisProduct,'')='' THEN IdRegisProduct ELSE @IdRegisProduct END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento ProductCampVal Set '
GO
CREATE PROCEDURE dbo.dbSpProductCampValSet
    @Id VARCHAR(36),
    @Valor VARCHAR(255),
    @IdProductCamp VARCHAR(36),
    @IdRegisProduct VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProductCampVal(Id, Valor, IdProductCamp, IdRegisProduct, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Valor, @IdProductCamp, @IdRegisProduct, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProductCampVal
        SET Valor = @Valor, IdProductCamp = @IdProductCamp, IdRegisProduct = @IdRegisProduct, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento ProductCampVal Del '
GO
CREATE PROCEDURE dbo.dbSpProductCampValDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ProductCampVal
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END
