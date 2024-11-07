-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5
-- Description: creacion de los procedimientos almacenados
-- para la tabla compania de la DB ProductTrack
-- ========================================================

PRINT 'Creacion procedimientos tabla Compania'
IF EXISTS(SELECT NAME FROM SYSOBJECTS WHERE NAME LIKE 'dbSpCompania%')
BEGIN
    DROP PROCEDURE dbo.dbSpCompaniaGet
	DROP PROCEDURE dbo.dbSpCompaniaSet
	DROP PROCEDURE dbo.dbSpCompaniaDet
	DROP PROCEDURE dbo.dbSpCompaniaActive
    DROP PROCEDURE dbo.dbSpCompaniaGetVista
END

PRINT 'Creacion procedimiento Compania Get '
GO
CREATE PROCEDURE dbo.dbSpCompaniaGet
    @Id          VARCHAR(36),
    @Nombre      VARCHAR(255),
    @NIT         VARCHAR(255),
    @Sector      VARCHAR(255),
    @Ciudad      VARCHAR(255),
    @Direccion   VARCHAR(255),
    @Estado      INT
AS 
BEGIN
    SELECT Id, Nombre, Ciudad, NIT, Direccion, Sector, Estado, Fecha_log     
    FROM dbo.Compania
    WHERE Id = CASE WHEN ISNULL(@Id,'')='' THEN Id ELSE @Id END
    AND Nombre LIKE CASE WHEN ISNULL(@Nombre,'')='' THEN Nombre ELSE '%'+@Nombre+'%' END    
    AND NIT LIKE CASE WHEN ISNULL(@NIT,'')='' THEN NIT ELSE '%'+@NIT+'%' END
    AND Ciudad LIKE CASE WHEN ISNULL(@Ciudad,'')='' THEN Ciudad ELSE '%'+@Ciudad+'%' END
    AND Sector LIKE CASE WHEN ISNULL(@Sector,'')='' THEN Sector ELSE '%'+@Sector+'%' END
    AND Direccion LIKE CASE WHEN ISNULL(@Direccion,'')='' THEN Direccion ELSE '%'+@Direccion+'%' END
    AND Estado = CASE WHEN ISNULL(@Estado,0) = 1 THEN 1 ELSE 0 END
    AND Eliminado = 0
END
GO


PRINT 'Creacion procedimiento Compania Set '
GO
CREATE PROCEDURE dbo.dbSpCompaniaSet
    @Id          VARCHAR(36),
    @Nombre      VARCHAR(255),
    @NIT         VARCHAR(255),
    @Direccion   VARCHAR(255),
    @Sector      VARCHAR(255),
    @Ciudad      VARCHAR(255),
    @Estado      BIT,
    @Operacion   VARCHAR(1)
AS
BEGIN
    IF @Operacion = 'I'
    BEGIN
        INSERT INTO dbo.Compania(Id, Nombre, Ciudad, NIT, Direccion, Sector, Estado, Fecha_log, Eliminado)
        VALUES(@Id, @Nombre,@Ciudad, @NIT, @Direccion, @Sector, @Estado, DEFAULT, 0)
    END
    ELSE IF @Operacion = 'A'
    BEGIN
        UPDATE dbo.Compania
        SET Nombre = @Nombre, Ciudad = @Ciudad, NIT = @NIT, Direccion = @Direccion, Sector = @Sector, Estado = @Estado
        WHERE Id = @Id
    END
END
GO


PRINT 'Creacion procedimiento Compania Del '
GO
CREATE PROCEDURE dbo.dbSpCompaniaDel
    @Id VARCHAR(36)
AS
BEGIN
    -- Actualiza el estado "Eliminado" a 1
    UPDATE dbo.Compania
    SET Eliminado = 1
    WHERE Id = @Id;
    
    -- Obtiene el estado "Eliminado" después de la actualización 
    SELECT Eliminado
    FROM dbo.Compania
    WHERE Id = @Id;    
END

GO
PRINT 'Creacion procedimiento Compania Active '
GO
CREATE PROCEDURE dbo.dbSpCompaniaActive
    @Id VARCHAR(36),
    @Estado BIT
AS
BEGIN
    UPDATE dbo.Compania
    SET Estado = @Estado
    WHERE Id = @Id
END
GO

PRINT 'Creación del procedimiento Compania Get vista'
GO
CREATE PROCEDURE dbo.dbSpCompaniaGetVista  
AS 
BEGIN
    SELECT 
        C.Id AS ID, 
        C.Nombre AS Compania,
        (SELECT COUNT(U.Id) FROM Usuario U WHERE U.IdCompania = C.Id) AS NumeroDeUsuarios,
        (SELECT COUNT(RO.Id) FROM RegisOrden RO INNER JOIN Orden O ON O.Id = RO.IdOrden WHERE O.IdCompania = C.Id) AS NOrdenesRegis, 
        (SELECT COUNT(RP.Id) FROM RegisProduct RP INNER JOIN Producto P ON P.Id = RP.IdProduct WHERE P.IdCompania = C.Id) AS NProductosRegis,
        C.Fecha_log
    FROM 
        Compania C
    WHERE 
        C.Eliminado = 0
    ORDER BY 
        NumeroDeUsuarios DESC;
END
GO

