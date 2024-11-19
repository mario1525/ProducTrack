-- ==================================================
-- Author:		Mario Beltran
-- Create Date: 2024/05/15
-- Description: creacion de la DB ProductTrack
-- ==================================================

PRINT 'creacion de la DB'
IF NOT EXISTS(SELECT NAME FROM SYSDATABASES WHERE NAME = 'ProductTrack')
BEGIN
    CREATE DATABASE ProductTrack
END
GO

USE ProductTrack
GO

-- Tabla Compania
PRINT 'creacion de la tabla Compania'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Compania')
BEGIN
    CREATE TABLE dbo.Compania(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',    /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',              /*Nombre de la compania*/
        Ciudad        VARCHAR(255) NOT NULL DEFAULT '',             /*ciudad hubicada la cede principal donde de la compania*/
        NIT           VARCHAR(255) NOT NULL DEFAULT '',            /*Numero mercantil de la compañia*/
        Direccion     VARCHAR(255) NOT NULL DEFAULT '',           /*Direccion de la compania*/ 
        Sector        VARCHAR(255) NOT NULL DEFAULT '',          /*sector en el que opera la compania*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado */
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
END
GO

-- Tabla Usuario
PRINT 'creacion de la tabla Proyecto'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Proyecto')
BEGIN
    CREATE TABLE dbo.Proyecto(
        Id              VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Nombre          VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre del usuario*/
        IdCompania	    VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Compania*/  
        IdUsuario	    VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Usuario coordinador encargado de este proyecto*/         
        Estado		    BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	    BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log       SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.Proyecto ADD CONSTRAINT
		FKProyectocompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
END
GO

-- Tabla Usuario
PRINT 'creacion de la tabla Usuario'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Usuario')
BEGIN
    CREATE TABLE dbo.Usuario(
        Id              VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',      /*id interno del registro*/
        Nombre          VARCHAR(255) NOT NULL DEFAULT '',                /*Nombre del usuario*/
        Apellido        VARCHAR(255) NOT NULL DEFAULT '',               /*Apellido del usuario*/
        Identificacion  BIGINT          NOT NULL DEFAULT 0,            /*numero de indentificacion del usuario*/
        Correo          VARCHAR(255) NOT NULL DEFAULT '',             /*Apellido del usuario*/
        IdCompania	    VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Compania*/
        Cargo           VARCHAR(60) NOT NULL DEFAULT '',            /*Cargo interno en la compania*/
        Rol             VARCHAR(60) NOT NULL DEFAULT 'Usuario',    /*Rol del usuario*/
        Estado		    BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	    BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log       SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.Usuario ADD CONSTRAINT
		FKUsuariocompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
END
GO

-- Tabla UserProyec
PRINT 'creacion de la tabla UserProyec'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'UserProyec')
BEGIN
    CREATE TABLE dbo.UserProyec(
        Id              VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/        
        IdUsuario	    VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Usuario*/   
        IdProyecto	    VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Proyecto*/        
        Estado		    BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	    BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log       SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.UserProyec ADD CONSTRAINT
		FKUserProyecUser FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id)
    ALTER TABLE dbo.UserProyec ADD CONSTRAINT
		FKUserProyecProyec FOREIGN KEY (IdProyecto) REFERENCES dbo.Proyecto(Id)    
END
GO

-- UsuarioCredencial
PRINT 'creacion de la tabla UsuarioCredencial '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'UsuarioCredencial')
BEGIN
    CREATE TABLE dbo.UsuarioCredencial(
        Id              VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Usuario         VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre de Usuario para logearse*/ 
        Contrasenia     VARCHAR(255) NOT NULL DEFAULT '',           /*Contraseña*/
        IdUsuario       VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la Tabla usuario*/
        Estado			BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/        
        Fecha_log       SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
        ALTER TABLE dbo.UsuarioCredencial ADD CONSTRAINT
		FKUsuarioCredential FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id)
END
GO

-- N/A
-- Tabla UsuarioCompania
--PRINT 'creacion de la tabla UsuarioCompania'
--IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'UsuarioCompania')
--BEGIN
--    CREATE TABLE dbo.UsuarioCompania(
--        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
--        IdUsuario	  VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Usuarios*/
--         
--        Cargo         VARCHAR(60) NOT NULL DEFAULT 'Usuario',    /*Cargo interno en la compania*/
--        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
--		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
--        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
--        ) ON [PRIMARY]
--        ALTER TABLE dbo.UsuarioCompania ADD CONSTRAINT
--		FKUsuarioUpcompania FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id)  
--        ALTER TABLE dbo.UsuarioCompania ADD CONSTRAINT
--		FKUsuariocompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
--END
--GO

