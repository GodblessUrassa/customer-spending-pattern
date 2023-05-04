--** CUSTOMER SPENDING ANALYSIS**--

--select all tables from tables system database

SELECT *
FROM INFORMATION_SCHEMA.TABLES

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE' -- there are 71 base tables 

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'view' -- there are 20 views


-- customer spending analysis will be divided into two segments, analysis basing on customer demographics and their purchase history
-- Select tables with customer demographics and purchase history data

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('Person','vPersonDemographics','SalesOrderDetail','SalesOrderHeader','Customer','Product','ProductCategory','ProductSubcategory')

-- deterimine data types in selected tables

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

-- Glimpse of tables selected

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


--** DATA CLEANING--

--checking for duplicates. 
-- if total number of observations is equal to total number of distinct observations then there is no duplicates

SELECT COUNT (*)
FROM
	[AdventureWorks2019].[Person].[Person] ---total number of observations

SELECT DISTINCT
	[BusinessEntityID]
	,[PersonType]
	,[FirstName]
	,[LastName]
FROM
	[AdventureWorks2019].[Person].[Person] ---total number of distinct observations


SELECT COUNT (*)
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


SELECT COUNT (*)
FROM
	[AdventureWorks2019].[Sales].[Customer]

SELECT DISTINCT
	[CustomerID]
	,[PersonID]
FROM 
	[AdventureWorks2019].[Sales].[Customer]


SELECT COUNT (*)
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


SELECT COUNT (*)
FROM
	[AdventureWorks2019].[Production].[ProductCategory]

SELECT DISTINCT 
	[ProductCategoryID]
	,[Name]
FROM
	[AdventureWorks2019].[Production].[ProductCategory]


SELECT COUNT (*)
FROM
	[AdventureWorks2019].[Production].[ProductSubcategory]

SELECT DISTINCT
	[ProductSubcategoryID]
	,[ProductCategoryID]
	,[Name]
FROM 
	[AdventureWorks2019].[Production].[ProductSubcategory]

--- Generally, there are no duplicates in all tables.

---checking for NULLs

SELECT
	[BusinessEntityID]
	,[PersonType]
	,[FirstName]
	,[LastName]
FROM 
	[AdventureWorks2019].[Person].[Person] 
WHERE
	[BusinessEntityID] is null or [PersonType] is null or [FirstName] is null or [LastName] is null --checking for nulls


SELECT 
	[BusinessEntityID]
	,[BirthDate]
	,[MaritalStatus]
	,[YearlyIncome]
	,[Gender]
	,[NumberChildrenAtHome]
	,[Education]
	,[Occupation]
	,[NumberCarsOwned]
FROM 
	[AdventureWorks2019].[Sales].[vPersonDemographics]
WHERE 
	[BusinessEntityID] is null or [BirthDate] is null or [MaritalStatus] is null or [YearlyIncome] is null or [Gender] is null or [Education] is null or [Occupation] is null or [NumberCarsOwned] is null
----there are 1488 null observations


SELECT
	[SalesOrderID]
	,[SalesOrderDetailID]
	,[OrderQty]
	,[ProductID]
	,[UnitPrice]
	,[UnitPriceDiscount]
	,[LineTotal]
FROM
	[AdventureWorks2019].[Sales].[SalesOrderDetail]
WHERE
	[SalesOrderID] is null or [SalesOrderDetailID] is null or [OrderQty] is null or [ProductID] is null or [UnitPrice] is null or [UnitPriceDiscount] is null or [LineTotal] is null 


SELECT 
	[SalesOrderID]
	,[OrderDate]
	,[DueDate]
	,[ShipDate]
	,[CustomerID]
	,[SubTotal]
	,[TaxAmt] 
	,[Freight]
	,[TotalDue]
FROM 
	[AdventureWorks2019].[Sales].[SalesOrderHeader]
WHERE 
	[SalesOrderID] is null or [OrderDate] is null or [DueDate] is null or [ShipDate] is null or [CustomerID] is null or [SubTotal] is null or [TaxAmt] is null or [Freight] is null or [TotalDue] is null 


SELECT 
	[CustomerID]
	,[PersonID]
FROM 
	[AdventureWorks2019].[Sales].[Customer]
WHERE 
	[CustomerID] is null or [PersonID] is null
--- person ID column has 701 null observations


SELECT 
	[ProductID]
	,[Name]
	,[FinishedGoodsFlag]
	,[ListPrice]
	,[ProductSubcategoryID]
FROM 
	[AdventureWorks2019].[Production].[Product]
WHERE
	[ProductID] is null or [Name] is null or [FinishedGoodsFlag] is null or [ListPrice] is null or [ProductSubcategoryID] is null 
  --- [ProductSubcategoryID] have 209 nulls 


--** DATA TRANSFORMATION **---

--joining person table with demographics , customer, and sales order header tables
SELECT 
	P.[BusinessEntityID]
	,[PersonType]
	,[FirstName]
	,[LastName]
	,[BirthDate]
	,[MaritalStatus]
	,[YearlyIncome]
	,[Gender]
	,[TotalChildren]
    ,[Education]
    ,[Occupation]
	,[NumberCarsOwned]
	,[SalesOrderID]
	,C.[CustomerID]
	,[PersonID]
	,[TotalDue]
