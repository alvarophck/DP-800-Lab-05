EXECUTE AS USER = 'WestSalesRep';
SELECT * FROM dbo.Customers;
REVERT;

EXECUTE AS USER = 'EastSalesRep';
SELECT * FROM dbo.Customers;
REVERT;

SELECT * FROM dbo.Customers;
