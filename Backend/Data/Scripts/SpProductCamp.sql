-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla ProductCamp de la DB 
--              ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla ProductCamp
PRINT 'Creacion procedimientos tabla ProductCamp'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProductCamp%')
BEGIN
    DROP PROCEDURE dbo.dbSpProductCampGet
    DROP PROCEDURE dbo.dbSpProductCampSet
    DROP PROCEDURE dbo.dbSpProductCampDel
END

PRINT 'Creacion procedimiento ProductCamp Get '
GO
CREATE PROCEDURE dbo.dbSpProductCampGet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoDato VARCHAR(60),    
    @IdProducto VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, TipoDato, Obligatorio, IdProduct, Estado, Fecha_log     
    FROM dbo.ProductCamp
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND TipoDato LIKE CASE WHEN ISNULL(@TipoDato,'')='' THEN TipoDato ELSE '%'+@TipoDato+'%' END    
    AND IdProduct = CASE WHEN ISNULL(@IdProducto,'')='' THEN IdProduct ELSE @IdProducto END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento ProductCamp Set '
GO
CREATE PROCEDURE dbo.dbSpProductCampSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoDato VARCHAR(60),
    @Obligatorio BIT,
    @IdProducto VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProductCamp(Id, Nombre, TipoDato, Obligatorio, IdProduct, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @TipoDato, @Obligatorio, @IdProducto, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProductCamp
        SET Nombre = @Nombre, TipoDato = @TipoDato, Obligatorio = @Obligatorio, IdProduct = @IdProducto, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento ProductCamp Del '
GO
CREATE PROCEDURE dbo.dbSpProductCampDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ProductCamp
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END
