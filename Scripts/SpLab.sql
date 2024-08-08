-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla lab de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla Lab
PRINT 'Creacion procedimientos tabla Lab'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpLab%')
BEGIN
    DROP PROCEDURE dbo.dbSpLabGet
    DROP PROCEDURE dbo.dbSpLabSet
    DROP PROCEDURE dbo.dbSpLabDel
END

PRINT 'Creacion procedimiento Lab Get '
GO
CREATE PROCEDURE dbo.dbSpLabGet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, IdCompania, Estado, Fecha_log     
    FROM dbo.Lab
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE @IdCompania END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento Lab Set '
GO
CREATE PROCEDURE dbo.dbSpLabSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdCompania VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.Lab(Id, Nombre, IdCompania, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdCompania, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Lab
        SET Nombre = @Nombre, IdCompania = @IdCompania, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento Lab Del '
GO
CREATE PROCEDURE dbo.dbSpLabDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Lab
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END

