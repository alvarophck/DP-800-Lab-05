CREATE SCHEMA Security;
GO

CREATE FUNCTION Security.fn_RegionFilter(@SalesRegion nvarchar(20))
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS AccessGranted
    WHERE @SalesRegion =
        CASE USER_NAME()
            WHEN 'WestSalesRep' THEN 'West'
            WHEN 'EastSalesRep' THEN 'East'
            ELSE @SalesRegion
        END
       OR IS_MEMBER('db_owner') = 1;
GO

CREATE SECURITY POLICY CustomerRegionPolicy
ADD FILTER PREDICATE Security.fn_RegionFilter(SalesRegion)
    ON dbo.Customers
WITH (STATE = ON);