-- Tabla Proceso
PRINT 'creacion de la tabla Proceso'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Proceso')
BEGIN
    CREATE TABLE dbo.Proceso(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',           /*Nombre del Proceso*/  
        IdCompania	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Compania*/ 
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.Proceso ADD CONSTRAINT
		FKProcesocompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
END
GO

-- Tabla ProcesEtap
PRINT 'creacion de la tabla ProcesEtap'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ProcesEtap')
BEGIN
    CREATE TABLE dbo.ProcesEtap(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre de la etapa*/
        NEtapa        INT    NOT NULL DEFAULT '',                 /*Nombre de la etapa*/
        IdProceso	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Proceso*/ 
        Estado	 	  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.ProcesEtap ADD CONSTRAINT
		FKProcesEtap FOREIGN KEY (IdProceso) REFERENCES dbo.Proceso(Id)
END
GO

-- Tabla TipoOrden
PRINT 'creacion de la tabla TipoOrden'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'TipoOrden')
BEGIN
    CREATE TABLE dbo.TipoOrden(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',   /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',             /*Nombre de la etapa*/  
        IdProyecto	  VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Proyecto*/     
        Estado		  BIT NOT NULL DEFAULT 1,                     /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                    /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP   /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.TipoOrden ADD CONSTRAINT
		FKTipoOrdenProyect FOREIGN KEY (IdProyecto) REFERENCES dbo.Proyecto(Id)
END
GO

-- Tabla Orden
PRINT 'creacion de la tabla Orden'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Orden')
BEGIN
    CREATE TABLE dbo.Orden(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',   /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',             /*Nombre de la etapa*/
        IdProyecto    VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Proyecto*/         
        IdTipoOrden   VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla TipoOrden*/
        IdProceso 	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Proceso*/       
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]    
    ALTER TABLE dbo.Orden ADD CONSTRAINT
		FKOrdenProyecto FOREIGN KEY (IdProyecto) REFERENCES dbo.Proyecto(Id)
    ALTER TABLE dbo.Orden ADD CONSTRAINT
		FKOrdenProces FOREIGN KEY (IdProceso) REFERENCES dbo.Proceso(Id)  
    ALTER TABLE dbo.Orden ADD CONSTRAINT
		FKOrdenTipoOrden FOREIGN KEY (IdTipoOrden) REFERENCES dbo.TipoOrden(Id)  
END
GO

-- Tabla OrdenCamp
PRINT 'creacion de la tabla OrdenCamp'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'OrdenCamp')
BEGIN
    CREATE TABLE dbo.OrdenCamp(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',   /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',             /*Nombre de la etapa*/
        TipoDato      VARCHAR(60) NOT NULL DEFAULT '',             /*Tipo de dato del campo*/
        Obligatorio   BIT NOT NULL DEFAULT 0,                     /*campo obligatorio*/
        IdOrden  	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Orden*/ 
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.OrdenCamp ADD CONSTRAINT
		FKOrdenCamp FOREIGN KEY (IdOrden) REFERENCES dbo.Orden(Id)
END
GO

-- Tabla RegisOrden
PRINT 'creacion de la tabla RegisOrden'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisOrden')
BEGIN
    CREATE TABLE dbo.RegisOrden(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',   /*id interno del registro*/
        IdOrden  	  VARCHAR(36) NOT NULL DEFAULT '',              /*FK de la tabla Orden*/                 
        IdUsuario	  VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Usuarios, Supervisor encargado*/
        Estado			BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP   /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisOrden ADD CONSTRAINT
		FKregisOrdenUsuario FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id)
    ALTER TABLE dbo.RegisOrden ADD CONSTRAINT
		FKOrdenRegisOrden FOREIGN KEY (IdOrden) REFERENCES dbo.Orden(Id)              
END
GO

-- Tabla OrdenCampVal
PRINT 'creacion de la tabla OrdenCampVal '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'OrdenCampVal')
BEGIN
    CREATE TABLE dbo.OrdenCampVal(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        Valor         VARCHAR(255) NOT NULL DEFAULT '',           /*valor a guardar en campo*/
        IdOrdenCamp   VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla OrdenCamp*/  
        IdRegisOrden  VARCHAR(36) NOT NULL DEFAULT '',          /*FK de la tabla RegisOrden*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado */
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.OrdenCampVal ADD CONSTRAINT
		FKOrdenCCamp FOREIGN KEY (IdOrdenCamp) REFERENCES dbo.OrdenCamp(Id)
    ALTER TABLE dbo.OrdenCampVal ADD CONSTRAINT
		FKRegisOrden FOREIGN KEY (IdRegisOrden) REFERENCES dbo.RegisOrden(Id)
END
GO

-- Tabla RegisOrdenProcesEtap
PRINT 'creacion de la tabla RegisOrdenProcesEtap'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisProductProcesEtap')
BEGIN
    CREATE TABLE dbo.RegisOrdenProcesEtap(
        Id                      VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        IdRegisOrden            VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla regisOrden */  
        IdProcesEtap            VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla ProcesEtap*/
        IdUsuario               VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla usuario, usuario que registro esa etapa*/
        Estado			        BIT NOT NULL DEFAULT 1,                   /*Estado*/
		Eliminado		        BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log               SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisOrdenProcesEtap ADD CONSTRAINT
		FKRegisORdeno FOREIGN KEY (IdRegisOrden) REFERENCES dbo.RegisOrden(Id) 
    ALTER TABLE dbo.RegisOrdenProcesEtap ADD CONSTRAINT
		FKROprocesEtap FOREIGN KEY (IdProcesEtap) REFERENCES dbo.ProcesEtap(Id) 
    ALTER TABLE dbo.RegisOrdenProcesEtap ADD CONSTRAINT
		FKReUsuarioORden FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id) 
END
GO

-- Tabla Report
PRINT 'creacion de la tabla de plantilla de reporte'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ReportePlant')
BEGIN
    CREATE TABLE dbo.ReportePlant(
        Id                  VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',    /*id interno del registro*/ 
        Nombre              VARCHAR(255) NOT NULL DEFAULT '',              /*Nombre de la etapa*/
        IdCompania	        VARCHAR(36) NOT NULL DEFAULT '',              /*FK de la tabla Compania*/       
        Estado			        BIT NOT NULL DEFAULT 1,                  /*Estado*/
		Eliminado		        BIT NOT NULL DEFAULT 0,                 /*Eliminado*/       
        Fecha_log           SMALLDATETIME DEFAULT CURRENT_TIMESTAMP    /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.ReportePlant ADD CONSTRAINT
		FKReportePlantComp FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id) 
END
GO

-- Tabla OrdenReport
PRINT 'creacion de la tabla OrdenReport'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'OrdenReport')
BEGIN
    CREATE TABLE dbo.OrdenReport(
        Id              VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/        
        IdOrden	        VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Orden*/   
        IdReportePlant  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla ReportePlant*/        
        Estado		    BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	    BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log       SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.OrdenReport ADD CONSTRAINT
		FKOrdenReportOrden FOREIGN KEY (IdOrden) REFERENCES dbo.Orden(Id)
    ALTER TABLE dbo.OrdenReport ADD CONSTRAINT
		FKOrdenReportrep FOREIGN KEY (IdReportePlant) REFERENCES dbo.ReportePlant(Id)    
END
GO

-- Tabla RegisOrdenReport
PRINT 'creacion de la tabla RegisOrdenReport'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisOrdenReport')
BEGIN
    CREATE TABLE dbo.RegisOrdenReport(
        Id              VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/        
        IdRegisOrden	VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla RegisOrden*/   
        IdOrdenReport   VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla OrdenReport*/        
        Estado		    BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	    BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log       SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisOrdenReport ADD CONSTRAINT
		FKOrdenReportRegisOrden FOREIGN KEY (IdOrdenReport) REFERENCES dbo.OrdenReport(Id)
    ALTER TABLE dbo.RegisOrdenReport ADD CONSTRAINT
		FKRegisOrdenreport FOREIGN KEY (IdRegisOrden) REFERENCES dbo.RegisOrden(Id)    
END
GO


-- Tabla Producto
PRINT 'creacion de la tabla Producto '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Producto')
BEGIN
    CREATE TABLE dbo.Producto(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',   /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',             /*Nombre Producto*/
        IdProyecto    VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Proyecto*/         
        IdProceso	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Proceso*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.Producto ADD CONSTRAINT
		FKProducComp FOREIGN KEY (IdProyecto) REFERENCES dbo.Proyecto(Id)
    ALTER TABLE dbo.Producto ADD CONSTRAINT
		FKProductProces FOREIGN KEY (IdProceso) REFERENCES dbo.Proceso(Id)
END
GO

-- Tabla ProductReportPlant
PRINT 'creacion de la tabla de reportes de producto'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ProductReport')
BEGIN
    CREATE TABLE dbo.ProductReport(
        Id                  VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',    /*id interno del registro*/ 
        IdReportPlant       VARCHAR(36) NOT NULL DEFAULT '',               /*FK de la tabla ReportPlant*/ 
        IdProduct           VARCHAR(36) NOT NULL DEFAULT '',              /*FK de la tabla Product*/
        Estado			        BIT NOT NULL DEFAULT 1,                  /*Estado*/
		Eliminado		        BIT NOT NULL DEFAULT 0,                 /*Eliminado*/       
        Fecha_log           SMALLDATETIME DEFAULT CURRENT_TIMESTAMP    /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.ProductReport ADD CONSTRAINT
		FKProductReportProduct FOREIGN KEY (IdProduct) REFERENCES dbo.Producto(Id)
    ALTER TABLE dbo.ProductReport ADD CONSTRAINT
		FKProductReport FOREIGN KEY (IdReportePlant) REFERENCES dbo.ReportePlant(Id) 
END
GO

-- Tabla RegisProduct
PRINT 'creacion de la tabla RegisProduct '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisProduct')
BEGIN
    CREATE TABLE dbo.RegisProduct(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        IdProduct	  VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Producto*/
        IdRegisOrden  VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla RegisOrden*/        
        Estado			BIT NOT NULL DEFAULT 1,                 /*Estado*/
		Eliminado		BIT NOT NULL DEFAULT 0,                /*Eliminado*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]    
    ALTER TABLE dbo.RegisProduct ADD CONSTRAINT
		FKRegisPProduct FOREIGN KEY (IdProduct) REFERENCES dbo.Producto(Id)
    ALTER TABLE dbo.RegisProduct ADD CONSTRAINT
		FKRegisProductRegisOrden FOREIGN KEY (IdRegisOrden) REFERENCES dbo.RegisOrden(Id)  
END
GO

-- Tabla ProductCamp
PRINT 'creacion de la tabla ProductCamp '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ProductCamp')
BEGIN
    CREATE TABLE dbo.ProductCamp(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',   /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',             /*Nombre del campo*/
        TipoDato      VARCHAR(60) NOT NULL DEFAULT '',             /*Tipo de dato del campo*/
        Obligatorio   BIT NOT NULL DEFAULT 0,                     /*campo obligatorio*/
        IdProduct	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Producto*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.ProductCamp ADD CONSTRAINT
		FKProducCamp FOREIGN KEY (IdProduct) REFERENCES dbo.Producto(Id)
END
GO

-- Tabla ProductCampVal
PRINT 'creacion de la tabla ProductCampVal '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ProductCampVal')
BEGIN
    CREATE TABLE dbo.ProductCampVal(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Valor         VARCHAR(255) NOT NULL DEFAULT '',            /*valor a guardar en campo*/
        IdProductCamp   VARCHAR(36) NOT NULL DEFAULT '',          /*FK de la tabla ProductCamp*/  
        IdRegisProduct  VARCHAR(36) NOT NULL DEFAULT '',         /*FK de la tabla RegisProduct*/
        Estado			BIT NOT NULL DEFAULT 1,                 /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0,                /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.ProductCampVal ADD CONSTRAINT
		FKProducCampVal FOREIGN KEY (IdProductCamp) REFERENCES dbo.ProductCamp(Id)
    ALTER TABLE dbo.ProductCampVal ADD CONSTRAINT
		FKRegisProduct FOREIGN KEY (IdRegisProduct) REFERENCES dbo.RegisProduct(Id)
END
GO

-- N/A
-- Tabla ProductRegisOrden 
--PRINT 'creacion de la tabla ProductRegisOrden '
--IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ProductRegisOrden')
--BEGIN
--    CREATE TABLE dbo.ProductRegisOrden(
--        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
--        
--        Estado			BIT NOT NULL DEFAULT 1, /*Estado del Usuario*/
--		Eliminado		BIT NOT NULL DEFAULT 0, /*Eliminado usuario*/
--        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
--    ) 
--END
--GO


-- Por terminar 
-- Tabla asignacion 
PRINT 'creacion de la tabla de asignacion'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ProductAsig')
BEGIN
    CREATE TABLE dbo.ProductAsig(
        Id                      VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',       /*id interno del registro*/
        IdRegisProduct          VARCHAR(36) NOT NULL DEFAULT '',                  /*FK de la tabla regisProduct */  
        IdProcesEtap            VARCHAR(36) NOT NULL DEFAULT '',                 /*FK de la tabla ProcesEtap*/
        IdUsuario	            VARCHAR(36) NOT NULL DEFAULT '',                /*FK de la tabla Usuarios*/
        Estado			         BIT NOT NULL DEFAULT 1,                       /*Estado*/
		Eliminado		         BIT NOT NULL DEFAULT 0,                      /*Eliminado*/       
        Fecha_log               SMALLDATETIME DEFAULT CURRENT_TIMESTAMP      /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKRegisproductP FOREIGN KEY (IdRegisProduct) REFERENCES dbo.RegisProduct(Id) 
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKRprocesEtap FOREIGN KEY (IdProcesEtap) REFERENCES dbo.ProcesEtap(Id) 
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKReUsuarioAsig FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id) 
END
GO

-- Tabla RegisProductProcesEtap
PRINT 'creacion de la tabla RegisProductProcesEtap'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisProductProcesEtap')
BEGIN
    CREATE TABLE dbo.RegisProductProcesEtap(
        Id                      VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        IdProductAsig           VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla ProductAsig */  
        Observacion             VARCHAR(255) NOT NULL DEFAULT '',           /*FK de la tabla ProcesEtap*/
        IdAdjuntos              VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Adjuntos*/
        Estado			        BIT NOT NULL DEFAULT 1,                   /*Estado*/
		Eliminado		        BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log               SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKRegisproductP FOREIGN KEY (IdRegisProduct) REFERENCES dbo.RegisProduct(Id) 
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKRprocesEtap FOREIGN KEY (IdProcesEtap) REFERENCES dbo.ProcesEtap(Id) 
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKReUsuarioCompania FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id) 
END
GO


-- Por terminar 
PRINT 'creacion de la tabla de plantilla correo'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'SMTPPlant')
BEGIN
    CREATE TABLE dbo.SMTPPlant(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',      /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',                /*Nombre de la plantilla*/
        IdCompania	  VARCHAR(36) NOT NULL DEFAULT '',                /*FK de la tabla Compania*/        
        Subjec        VARCHAR(255) NOT NULL DEFAULT '',              /*Sujeto del correo*/
        mesage        VARCHAR(MAX) NOT NULL DEFAULT '',             /*Mensaje del correo*/
        Estado			    BIT NOT NULL DEFAULT 1,                /*Estado*/
		Eliminado		    BIT NOT NULL DEFAULT 0,               /*Eliminado*/       
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP    /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.SMTPPlant ADD CONSTRAINT
		FKSMTcompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
END
GO

-- Por terminar 
-- tabla SMTPHistorial 
PRINT 'creacion de la tabla de historial de Notificacines SMTP'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'SMTPHistorial')
BEGIN
    CREATE TABLE dbo.SMTPHistorial(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',       /*id interno del registro*/
        IdCompania	  VARCHAR(36) NOT NULL DEFAULT '',                  /*FK de la tabla Compania*/                      
        IdUsuario	  VARCHAR(36) NOT NULL DEFAULT '',                 /*FK de la tabla Usuarios*/        
        para          VARCHAR(255) NOT NULL DEFAULT '',               /*a quien va el correo*/
        CC            VARCHAR(255) NOT NULL DEFAULT '',              /*adjunto al correo*/
        Subjec        VARCHAR(255) NOT NULL DEFAULT '',             /*sujeto del correo*/
        Mensaje       VARCHAR(MAX) NOT NULL DEFAULT '',            /*Mensaje del correo*/
        Estado			    BIT NOT NULL DEFAULT 1,               /*Estado*/
		Eliminado		    BIT NOT NULL DEFAULT 0,              /*Eliminado*/       
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP   /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.SMTPHistorial ADD CONSTRAINT
		FKSMTHistorialcompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
END
GO

PRINT 'creacion de la tabla BackupToken'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'BackupToken')
BEGIN
    CREATE TABLE dbo.BackupToken(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        Token        VARCHAR(1000) NOT NULL DEFAULT '',           /*Token*/        
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP    /*log fecha*/
    ) 
END
GO