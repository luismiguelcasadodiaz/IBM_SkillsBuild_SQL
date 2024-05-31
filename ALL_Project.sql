/*-----------------------------------------------------------------
                      I_CREATE DATABASE
  -----------------------------------------------------------------*/

--CREATE DATABASE luismiguelcasado;

/*-----------------------------------------------------------------
                      II_CREATE TABLES
  -----------------------------------------------------------------*/
USE luismiguelcasado
GO
--1. Deberás crear la tabla Clientes (Clientes)
CREATE TABLE [dbo].[Clientes] (
	idCliente INT NOT NULL IDENTITY(1,1),
	Nombre VARCHAR(50) NOT NULL,
	Apellido VARCHAR(50) NOT NULL,
	Fnacimiento DATE NOT NULL,
	Domicilio VARCHAR(50) NOT NULL,
	idPais CHAR(3) NOT NULL,
	Telefono VARCHAR(12) NULL,
	Email VARCHAR(30) NOT NULL,
	Observaciones  VARCHAR(1000) NULL,
	FechaAlta DATETIME NOT NULL,
	CONSTRAINT PK_clientes PRIMARY KEY(idCliente)
);
--2. Deberás construir la tabla de hechos llamada Record (Record)
CREATE TABLE [dbo].[Record] (
	idRecord INT NOT NULL IDENTITY(1,1),
	FechaRecord DATE NOT NULL,
	Observaciones VARCHAR(1000) NULL,
	CONSTRAINT PK_record PRIMARY KEY(idRecord)
);
--3.Deberás definir la tabla de hechos Record Cliente (RecordCliente)
CREATE TABLE [dbo].[RecordCliente] (
	idRecord INT NOT NULL,
	idCliente INT NOT NULL,
	idCampania INT NOT NULL,
	CONSTRAINT PK_RecordCliente PRIMARY KEY CLUSTERED (idRecord ASC, idCliente ASC, idCampania ASC)
);
--4. Deberás hacer la tabla País (Pais)
CREATE TABLE [dbo].[Pais] (
	idPais	CHAR(3) NOT NULL,
	NombrePais VARCHAR(100) NOT NULL
	CONSTRAINT PK_Pais PRIMARY KEY (idPais)
);
--5. Deberás crear la tabla Horario Captación Campaña (HoraCaptacion)
CREATE TABLE [dbo].[HoraCaptacion] (
	idHCaptacion INT NOT NULL IDENTITY(1,1),
	FechaCaptacion DATE NOT NULL,
	EstadoCaptacion SMALLINT NOT NULL,
	Observaciones VARCHAR(1000) NULL,
	CONSTRAINT PF_HoraCpatacion PRIMARY KEY(idHcaptacion)
);
--6. Deberás generar la tabla Horario Captación Campaña Cliente (HoraCapClienteCampania)
CREATE TABLE [dbo].[HoraCapClienteCampania] (
	idHCaptacion INT NOT NULL,
	idCliente INT NOT NULL,
	idCampania INT NOT NULL,
	CONSTRAINT PK_HoraCapCLienteCampania PRIMARY KEY CLUSTERED(idHcaptacion ASC, idCliente ASC, idcampania ASC)
);
--7. Deberás definir la tabla Horario Estado (HorarioEstado)
CREATE TABLE [dbo].[HorarioEstado] (
	idEstado SMALLINT NOT NULL IDENTITY(1,1),
	Descripcion VARCHAR(50) NOT NULL
	CONSTRAINT PK_HOrarioEstado PRIMARY KEY (idEstado)
);
--8. Deberás crear la tabla Producto (Producto)
CREATE TABLE [dbo].[Producto] (
	idProducto INT NOT NULL IDENTITY(1,1),
	Prodcuto VARCHAR(100)
	CONSTRAINT PK_producto PRIMARY KEY(idProducto)
);
-- 9. Deberás construir la tabla Compras (Compra)
CREATE TABLE [dbo].[Compra] (
	idCompras INT NOT NULL IDENTITY(1,1),
	Concepto INT NOT NULL,
	Fecha datetime NOT NULL,
	MONTO money NOT NULL,
	Observaciones varchar(1000),
	CONSTRAINT PK_Compra primary key(idCompras)
);
-- 10. Deberás construir la tabla ComprasCliente (CompraCliente)
CREATE TABLE [dbo].[CompraCLiente] (
	idCompras INT NOT NULL,
	idCliente INT NOT NULL,
	idHCaptacion INT NOT NULL,
	CONSTRAINT PK_compracliente PRIMARY KEY CLUSTERED (idCompras ASC, idCliente ASC, idHCaptacion)
);
-- 11. Deberás construir la tabla Campaña (Campania)
CREATE TABLE [dbo].[Campania] (
	idCampania INT NOT NULL IDENTITY(1,1),
	NombreCampaña VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Campania PRIMARY KEY(idCampania)
);
-- 12. Deberás construir la tabla Campaña Producto (CampaniaProducto)
CREATE TABLE [dbo].[CampaniaProducto] (
	idCampania INT NOT NULL,
	IdProducto INT NOT NULL,
	Descripcion	VARCHAR(100) NOT NULL,
	CONSTRAINT PK_campaniaProducto PRIMARY KEY CLUSTERED (idCampania ASC, idProducto ASC)
);
-- 13. Deberás construir la tabla Concepto de compra (ConceptoCompra)
CREATE TABLE [dbo].[ConceptoCompra] (
	idConcepto INT NOT NULL IDENTITY(1,1),
	Concepto VARCHAR(100) NOT NULL,
	CONSTRAINT PK_ConceptoCompra PRIMARY KEY (idConcepto)
);

