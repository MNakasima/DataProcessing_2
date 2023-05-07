create external table address 
(AddressID int, AddressLine1 string, AddressLine2 string, City string, PostalCode string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/address/';

create external table customer 
(CustomerID int, Title string, Suffix string, CompanyName string, SalesPerson string, EmailAddress string, PasswordHash string, 
PasswordSalt string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/customer/';

create external table customeraddress 
(CustomerID int, AddressID int, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/customeraddress/';

create external table product 
(ProductID int, ProductNumber string, Color string, StandardCost float, ListPrice float, Size int, Weight int, ProductCategoryID int, 
ProductModelID int, SellStartDate string, SellEndDate string, DiscontinuedDate string, ThumbNailPhoto string, 
ThumbnailPhotoFileName string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/product/';

create external table productcategory 
(ProductCategoryID int, ParentProductCategoryID int, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/productcategory/';

create external table productdescription 
(ProductDescriptionID int, Description string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/productdescription/';

create external table productmodel 
(ProductModelID int, CatalogDescription string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/productmodel/';

create external table productmodeldescription 
(ProductModelID int, ProductDescriptionID int, Culture string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/productmodeldescription/';

create external table salesorderdetail 
(SalesOrderID int, SalesOrderDetailID int, OrderQty int, ProductID int, UnitPrice float, UnitPriceDiscount float, 
LineTotal string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/salesorderdetail/';

create external table salesorderhead 
(SalesOrderID int, RevisionNumber int, OrderDate string, DueDate string, ShipDate string, Status string, SalesOrderNumber string, 
CustomerID int, ShipToAddressID int, BillToAddressID int, ShipMethod string, CreditCardApprovalCode int, SubTotal float, 
TaxAmt float, Freight float, TotalDue float, Comment string, rowguid string, ModifiedDate string) 
row format delimited fields terminated by ';' 
location '/atividade_2/salesorderhead/';