-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5 
-- Description: creacion de los procedimientos almacenados
--              para la tabla LabCampVal de la
--              DB ProductTrack
-- ========================================================

-- Procedimientos almacenados para la tabla LabCampVal
PRINT 'Creacion procedimientos tabla LabCampVal'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpLabCampVal%')
BEGIN
    DROP PROCEDURE dbo.dbSpLabCampValGet
    DROP PROCEDURE dbo.dbSpLabCampValSet
    DROP PROCEDURE dbo.dbSpLabCampValDel
END


PRINT 'Creacion procedimiento LabCampVal Get '
GO
CREATE PROCEDURE dbo.dbSpLabCampValGet
    @Id VARCHAR(36),
    @Valor VARCHAR(255),
    @IdLabCamp VARCHAR(36),
    @IdRegisLabEtap VARCHAR(36),
    @Estado INT
AS 
BEGIN
    SELECT Id, Valor, IdLabCamp, IdRegisLabEtap, Estado, Fecha_log     
    FROM dbo.LabCampVal
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Valor LIKE CASE WHEN ISNULL(@Valor,'')='' THEN Valor ELSE '%'+@Valor+'%' END
    AND IdLabCamp = CASE WHEN ISNULL(@IdLabCamp,'')='' THEN IdLabCamp ELSE @IdLabCamp END
    AND IdRegisLabEtap = CASE WHEN ISNULL(@IdRegisLabEtap,'')='' THEN IdRegisLabEtap ELSE @IdRegisLabEtap END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END

GO
PRINT 'Creacion procedimiento LabCampVal Set '
GO
CREATE PROCEDURE dbo.dbSpLabCampValSet
    @Id VARCHAR(36),
    @Valor VARCHAR(255),
    @IdLabCamp VARCHAR(36),
    @IdRegisLabEtap VARCHAR(36),
    @Estado BIT,
    @Operacion VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.LabCampVal(Id, Valor, IdLabCamp, IdRegisLabEtap, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Valor, @IdLabCamp, @IdRegisLabEtap, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.LabCampVal
        SET Valor = @Valor, IdLabCamp = @IdLabCamp, IdRegisLabEtap = @IdRegisLabEtap, Estado = @Estado
        WHERE Id = @Id
    END
END

GO
PRINT 'Creacion procedimiento LabCampVal Del '
GO
CREATE PROCEDURE dbo.dbSpLabCampValDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.LabCampVal
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- No se retorna nada al eliminar un registro
END

	