/*
sp_who
DROP DATABASE  luismiguelcasado;
DROP TABLE [dbo].[Clientes];
DROP TABLE [dbo].[Record];
DROP TABLE [dbo].[RecordCliente];
DROP TABLE [dbo].[Pais];
DROP TABLE [dbo].[HoraCaptacion];
DROP TABLE [dbo].[HoraCapClienteCampania];
DROP TABLE [dbo].[HorarioEstado];
DROP TABLE [dbo].[Producto];
DROP TABLE [dbo].[Compra];
DROP TABLE [dbo].[CompraCLiente];
DROP TABLE [dbo].[Campania];
DROP TABLE [dbo].[CampaniaProducto];
DROP TABLE [dbo].[ConceptoCompra];
*/

/*-----------------------------------------------------------------
                      III_CREATE RELATIONS
  -----------------------------------------------------------------*/

-- 1.Cliente con País a través del IdPais
ALTER TABLE [dbo].[Clientes]
	ADD CONSTRAINT FK_Clientes_Pais FOREIGN KEY(idPais)
		REFERENCES [dbo].[Pais] (idPais)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
-- 2.ConceptoCompra con Compra a través de IdConcepto y Concepto
ALTER TABLE [dbo].[Compra]
	ADD CONSTRAINT FK_Compra_ConceptoCompra FOREIGN KEY(Concepto)
		REFERENCES [dbo].[ConceptoCompra] (idConcepto)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
-- 3.HorarioEstado con HoraCaptacion a través de IdEstado y EstadoCaptacion
ALTER TABLE [dbo].[HoraCaptacion]
	ADD CONSTRAINT FK_HoraCaptacion_Estado FOREIGN KEY (EstadoCaptacion)
		REFERENCES [dbo].[HorarioEstado] (idEstado)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
-- 4.Compra con CompraCliente a través de IdCompra
ALTER TABLE [dbo].[compraCLiente]
	ADD CONSTRAINT FK_CompraCliente_Compra FOREIGN KEY (idCompras)
		REFERENCES [dbo].[Compra] (idCompras)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
-- 5.Cliente con CompraCliente a través de IdCliente
ALTER TABLE [dbo].[compraCLiente]
	ADD CONSTRAINT FK_CompraCliente_Cliente FOREIGN KEY (idCliente)
		REFERENCES [dbo].[Clientes] (idCliente)
		ON DELETE CASCADE
		ON UPDATE CASCADE;
-- 6.HoraCapClienteCampania con HoraCaptacion a través de IdHCaptacion
ALTER TABLE [dbo].[HoraCapCLienteCampania]
	ADD CONSTRAINT FK_HoraCapCLienteCampania_HoraCaptacion FOREIGN KEY (idHCaptacion)
	REFERENCES [dbo].[HoraCaptacion] (idHCaptacion)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
-- 7.HoraCapClienteCampania con Cliente a través de IdCliente
ALTER TABLE [dbo].[HoraCapCLienteCampania]
	ADD CONSTRAINT FK_HoraCapCLienteCampania_Cliente FOREIGN KEY (idCliente)
	REFERENCES [dbo].[Clientes] (idCliente)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
-- 8.HoraCapClienteCampania con Campania a través de IdCampania
ALTER TABLE [dbo].[HoraCapCLienteCampania]
	ADD CONSTRAINT FK_HoraCapCLienteCampania_campania FOREIGN KEY (idCampania)
	REFERENCES [dbo].[Campania] (idCampania)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
