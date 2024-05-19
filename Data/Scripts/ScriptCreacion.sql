﻿-- ==================================================
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
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre de la compania*/
        NIT           VARCHAR(255) NOT NULL DEFAULT '',           /*Numero mercantil de la compañia*/
        Direccion     VARCHAR(255) NOT NULL DEFAULT '',          /*Direccion de la compania*/       
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado */
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
END
GO

-- Tabla Usuario
PRINT 'creacion de la tabla Usuario'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Usuario')
BEGIN
    CREATE TABLE dbo.Usuario(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre del usuario*/
        Apellido      VARCHAR(255) NOT NULL DEFAULT '',           /*Apellido del usuario*/
        Rol           VARCHAR(60) NOT NULL DEFAULT 'Usuario',    /*Rol del usuario*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
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
		FKUsuarioUcompania FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id)
END
GO

-- Tabla UsuarioCompania
PRINT 'creacion de la tabla UsuarioCompania'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'UsuarioCompania')
BEGIN
    CREATE TABLE dbo.UsuarioCompania(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        IdUsuario	  VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla Usuarios*/
        IdCompania	  VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Compania*/ 
        Cargo         VARCHAR(60) NOT NULL DEFAULT 'Usuario',    /*Cargo interno en la compania*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
        ) ON [PRIMARY]
        ALTER TABLE dbo.UsuarioCompania ADD CONSTRAINT
		FKUsuarioUpcompania FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id)  
        ALTER TABLE dbo.UsuarioCompania ADD CONSTRAINT
		FKUsuariocompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
END
GO

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
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = '')
BEGIN
    CREATE TABLE dbo.ProcesEtap(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',           /*Nombre de la etapa*/
        IdProceso	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Proceso*/ 
        Estado	 	  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.ProcesEtap ADD CONSTRAINT
		FKProcesEtap FOREIGN KEY (IdProceso) REFERENCES dbo.Proceso(Id)
END
GO

-- Tabla Orden
PRINT 'creacion de la tabla Orden'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Orden')
BEGIN
    CREATE TABLE dbo.Orden(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre de la etapa*/
        IdCompania	  VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Compania*/ 
        IdUsuario	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Usuarios*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado del Usuario*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.Orden ADD CONSTRAINT
		FKOrdenUsuario FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(Id)
    ALTER TABLE dbo.Orden ADD CONSTRAINT
		FKOrdencompania FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
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
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        IdOrden  	  VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Orden*/ 
        Estado			BIT NOT NULL DEFAULT 1,                  /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0,                 /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP  /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisOrden ADD CONSTRAINT
		FKOrdenRegisCamp FOREIGN KEY (IdOrden) REFERENCES dbo.Orden(Id)    
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
		FKOrdenCamp FOREIGN KEY (IdOrdenCamp) REFERENCES dbo.OrdenCamp(Id)
    ALTER TABLE dbo.OrdenCampVal ADD CONSTRAINT
		FKRegisOrden FOREIGN KEY (IdRegisOrden) REFERENCES dbo.RegisOrden(Id)
END
GO

-- Tabla Producto
PRINT 'creacion de la tabla Producto '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Producto')
BEGIN
    CREATE TABLE dbo.Producto(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre Producto*/
        IdCompania	  VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Compania*/ 
        IdProceso	  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Proceso*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.Producto ADD CONSTRAINT
		FKProducComp FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)
    ALTER TABLE dbo.Producto ADD CONSTRAINT
		FKProductProces FOREIGN KEY (IdProceso) REFERENCES dbo.Proceso(Id)
END
GO

-- Tabla RegisProduct
PRINT 'creacion de la tabla RegisProduct '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisProduct')
BEGIN
    CREATE TABLE dbo.RegisProduct(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        IdProduct	  VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Producto*/
        IdRegisOrden  VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla RegisOrden*/
        Estado			BIT NOT NULL DEFAULT 1,                 /*Estado*/
		Eliminado		BIT NOT NULL DEFAULT 0,                /*Eliminado*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisProduct ADD CONSTRAINT
		FKRegisProduct FOREIGN KEY (IdProduct) REFERENCES dbo.Product(Id)
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

-- Tabla RegisProductProcesEtap
PRINT 'creacion de la tabla RegisProductProcesEtap'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisProductProcesEtap')
BEGIN
    CREATE TABLE dbo.RegisProductProcesEtap(
        Id                      VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',  /*id interno del registro*/
        IdRegisProduct          VARCHAR(36) NOT NULL DEFAULT '',             /*FK de la tabla regisProduct */  
        IdProcesEtap            VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla ProcesEtap*/
        IdUsuarioCompania       VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla usuario Compania*/
        Estado			        BIT NOT NULL DEFAULT 1,                   /*Estado*/
		Eliminado		        BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log               SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKRegisproductP FOREIGN KEY (IdRegisProduct) REFERENCES dbo.RegisProduct(Id) 
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKRprocesEtap FOREIGN KEY (IdProcesEtap) REFERENCES dbo.ProcesEtap(Id) 
    ALTER TABLE dbo.RegisProductProcesEtap ADD CONSTRAINT
		FKReUsuarioCompania FOREIGN KEY (IdUsuarioCompania) REFERENCES dbo.UsuarioCompania(Id) 
END
GO

-- Tabla Lab
PRINT 'creacion de la tabla Lab '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Lab')
BEGIN
    CREATE TABLE dbo.Lab(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',            /*Nombre Laboratorio*/
        IdCompania	  VARCHAR(36) NOT NULL DEFAULT '',            /*FK de la tabla Compania*/
        Estado			BIT NOT NULL DEFAULT 1, /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0, /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.Lab ADD CONSTRAINT
		FKLabComp FOREIGN KEY (IdCompania) REFERENCES dbo.Compania(Id)    
END
GO

-- Tabla LabCamp
PRINT 'creacion de la tabla LabCamp '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'LabCamp')
BEGIN
    CREATE TABLE dbo.LabCamp(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '',    /*id interno del registro*/
        Nombre        VARCHAR(255) NOT NULL DEFAULT '',              /*Nombre del campo*/
        TipoDato      VARCHAR(60) NOT NULL DEFAULT 'double',        /*Tipo de dato del campo*/
        UnidadMedida  VARCHAR(10) NOT NULL DEFAULT '',             /*Unidad de medida del campo*/
        Obligatorio   BIT NOT NULL DEFAULT 0,                     /*campo obligatorio*/
        IdLab         VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Lab*/
        Estado		  BIT NOT NULL DEFAULT 1,                   /*Estado*/
		Eliminado	  BIT NOT NULL DEFAULT 0,                  /*Eliminado*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) ON [PRIMARY]
    ALTER TABLE dbo.LabCamp ADD CONSTRAINT
		FKLabCamp FOREIGN KEY (IdLab) REFERENCES dbo.Lab(Id) 
END
GO

-- Tabla RegisLabProcesEtap
PRINT 'creacion de la tabla RegisLabProcesEtap'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'RegisLabProcesEtap')
BEGIN
    CREATE TABLE dbo.RegisLabProcesEtap(
        Id                          VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
        IdRegisProductProcesEtap    VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla ProcesEtap*/
        IdLab         VARCHAR(36) NOT NULL DEFAULT '',           /*FK de la tabla Lab*/
        Estado			            BIT NOT NULL DEFAULT 1, /*Estado del Usuario*/
		Eliminado		            BIT NOT NULL DEFAULT 0, /*Eliminado usuario*/
        Fecha_log                   SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
END
GO

-- Tabla LabCampVal
PRINT 'creacion de la tabla LabCampVal'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'LabCampVal')
BEGIN
    CREATE TABLE dbo.LabCampVal(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
       
        Estado			BIT NOT NULL DEFAULT 1, /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0, /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
END
GO

-- Tabla Archivo
PRINT 'creacion de la tabla Archivo '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'Archivo')
BEGIN
    CREATE TABLE dbo.Archivo(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
       
        Estado			BIT NOT NULL DEFAULT 1, /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0, /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
END
GO

-- Tabla ArchivoVal
PRINT 'creacion de la tabla ArchivoVal '
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ArchivoVal')
BEGIN
    CREATE TABLE dbo.ArchivoVal(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
       
        Estado			BIT NOT NULL DEFAULT 1, /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0, /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
END
GO

-- Tabla ArchivoVal
PRINT 'creacion de la tabla ArchivoVal'
IF NOT EXISTS(SELECT NAME FROM sysobjects WHERE NAME = 'ArchivoVal')
BEGIN
    CREATE TABLE dbo.ArchivoVal(
        Id            VARCHAR(36) NOT NULL PRIMARY KEY DEFAULT '', /*id interno del registro*/
       
        Estado			BIT NOT NULL DEFAULT 1, /*Estado del Usuario*/
		Eliminado		BIT NOT NULL DEFAULT 0, /*Eliminado usuario*/
        Fecha_log     SMALLDATETIME DEFAULT CURRENT_TIMESTAMP /*log fecha*/
    ) 
END
GO

