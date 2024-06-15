-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla ArchivoVal de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla ArchivoVal
PRINT 'Creacion procedimientos tabla ArchivoVal'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpArchivoVal%')
BEGIN
    DROP PROCEDURE dbo.dbSpArchivoValGet
    DROP PROCEDURE dbo.dbSpArchivoValSet
    DROP PROCEDURE dbo.dbSpArchivoValDel
END

PRINT 'Creacion procedimiento ArchivoVal Get '
GO
CREATE PROCEDURE dbo.dbSpArchivoValGet
    @Id VARCHAR(36),
    @Nombre_Archivo VARCHAR(255),
    @Extension VARCHAR(10),
    @IdArchivo VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre_Archivo, Extension, IdArchivo, Estado, Fecha_log     
    FROM dbo.ArchivoVal
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre_Archivo LIKE CASE WHEN ISNULL(@Nombre_Archivo,'')='' THEN Nombre_Archivo ELSE '%'+@Nombre_Archivo+'%' END
    AND Extension = CASE WHEN ISNULL(@Extension,'')='' THEN Extension ELSE @Extension END
    AND IdArchivo = CASE WHEN ISNULL(@IdArchivo,'')='' THEN IdArchivo ELSE @IdArchivo END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento ArchivoVal Set '
GO
CREATE PROCEDURE dbo.dbSpArchivoValSet
    @Id VARCHAR(36),
    @Nombre_Archivo VARCHAR(255),
    @Extension VARCHAR(10),
    @Formato VARCHAR(255),
    @Archivos IMAGE,
    @Tamanio FLOAT,
    @IdArchivo VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ArchivoVal(Id, Nombre_Archivo, Extension, Formato, Archivos, Tamanio, IdArchivo, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre_Archivo, @Extension, @Formato, @Archivos, @Tamanio, @IdArchivo, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ArchivoVal
        SET Nombre_Archivo = @Nombre_Archivo, Extension = @Extension, Formato = @Formato, Archivos = @Archivos, 
            Tamanio = @Tamanio, IdArchivo = @IdArchivo, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento ArchivoVal Del '
GO
CREATE PROCEDURE dbo.dbSpArchivoValDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ArchivoVal
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END