-- 9.CampaniaProducto con Producto a través de IdProducto
ALTER TABLE [dbo].[CampaniaProducto]
	ADD CONSTRAINT FK_CampaniaProduct_Campania FOREIGN KEY (idCampania)
	REFERENCES [dbo].[campania] (idCampania)
	ON DELETE CASCADE
	ON UPDATE CASCADE;

-- 10.CampaniaProducto con Campania a través de IdCampania
ALTER TABLE [dbo].[CampaniaProducto]
	ADD CONSTRAINT FK_CampaniaProduct_Producto FOREIGN KEY (idProducto)
	REFERENCES [dbo].[Producto] (idProducto)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
-- 11.Record con RecordCliente a través de IdRecord
ALTER TABLE [dbo].[RecordCliente]
	ADD CONSTRAINT FK_RecordCliente_Record FOREIGN KEY (idRecord)
	REFERENCES [dbo].[Record] (idRecord)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
-- 12.RecordCliente con Cliente a través de IdCliente
ALTER TABLE [dbo].[RecordCliente]
	ADD CONSTRAINT FK_RecordCliente_Cliente FOREIGN KEY (idCliente)
	REFERENCES [dbo].[Clientes] (idCliente)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
-- 13.RecordCliente con Campania a través de IdCampania
ALTER TABLE [dbo].[RecordCliente]
	ADD CONSTRAINT FK_RecordCliente_Campania FOREIGN KEY (idCampania)
	REFERENCES [dbo].[Campania] (idCampania)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
-- 14. CompraCliente con HOra Captacion a traves de idHcaptacion 
ALTER TABLE [dbo].[CompraCliente]
	ADD CONSTRAINT FK_CompraCliente_HoraCaptacion FOREIGN KEY(idHCaptacion)
	REFERENCES [dbo].[HoraCaptacion] (idHCaptacion)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
/*-----------------------------------------------------------------
                      IV_INSERT RECORDS
  -----------------------------------------------------------------*/
