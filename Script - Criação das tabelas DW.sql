CREATE TABLE [dbo].[DimCustomer](
	[IDSK] [int] PRIMARY KEY IDENTITY NOT NULL,
	[CustomerID] [int] NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[Suffix] [nvarchar](10) NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[AddressLine1] [nvarchar](120) NULL,
	[AddressLine2] [nvarchar](120) NULL,
	[AddressType] [nvarchar](60) NULL,
	[City] [nvarchar](40) NULL,
	[StateProvince] [nvarchar](60) NULL,
	[CountryRegion] [nvarchar](60) NULL,
	[PostalCode] [nvarchar](20) NULL,
	[Phone] [nvarchar](30) NULL,
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL

) ON [PRIMARY];
GO


--/////////////////////////////////////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[DimCategory](
	[CategoryID] [int] PRIMARY KEY,
	[CategoryName] [nvarchar](60) NULL,
) ON [PRIMARY];
GO


--////////////////////////////////////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[DimProduct](
	[IDSK] [int] PRIMARY KEY IDENTITY NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](60) NULL,
	[ProductNumber] [nvarchar](30) NULL,
	[ProductColor] [nvarchar](20) NULL,
	[Size] [nvarchar](10) NULL,
	[Weight] [float] NULL,
	[ModelName] [nvarchar](50) NULL,
	[StandardCost] [money] NULL,
	[ListPrice] [money] NULL,	
	[BeginDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[CategoryID] [int] NULL,
	FOREIGN KEY(CategoryID) REFERENCES
	 [DimCategory](CategoryID)
) ON [PRIMARY];
GO

--////////////////////////////////////////////////////////////////////////////////////////////


CREATE TABLE [dbo].[DimTEMPO](
	[IDSK] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[DATA] [date] NULL,
	[DIA] [char](2) NULL,
	[DIASEMANA] [varchar](10) NULL,
	[MES] [char](2) NULL,
	[NOMEMES] [varchar](10) NULL,
	[TRIMESTRE] [tinyint] NULL,
	[NOMETRIMESTRE] [varchar](10) NULL,
	[ANO] [char](4) NULL,
	[ESTACAOANO] [varchar](20) NULL,
	[FIMSEMANA] [char](3) NULL,
	[DATACOMPLETA] [varchar](10) NULL
) ON [PRIMARY]
GO

--/////////////////////////////////////////////////////////////////////////////////////////////

CREATE TABLE [dbo].[FTSales](
	[CustomerKey] [int] NOT NULL REFERENCES [dbo].[DimCustomer](IDSK),
	[ProductKey] [int] NOT NULL REFERENCES [dbo].[DimProduct](IDSK),
	[CalendarKey] [int] NOT NULL REFERENCES [dbo].[DimTempo](IDSK),
	[OrderDateKey] [int] NOT NULL,
	[DueDateKey] [int] NOT NULL,
	[SalesOrderNumber] [nvarchar](30) NOT NULL,
	[RevisionNumber] [tinyint] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[UnitPriceDiscount] [money] NOT NULL,
	[DiscountAmount] [float] NOT NULL,
	[ProductStandardCost] [money] NOT NULL,
	[SalesAmount] [money] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NOT NULL
) ON [PRIMARY];
GO