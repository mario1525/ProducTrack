-- ========================================================
-- Author:		Mario Beltran
-- Create Date: 2024/09/22
-- Description: creacion de procedimento almacenado para
-- devolver ultima etapa registrada de una orden 
-- DB ProductTrack
-- ========================================================

PRINT 'Creacion de sp dbSpLastOrdenEtap'
GO
CREATE PROCEDURE dbo.dbSpLastOrdenEtap
	@IdOrden VARCHAR(36)
AS
BEGIN
	SELECT TOP 1 pe.NEtapa
		from dbo.ProcesEtap pe 
	    INNER JOIN dbo.RegisOrdenProcesEtap rope ON pe.Id = rope.IdProcesEtap 
    	WHERE rope.IdRegisOrden = @IdOrden
  		ORDER BY pe.NEtapa DESC 
END 