-- Insercion Registros en tabla Pais
INSERT INTO [dbo].[Pais] VALUES ('ESP','España');
INSERT INTO [dbo].[Pais] VALUES ('GRC','Grecia');
INSERT INTO [dbo].[Pais] VALUES ('IND','India ');
INSERT INTO [dbo].[Pais] VALUES ('USA','Estados Unidos');
INSERT INTO [dbo].[Pais] VALUES ('MEX','Mexico');
INSERT INTO [dbo].[Pais] VALUES ('BRA','Brasil');
INSERT INTO [dbo].[Pais] VALUES ('DEU','Alemania');
-- Insercion Registros en tabla Campania
INSERT INTO [dbo].[Campania] VALUES ('Producto Estrella 1');
INSERT INTO [dbo].[Campania] VALUES ('Producto Estrella 2');
INSERT INTO [dbo].[Campania] VALUES ('Producto Estrella 3');
-- Insercion Registros en tabla ConceptoCompra
INSERT INTO [dbo].[ConceptoCompra] VALUES ('Compra producto Estrella 1');
INSERT INTO [dbo].[ConceptoCompra] VALUES ('Compra producto Estrella 2');
INSERT INTO [dbo].[ConceptoCompra] VALUES ('Compra producto Estrella 3');
-- Insercion Registros en tabla HorarioEstado
INSERT INTO [dbo].[HorarioEstado] VALUES ('Prime tarde-noche');
INSERT INTO [dbo].[HorarioEstado] VALUES ('Valle Media tarde, media mañana');
INSERT INTO [dbo].[HorarioEstado] VALUES ('Breakfast ansted de las 10 AM');
INSERT INTO [dbo].[HorarioEstado] VALUES ('Nocturno después de las 00:00');
-- Insercion Registros en tablaCompra
INSERT INTO [dbo].[Compra] VALUES ('1','20240102','5000','Comprador de producto estrella 1');
INSERT INTO [dbo].[Compra] VALUES ('1','20240102','9999','Comprador de producto estrella 1');
INSERT INTO [dbo].[Compra] VALUES ('1','20240102','9999','Comprador de producto estrella 1');
INSERT INTO [dbo].[Compra] VALUES ('2','20240102','3500','Comprador de producto estrella 2');
INSERT INTO [dbo].[Compra] VALUES ('3','20240103','5000','Comprador de producto estrella 1');
-- Insercion Registros en tabla HoraCaptacion
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240105','1','Lead');
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240105','1','Lead');
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240105','1','Lead');
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240105','1','Lead');
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240105','2','Lead');
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240201','1','Cliente');
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240201','3','Prospecto');
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240201','1','Lead');
-- Remove records that subject does not mention
DELETE FROM [dbo].[HoraCaptacion] WHERE [idHCaptacion] IN (2,3,4);
-- Insercion Registros en tabla Clientes
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('Raúl','Gonzalez','19860525','Gualtatas 2526','ESP','664859632','donraul@gmail.es','No hay observaciones','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('James','Nicole','19900302','O'' nielljack2568','USA','1254685632','wuarden@green.us','No hay observaciones','20240106 00:01:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('Marta','Pérez','19950503','Brasilia 25','BRA','56432253','mPerezbra@getmail.com','No hay observaciones','20240201 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('Claudio','Ramirez','19840802','Cheguan 225','ESP','66852125','clauRami@gmail.es','NO hay observaciones','20240201 00:02:02.000');
INSERT INTO [dbo].[Clientes] VALUES ('del','del','20240101','del','IND','del','del','del','20240105 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('Markuis','Papadopulus','19820206','Grikindier 223','GRC','2548542355','papadopulusm@gmail.com','Es griego','20240201 00:06:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('Carlos','Trebor','19660503','Pedro pastor 2','MEX','135852133','Carlitos@gmail.ue','NO hay observaciones','20240201 00:00:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('Otto','Von Kunstmann','19750901','Otiggen str 3','DEU','6582216335','elaleman@aleman.com','ES Aleman','20240201 00:08:00.000');
INSERT INTO [dbo].[Clientes] VALUES ('Uit','Tlinnlnie','19770505','Intrati 22','IND','1325865523','uit@guit.in','Es Indio','20240206 00:00:00.000');
-- Remove records that subject does not mention
DELETE FROM [dbo].[Clientes] WHERE [IdCliente] IN (1,2,3,4,5,8,10,11,12,13,14,16);
-- Insercion Registros en tabla CompraCliente
INSERT INTO [dbo].[CompraCliente] VALUES ('1','6','1');
INSERT INTO [dbo].[CompraCliente] VALUES ('4','7','5');
INSERT INTO [dbo].[CompraCliente] VALUES ('5','15','6');
-- Insercion Registros en tabla CompraCliente
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('8','6','1');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('6','6','2');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('1','6','3');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('1','7','1');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('6','7','2');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('1','9','1');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('5','9','3');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('1','15','1');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('5','15','2');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('5','15','3');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('7','17','1');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('5','17','2');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('5','17','3');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('6','18','1');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('8','18','2');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('5','18','3');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('8','19','2');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('7','19','3');
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES ('5','20','2');


-- Insercion Registros en tabla HoraCaptacion
INSERT INTO [dbo].[HoraCaptacion] VALUES ('20240101','1','DESCONOCIDO');
-- Insercion Registros en tabla HoraCapClienteCampaña
-- Deberás colocar el idHCaptacion autogenerado en la tabla HoraCaptacion 
INSERT INTO [dbo].[HoraCapClienteCampania] VALUES (@@identity,'20','3');

/*-----------------------------------------------------------------
                      VI_CONSULTAS 
-----------------------------------------------------------------*/
-- 1 - Haz una consulta “SELECT” que llame a la tabla Cliente y te muestre su contenido.
USE [luismiguelcasado];
GO
SELECT * FROM [dbo].[Clientes];
-- 2 - Haz una consulta “SELECT” que te muestre solo los nombres de los clientes.
USE [luismiguelcasado];
GO
SELECT Nombre FROM [dbo].[Clientes];
-- 3 - Haz una consulta que muestre los 3 primeros registros (TOP N) de la tabla Cliente 
--     y que los ordene por fecha de nacimiento de forma ascendente.
USE [luismiguelcasado];
GO
DECLARE @top3 TABLE (
	[idCliente] [INT] NOT NULL,
	[Nombre] [VARCHAR](50) NOT NULL,
	[Apellido] [VARCHAR](50) NOT NULL,
	[Fnacimiento] [DATE] NOT NULL,
	[Domicilio] [VARCHAR](50) NOT NULL,
	[idPais] CHAR(3) NOT NULL,
	[Telefono] [VARCHAR](12) NULL,
	[Email] [VARCHAR](30) NOT NULL,
	[Observaciones] [varchar](1000) NULL,
	[FechaAlta] [DATETIME] NOT NULL
);
INSERT INTO @top3(
	[idCliente],
	[Nombre],
	[Apellido],
	[Fnacimiento],
	[Domicilio],
	[idPais],
	[Telefono],
	[Email],
	[Observaciones],
	[FechaAlta])
	SELECT TOP 3 * FROM [dbo].[Clientes];
SELECT * FROM @top3 ORDER BY Fnacimiento;

-- 4 - Haz una consulta que muestre los idPais distintos por Cliente.
USE [luismiguelcasado];
GO
SELECT DISTINCT [idPais] FROM [dbo].[Clientes] ORDER BY [idPais];
-- 5 - Haz una sentencia que modifique el Email del primer registro 
--     de tu tabla de clientes. 
--     El nuevo Email es 200@gmail.es
--     Utiliza UPDATE…..SET……WHERE…..
USE [luismiguelcasado];
GO
UPDATE [dbo].[Clientes] SET [Email] = '200@gmail.es' WHERE [idCliente] = 6;
-- 6 - Realiza un promedio del campo monto de la tabla Compra.
USE [luismiguelcasado];
GO
SELECT AVG([monto]) FROM [dbo].[Compra];
--7 - Haz una consulta que te muestre los datos de la tabla HoraCaptacion 
--	filtrados por fechas entre el 2024-01-01 y el 2024-01-30.
--	Debes utilizar el operador BETWEEN.
USE [luismiguelcasado];
GO
SELECT * FROM [dbo].[HoraCaptacion] WHERE CONVERT(CHAR(8), [FechaCaptacion], 112) BETWEEN '20240101' AND '20240130';
-- 8 - Crea una consulta if que te devuelva los registros de nacionalidad española de la tabla Cliente.
USE [luismiguelcasado];
GO
DECLARE @nacionalidad CHAR(3) = 'ESP';
IF EXISTS (SELECT TOP 1 [idPais] FROM [dbo].[Clientes] WHERE [idPais] = @nacionalidad)
	SELECT * FROM [dbo].[Clientes] WHERE [idPais] = @nacionalidad;
ELSE
	PRINT 'No hay registros con el [idPais] = ''' +@nacionalidad+''' en la tabla [Clientes]';
-- 9 - Crea una consulta “CONDICIONAL CASE” que te devuelva un campo llamado continente con los
-- continentes de los países de la tabla Pais.
USE [luismiguelcasado];
GO
SELECT	[idPais], 
		[NombrePais], 
		Continente = CASE
		WHEN [idPais] IN('DEU', 'ESP', 'GRC') THEN 'Europe'
		WHEN [idPais] IN('MEX', 'USA') THEN 'North America'
		WHEN [idPais] = 'BRA' THEN 'South America'
		WHEN [idPais] = 'IND' THEN 'Asia'
		ELSE 'Pais desconocido'
		END
		FROM [dbo].[Pais];
-- 10 - Crea un Stored procedure para insertar nuevos clientes en la tabla Clientes
--• Añade el campo DNI al igual que en el ejercicio del curso (los registros anteriores
--quedaran en blanco o nulos).
--• El stored procedure debe ejecutarse con la siguiente expresión:
--EXEC Nuevo_cliente '23513165', 'Raúl','Stuart','19850521','Las regasta 25','ESP','655821547','Raul@krokimail.com',''
--Ten en cuenta la información que te entrega la expresión anterior, por ejemplo, el nombre de la tabla de
--debes usar.
USE [luismiguelcasado];
GO
ALTER TABLE [dbo].[CLientes] ADD dni VARCHAR(20);
GO
CREATE PROCEDURE Nuevo_cliente (
	@dni VARCHAR(20),
	@nom VARCHAR(50),
	@ape VARCHAR(50),
	@fNa date,
	@dom VARCHAR(50),
	@pais CHAR(3),
	@tel VARCHAR(12),
	@mail VARCHAR(30),
	@obs VARCHAR(1000))
AS
BEGIN
	IF EXISTS(SELECT [idCliente] FROM [dbo].[Clientes] WHERE [dni] = @dni)
		PRINT 'Ya existe un cliente con dni '+ @dni +' en [dbo].[Clientes]. No se insertan datos'
	ELSE
		IF NOT EXISTS (SELECT TOP 1 [idPais] FROM [dbo].[Pais] WHERE [idPais] = @pais)
			PRINT 'El codigo de país ''' + @pais + ''' No existe en la tabla [dbo].[pais].';
		ELSE
			INSERT INTO [dbo].[Clientes] VALUES (@nom, @ape, @fNa, @dom, @pais, @tel, @mail, @obs, GETDATE(), @dni);
END
#fin ejercicio V