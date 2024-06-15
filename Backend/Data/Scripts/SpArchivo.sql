-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla Archivo de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla Archivo
PRINT 'Creacion procedimientos tabla Archivo'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpArchivo%')
BEGIN
    DROP PROCEDURE dbo.dbSpArchivoGet
    DROP PROCEDURE dbo.dbSpArchivoSet
    DROP PROCEDURE dbo.dbSpArchivoDel
END

PRINT 'Creacion procedimiento Archivo Get '
GO
CREATE PROCEDURE dbo.dbSpArchivoGet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoArchv VARCHAR(10),
    @IdCompania VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, TipoArchv, IdCompania, Estado, Fecha_log     
    FROM dbo.Archivo
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND TipoArchv = CASE WHEN ISNULL(@TipoArchv,'')='' THEN TipoArchv ELSE @TipoArchv END
    AND IdCompania = CASE WHEN ISNULL(@IdCompania,'')='' THEN IdCompania ELSE @IdCompania END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO
PRINT 'Creacion procedimiento Archivo Set '
GO
CREATE PROCEDURE dbo.dbSpArchivoSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoArchv VARCHAR(10),
    @IdCompania VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.Archivo(Id, Nombre, TipoArchv, IdCompania, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @TipoArchv, @IdCompania, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Archivo
        SET Nombre = @Nombre, TipoArchv = @TipoArchv, IdCompania = @IdCompania, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento Archivo Del '
GO
CREATE PROCEDURE dbo.dbSpArchivoDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Archivo
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END

