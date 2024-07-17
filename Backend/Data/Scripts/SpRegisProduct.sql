-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla RegisProduct de la DB 
--              ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla RegisProduct
PRINT 'Creacion procedimientos tabla RegisProduct'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpRegisProduct%')
BEGIN
    DROP PROCEDURE dbo.dbSpRegisProductGet
    DROP PROCEDURE dbo.dbSpRegisProductSet
    DROP PROCEDURE dbo.dbSpRegisProductDel
    DROP PROCEDURE dbo.dbSpRegisProductActive
END

PRINT 'Creacion procedimiento RegisProduct Get '
GO
CREATE PROCEDURE dbo.dbSpRegisProductGet
    @IdRegisProduct VARCHAR(36),
    @IdProducto VARCHAR(36),
    @IdRegisOrden VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, IdProduct, IdRegisOrden, IdUsuario, Estado, Fecha_log     
    FROM dbo.RegisProduct
    WHERE Id = CASE WHEN ISNULL(@IdRegisProduct,'')='' THEN Id ELSE @IdRegisProduct END
    AND IdProduct = CASE WHEN ISNULL(@IdProducto,'')='' THEN IdProduct ELSE @IdProducto END
    AND IdRegisOrden = CASE WHEN ISNULL(@IdRegisOrden,'')='' THEN IdRegisOrden ELSE @IdRegisOrden END
    AND IdUsuario = CASE WHEN ISNULL(@IdUsuario,'')='' THEN IdUsuario ELSE @IdUsuario END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento RegisProduct Set '
GO
CREATE PROCEDURE dbo.dbSpRegisProductSet
    @Id VARCHAR(36),
    @IdProducto VARCHAR(36),
    @IdRegisOrden VARCHAR(36),
    @IdUsuario VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.RegisProduct(Id, IdProduct, IdRegisOrden, IdUsuario, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @IdProducto, @IdRegisOrden, @IdUsuario, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.RegisProduct
        SET IdProduct = @IdProducto, IdRegisOrden = @IdRegisOrden, IdUsuario = @IdUsuario, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento RegisProduct Del '
GO
CREATE PROCEDURE dbo.dbSpRegisProductDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.RegisProduct
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.RegisProduct
    WHERE Id = @Id;    
END

GO
PRINT 'Creacion procedimiento RegisProduct Active '
GO
CREATE PROCEDURE dbo.dbSpRegisProductActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.RegisProduct
    SET Estado = @Estado
    WHERE Id = @Id
END
GO
