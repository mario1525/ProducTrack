-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla labCamp de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla LabCamp
PRINT 'Creacion procedimientos tabla LabCamp'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpLabCamp%')
BEGIN
    DROP PROCEDURE dbo.dbSpLabCampGet
    DROP PROCEDURE dbo.dbSpLabCampSet
    DROP PROCEDURE dbo.dbSpLabCampDel
END

PRINT 'Creacion procedimiento LabCamp Get '
GO
CREATE PROCEDURE dbo.dbSpLabCampGet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoDato VARCHAR(60),
    @UnidadMedida VARCHAR(10),
    @IdLab VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, TipoDato, UnidadMedida, IdLab, Estado, Fecha_log     
    FROM dbo.LabCamp
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND TipoDato = CASE WHEN ISNULL(@TipoDato,'')='' THEN TipoDato ELSE @TipoDato END
    AND UnidadMedida = CASE WHEN ISNULL(@UnidadMedida,'')='' THEN UnidadMedida ELSE @UnidadMedida END
    AND IdLab = CASE WHEN ISNULL(@IdLab,'')='' THEN IdLab ELSE @IdLab END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento LabCamp Set '
GO
CREATE PROCEDURE dbo.dbSpLabCampSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @TipoDato VARCHAR(60),
    @UnidadMedida VARCHAR(10),
    @IdLab VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.LabCamp(Id, Nombre, TipoDato, UnidadMedida, IdLab, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @TipoDato, @UnidadMedida, @IdLab, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.LabCamp
        SET Nombre = @Nombre, TipoDato = @TipoDato, UnidadMedida = @UnidadMedida, IdLab = @IdLab, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento LabCamp Del '
GO
CREATE PROCEDURE dbo.dbSpLabCampDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.LabCamp
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END

