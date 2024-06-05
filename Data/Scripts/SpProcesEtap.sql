-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/4
-- Description: creacion de los procedimientos almacenados
-- para la tabla ProcesEtap de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla ProcesEtap'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpProcesEtap%')
BEGIN
    DROP PROCEDURE dbo.dbSpProcesEtapGet
    DROP PROCEDURE dbo.dbSpProcesEtapSet
    DROP PROCEDURE dbo.dbSpProcesEtapDel
    DROP PROCEDURE dbo.dbSpProcesEtapActive
END

PRINT 'Creacion procedimiento ProcesEtap Get '
GO
CREATE PROCEDURE dbo.dbSpProcesEtapGet
    @IdProcesEtap VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdProceso VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Nombre, IdProceso, Estado, Fecha_log     
    FROM dbo.ProcesEtap
    WHERE Id = CASE WHEN ISNULL(@IdProcesEtap,'')='' THEN Id ELSE @IdProcesEtap END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND IdProceso = CASE WHEN ISNULL(@IdProceso,'')='' THEN IdProceso ELSE @IdProceso END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

PRINT 'Creacion procedimiento ProcesEtap Set '
GO
CREATE PROCEDURE dbo.dbSpProcesEtapSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @IdProceso VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProcesEtap(Id, Nombre, IdProceso, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @IdProceso, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProcesEtap
        SET Nombre = @Nombre, IdProceso = @IdProceso, Estado = @Estado
        WHERE Id = @Id
    END
END

PRINT 'Creacion procedimiento ProcesEtap Del '
GO
CREATE PROCEDURE dbo.dbSpProcesEtapDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.ProcesEtap
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.ProcesEtap
    WHERE Id = @Id;    
END

PRINT 'Creacion procedimiento ProcesEtap Active '
GO
CREATE PROCEDURE dbo.dbSpProcesEtapActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.ProcesEtap
    SET Estado = @Estado
    WHERE Id = @Id
END
GO
