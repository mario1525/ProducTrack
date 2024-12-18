﻿-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/06/5
-- Description: creacion de los procedimientos almacenados
-- para la tabla compania de la DB ProductTrack
-- 
-- --------------------------------------------------------
--                     UPDATES 
-- --------------------------------------------------------
-- Author:		Mario Beltran
-- Update Date: 2024/11/26
-- Description: se actualizo el sp dbo.dbSpCompaniaGetVista 
--              por cambios en la estructura genral de la
--              base de datos.             
-- --------------------------------------------------------
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

--==================================================
-- SP para mostrar Numero general del las companias 
--==================================================
PRINT 'Creación del procedimiento Compania Get vista'
GO
CREATE PROCEDURE dbo.dbSpCompaniaGetVista  
AS 
BEGIN
	SELECT 
		C.Id AS ID, 
		C.Nombre AS Compania,

		-- numero de usuarios en la compania
		(SELECT COUNT(U.Id)
		 FROM Usuario U 
		 WHERE U.IdCompania = C.Id
		 AND U.Eliminado = 0) AS NumeroDeUsuarios,

        -- Numero de proyecto asociados a la compania
		(SELECT COUNT(P.Id) 
		 FROM Proyecto P 
		 WHERE P.IdCompania = C.Id 
		 AND P.Eliminado = 0) AS NumeroProyectos,
     
	    -- Numero de Ordenes Registradas en la Compania
		(SELECT COUNT(RO.Id) 
		 FROM RegisOrden RO 
		 INNER JOIN Orden O ON RO.IdOrden = O.Id
		 INNER JOIN Proyecto P ON O.IdProyecto = P.Id
		 WHERE P.IdCompania = C.Id
		 AND RO.Eliminado = 0) AS NOrdenesRegis,
     
	    -- Numero de productos registrados en la compania
		(SELECT COUNT(RP.Id) 
		 FROM RegisProduct RP 
		 INNER JOIN Producto PR ON RP.IdProduct = PR.Id
		 INNER JOIN Proyecto P ON PR.IdProyecto = P.Id
		 WHERE P.IdCompania = C.Id
		 AND RP.Eliminado = 0) AS NProductosRegis,
     
		C.Fecha_log
	FROM 
		Compania C
	WHERE 
		C.Eliminado = 0
	ORDER BY 
		NumeroDeUsuarios DESC;

END
GO