FROM 
	[AdventureWorks2019].[Person].[Person] AS P
		LEFT JOIN [AdventureWorks2019].[Sales].[vPersonDemographics] AS D ---- joining person and person demographic table
			ON P.BusinessEntityID = D.BusinessEntityID           
		LEFT JOIN [AdventureWorks2019].[Sales].[Customer] AS C          -------joining person and sales customer table
			ON P.BusinessEntityID = C.PersonID           
		LEFT JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader] AS S --------joining sales customer and sales order header table
			ON C.CustomerID = S.CustomerID           


SELECT *
INTO
	#Person_spending -----------creating temporary person_spending table
FROM
	(SELECT 
		P.[BusinessEntityID]
		,[PersonType]
		,[FirstName]
		,[LastName]
		,[BirthDate]
		,[MaritalStatus]
		,[YearlyIncome]
		,[Gender]
		,[TotalChildren]
		,[Education]
		,[Occupation]
		,[NumberCarsOwned]
		,[SalesOrderID]
		,C.[CustomerID]
		,[PersonID]
		,[TotalDue]
	FROM 
		[AdventureWorks2019].[Person].[Person] AS P
			LEFT JOIN [AdventureWorks2019].[Sales].[vPersonDemographics] AS D
				ON P.BusinessEntityID = D.BusinessEntityID
			LEFT JOIN [AdventureWorks2019].[Sales].[Customer] AS C
				ON P.BusinessEntityID = C.PersonID
			LEFT JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader] AS S
				ON C.CustomerID = S.CustomerID
	)m


---**Transforming temporary table #Person_spending

---Sell cheapy store have two types of customers individual customers (IN) and Store customers.
---person types employee non-sales, sales person, general contact and vendors don't purchase from the store 
---deleting rows with person type "EM" (Employee non-sales), "SP" (Sales person), "GC" (general contact), "VC" (vendor contact) which have NULLs

DELETE FROM 
	#Person_spending 
WHERE 
	PersonType IN ('EM','SP','GC','VC')

ALTER TABLE 
	#Person_spending  ----adding new column 'age' of customers
ADD age int

ALTER TABLE 
	#Person_spending  ----adding a new column 'birth_date' with date type
ADD Birth_date date

UPDATE #Person_spending
SET Birth_date = convert(date,[BirthDate])---updating birth_date column
FROM #Person_spending

UPDATE #Person_spending
SET age = DATEDIFF(year,Birth_date,'2014-12-30')---updating age column
FROM #Person_spending


SELECT
	[CustomerID]
	,Sales_Header.[SalesOrderID]
        ,[OrderDate]
	,category.Name as product_category
	,subcategory.[Name] as subcategory_name
	,product.[Name] as product_name
	,[FinishedGoodsFlag]
	,[OrderQty]
	,[UnitPrice]
	,[UnitPriceDiscount]
	,[ListPrice]
	,[LineTotal]
    ,[SubTotal]
    ,[Freight]
    ,[TotalDue]
    ,Sales_detail.[ProductID]
FROM
	[AdventureWorks2019].[Sales].[SalesOrderHeader] AS Sales_Header
		LEFT JOIN [AdventureWorks2019].[Sales].[SalesOrderDetail] AS Sales_detail        ----Joining [SalesOrderHeader] and [SalesOrderDetail] table
			ON Sales_Header.SalesOrderID = Sales_detail.SalesOrderID
		LEFT JOIN [AdventureWorks2019].[Production].[Product] AS product                -----joining [SalesOrderDetail] and product table
			ON Sales_detail.ProductID = Product.ProductID
		LEFT JOIN [AdventureWorks2019].[Production].[ProductSubcategory] AS subcategory -----joining product and [ProductSubcategory] table
			ON product.ProductSubcategoryID = subcategory.ProductSubcategoryID
		LEFT JOIN [AdventureWorks2019].[Production].[ProductCategory] AS category      ------joining [ProductSubcategory] and [ProductCategory] table
			ON subcategory.ProductCategoryID = category.ProductCategoryID


SELECT *
INTO #Product_sales   ----creating temporary table #Product_sales
FROM (
		SELECT
			[CustomerID]
			,Sales_Header.[SalesOrderID]
			,[OrderDate]
			,category.Name as product_category
			,subcategory.[Name] as subcategory_name
			,product.[Name] as product_name
			,[FinishedGoodsFlag]
			,[OrderQty]
			,[UnitPrice]
			,[UnitPriceDiscount]
			,[ListPrice]
			,[LineTotal]
			,[SubTotal]
			,[Freight]
			,[TotalDue]
			,Sales_detail.[ProductID]
		FROM
			[AdventureWorks2019].[Sales].[SalesOrderHeader] AS Sales_Header
				LEFT JOIN [AdventureWorks2019].[Sales].[SalesOrderDetail] AS Sales_detail
					ON Sales_Header.SalesOrderID = Sales_detail.SalesOrderID
				LEFT JOIN [AdventureWorks2019].[Production].[Product] AS product
					ON Sales_detail.ProductID = Product.ProductID
				LEFT JOIN [AdventureWorks2019].[Production].[ProductSubcategory] AS subcategory
					ON product.ProductSubcategoryID = subcategory.ProductSubcategoryID
				LEFT JOIN [AdventureWorks2019].[Production].[ProductCategory] AS category
					ON subcategory.ProductCategoryID = category.ProductCategoryID
	)m


-----Exported tables---------

SELECT *
FROM #Person_spending

SELECT *
FROM #Product_sales




