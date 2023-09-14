--** CUSTOMER SPENDING SCRIPT**--

USE [AdventureWorks2019]

--select all tables from tables system database
SELECT *
FROM INFORMATION_SCHEMA.TABLES

--selecting base tables
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' -- there are 71 base tables 

--selecting view tables
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'view' -- there are 20 views


/*--retriving tables for analysis*/


SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('Person','vPersonDemographics','SalesOrderDetail','SalesOrderHeader','Customer','Product','ProductCategory','ProductSubcategory')
-- 8 tables will be used for analysis

-- deterimining data types in selected 8 tables
SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Person'

SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'vPersonDemographics'

SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesOrderDetail'

SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SalesOrderHeader'

SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Customer'

SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Product'

SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ProductCategory'

SELECT COLUMN_NAME
		,DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ProductSubCategory'


--- Glimpse of tables selected
SELECT TOP (1000) *
FROM [AdventureWorks2019].[Person].[Person]

SELECT TOP (1000) *
FROM [AdventureWorks2019].[Sales].[vPersonDemographics]

SELECT TOP (1000) *
FROM [AdventureWorks2019].[Sales].[SalesOrderDetail]

SELECT TOP (1000) *
FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]

SELECT TOP (1000) *
FROM [AdventureWorks2019].[Sales].[Customer]

SELECT TOP (1000) *
FROM [AdventureWorks2019].[Production].[Product]

SELECT TOP (1000) *
FROM [AdventureWorks2019].[Production].[ProductCategory]

SELECT TOP (1000) *
FROM [AdventureWorks2019].[Production].[ProductSubcategory]


--checking for duplicates. 


-- if total number of observations is equal to total number of distinct observations then there is no duplicates
SELECT COUNT (*) AS number_of_observation
FROM
	[AdventureWorks2019].[Person].[Person] ---total number of observations

SELECT DISTINCT
	[BusinessEntityID]
	,[PersonType]
	,[FirstName]
	,[LastName]
FROM
	[AdventureWorks2019].[Person].[Person] ---total number of distinct observations


SELECT COUNT (*) AS number_of_observation
FROM
	[AdventureWorks2019].[Sales].[vPersonDemographics]

SELECT DISTINCT
	[BusinessEntityID]
    ,[BirthDate]
    ,[MaritalStatus]
    ,[YearlyIncome]
    ,[Gender]
    ,[TotalChildren]
    ,[Education]
    ,[Occupation]
	,[NumberCarsOwned]
FROM 
	[AdventureWorks2019].[Sales].[vPersonDemographics]


SELECT COUNT (*) AS number_of_observations
FROM
	[AdventureWorks2019].[Sales].[SalesOrderDetail]

SELECT DISTINCT 
	[SalesOrderID]
    ,[OrderQty]
    ,[ProductID]
    ,[UnitPrice]
    ,[UnitPriceDiscount]
    ,[LineTotal]
FROM
	[AdventureWorks2019].[Sales].[SalesOrderDetail]


SELECT COUNT (*) as number_of_observations
FROM
	[AdventureWorks2019].[Sales].[SalesOrderHeader]

SELECT DISTINCT
	[SalesOrderID]
    ,[OrderDate]
    ,[CustomerID]
    ,[SubTotal]
    ,[TaxAmt]
    ,[Freight]
    ,[TotalDue]
FROM 
	[AdventureWorks2019].[Sales].[SalesOrderHeader]


SELECT COUNT (*) AS number_of_observation
FROM
	[AdventureWorks2019].[Sales].[Customer]

SELECT DISTINCT
	[CustomerID]
	,[PersonID]
FROM 
	[AdventureWorks2019].[Sales].[Customer]


SELECT COUNT (*) AS number_of_observation
FROM
	[AdventureWorks2019].[Production].[Product]

SELECT DISTINCT 
	[ProductID]
	,[Name]
	,[FinishedGoodsFlag]
	,[ListPrice]
	,[ProductSubcategoryID]
FROM 
	[AdventureWorks2019].[Production].[Product]


SELECT COUNT (*) AS number_of_observation
FROM
	[AdventureWorks2019].[Production].[ProductCategory]

SELECT DISTINCT 
	[ProductCategoryID]
	,[Name]
FROM
	[AdventureWorks2019].[Production].[ProductCategory]


SELECT COUNT (*) AS number_of_observation
FROM
	[AdventureWorks2019].[Production].[ProductSubcategory]

SELECT DISTINCT
	[ProductSubcategoryID]
	,[ProductCategoryID]
	,[Name]
FROM 
	[AdventureWorks2019].[Production].[ProductSubcategory]


---CREATING VIEWS---


CREATE VIEW person	
           (Business_EntityID, 
			Person_Type, 
			Name)
AS
	SELECT  BusinessEntityID, 
		PersonType, CONCAT(FirstName,' ',LastName) Name
	FROM 
		[AdventureWorks2019].[Person].[Person]

CREATE VIEW Order_Details
	(Order_ID, Order_DetailID, 
	Order_Qty, Product_ID, 
	Unit_Price, 
	Unit_Price_Discount, 
	Line_Total)
AS 
	SELECT SalesOrderID,
			SalesOrderDetailID,
			OrderQty,ProductID,
			UnitPrice,
			UnitPriceDiscount,
			LineTotal
	FROM 
		[AdventureWorks2019].[Sales].[SalesOrderDetail]

CREATE VIEW Orders
	(Order_ID, 
	Order_Date, 
	Due_Date, Ship_Date, 
	Customer_ID, 
	Sub_Total, 
	Tax_Amount, 
	Freight, 
	Total_Due)
AS
	SELECT 
		SalesOrderID,
		CONVERT(date,OrderDate) as Order_Date, 
		CONVERT(date,DueDate) as Due_Date, 
		CONVERT(date,ShipDate) as Ship_Date, 
		CustomerID,
		SubTotal,
		TaxAmt,
		Freight,
		TotalDue
	FROM 
		[AdventureWorks2019].[Sales].[SalesOrderHeader]

CREATE VIEW customers
	(Customer_ID, 
	Person_ID) 
AS
	SELECT CustomerID, 
			PersonID
	FROM 
			[AdventureWorks2019].[Sales].[Customer]

CREATE VIEW product
	(Product_ID,
	Product_Name,
	Standard_Cost,
	List_Price,
	Product_Line,
	Style,
	Product_Subcategory_ID)
AS
	SELECT ProductID,
			Name,
			StandardCost,
			ListPrice,
			ProductLine,
			Style,
			ProductSubcategoryID
	FROM 
		[AdventureWorks2019].[Production].[Product]
	WHERE 
		FinishedGoodsFlag = 1

CREATE VIEW Product_Category
	(Category_ID, 
	Category_Name)
AS
	SELECT ProductCategoryID,
			Name
	FROM 
		[AdventureWorks2019].[Production].[ProductCategory]

CREATE VIEW Sub_Category
	(Sub_Category_ID, 
	Category_ID, 
	Subcategory_Name)
AS
	SELECT ProductSubcategoryID,
			ProductCategoryID,
			Name
	FROM 
		[AdventureWorks2019].[Production].[ProductSubcategory]













