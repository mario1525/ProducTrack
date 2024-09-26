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
    DROP PROCEDURE dbo.dbSpEtapasOrdenGet
END

PRINT 'Creacion procedimiento ProcesEtap Get '
GO
CREATE PROCEDURE dbo.dbSpProcesEtapGet
    @IdProcesEtap    VARCHAR(36),
    @NEtapa          INT,
    @Nombre          VARCHAR(255),
    @IdProceso       VARCHAR(36),
    @Estado          INT
AS 
BEGIN
    SELECT Id, Nombre, NEtapa, IdProceso, Estado, Fecha_log     
    FROM dbo.ProcesEtap
    WHERE Id = CASE WHEN ISNULL(@IdProcesEtap,'')='' THEN Id ELSE @IdProcesEtap END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END
    AND NEtapa LIKE CASE WHEN ISNULL(@NEtapa,0)=0 THEN NEtapa ELSE '%'+@NEtapa+'%' END
    AND IdProceso = CASE WHEN ISNULL(@IdProceso,'')='' THEN IdProceso ELSE @IdProceso END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento ProcesEtap Set '
GO
CREATE PROCEDURE dbo.dbSpProcesEtapSet
    @Id VARCHAR(36),
    @Nombre VARCHAR(255),
    @NEtapa INT,
    @IdProceso VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.ProcesEtap(Id, Nombre, NEtapa, IdProceso, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre, @NEtapa, @IdProceso, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.ProcesEtap
        SET 
            Nombre    = @Nombre,
            NEtapa    = @NEtapa,
            IdProceso = @IdProceso,
            Estado    = @Estado
        WHERE Id = @Id
    END
END

GO
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

GO
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

PRINT 'Creacion de sp dbSpEtapasOrdenGet'
GO
CREATE PROCEDURE dbo.dbSpEtapasOrdenGet
	@IdOrden VARCHAR(36)
AS
BEGIN	
	SELECT pe.Id, pe.Nombre, pe.NEtapa, pe.IdProceso, pe.Estado, pe.Fecha_log  
	FROM dbo.ProcesEtap pe	
	INNER JOIN dbo.Orden o ON pe.IdProceso = o.IdProceso
	INNER JOIN dbo.RegisOrden ro ON o.Id = ro.IdOrden
	WHERE ro.Id = @IdOrden;
END
GO
