# Trabalho HIVE Parte 1:

Para aumentar a memória do container para o Hive não morrer, se necessário:

docker update --memory=4g --memory-swap=6g hive-server (opcional)

Dentro do namenode:
```
mkdir /data_processing/csv/

hadoop fs -mkdir /atividade_2/
hadoop fs -mkdir /atividade_2/address/
hadoop fs -mkdir /atividade_2/customer/
hadoop fs -mkdir /atividade_2/customeraddress/
hadoop fs -mkdir /atividade_2/product/
hadoop fs -mkdir /atividade_2/productcategory/
hadoop fs -mkdir /atividade_2/productdescription/
hadoop fs -mkdir /atividade_2/productmodel/
hadoop fs -mkdir /atividade_2/productmodeldescription/
hadoop fs -mkdir /atividade_2/salesorderdetail/
hadoop fs -mkdir /atividade_2/salesorderhead/
```
----------------------------------------------
Dentro do hive-server:

- Criar Database AdventureWorks
```
create database if not exists AdventureWorks location '/atividade_2/';
```

----------------------------------------------
Novamente no namenode:

- Executar o shellscript para carregar os dados para o HDFS:
```
chmod 777 uploadCsv_HDFS.sh
./uploadCsv_HDFS.sh
```
![image](https://user-images.githubusercontent.com/13857701/236688544-2588fe2d-8fe1-456d-bec7-2fe61dd091f9.png)

----------------------------------------------
Novamente no hive-server:

- Criar as tabelas com os dados do HDFS no Hive:
```
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
```

- Consultar dados sobre Pessoas e “serviços” consumidos:
```
SELECT c.salesperson as Pessoa, sd.salesorderdetailid as Servico
FROM salesorderhead so
INNER JOIN salesorderdetail sd ON so.salesorderid = sd.salesorderid
INNER JOIN customer c ON so.customerid = c.customerid;
```
<img src="https://user-images.githubusercontent.com/13857701/236688412-9c4078e2-d2ee-423e-8e22-3c151bcc475c.png" width=90% height=90%>

- Criar uma tabela com a visão dos tipos de serviço/Aventura contratados agregados:
```
CREATE TABLE servico_contratados as
SELECT p.productnumber as numero_produto,sd.orderqty as Quantidade, p.listprice as preco_unidade, sd.unitpricediscount as Desconto,
pm.catalogdescription as Descricao
FROM salesorderdetail sd
INNER JOIN product p ON sd.productid = p.productid
INNER JOIN productmodel pm ON p.productmodelid = pm.productmodelid;
```
<img src="https://user-images.githubusercontent.com/13857701/236691764-daf52d81-7dd9-4532-8831-f62ce140c735.png" width=90% height=90%>

- Criar uma tabela com dados para seguimentação e analíse dos clients:
```
CREATE TABLE analise_cliente as
SELECT c.salesperson as Pessoa, c.companyname as Companhia, a.city as Cidade FROM customeraddress ca
INNER JOIN customer c ON ca.customerid = c.customerid
INNER JOIN address a ON ca.addressid = a.addressid;
```
<img src="https://user-images.githubusercontent.com/13857701/236688333-08307f16-5284-43b6-b27c-44211826056a.png" width=90% height=90%>


![image](https://user-images.githubusercontent.com/13857701/236692480-7d104f36-ddb7-4669-934a-841fe36605e7.png)


----------------------------------------------

# Trabalho HIVE Parte 2:

- Criar diretorio HDFS para as partições e comando HIVE para habilitar partição dinâmica:
```
hadoop fs -mkdir /atividade_2/flatenned/

SET hive.exec.dynamic.partition = true;
SET hive.exec.dynamic.partition.mode = nonstrict;
```

- Criar a flattened table com partição pelas cores do produto e mês:
```
CREATE TABLE flatenned_table
(productnumber string, standardcost float, listprice float, orderqty int, shipmethod string, taxamt float, freight float)
PARTITIONED BY (modifieddate int,color string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/atividade_2/flatenned/';
```

- Inserir os dados na tabela através de um conjunto de selects nas tabelas criadas anteriormente com os registros relevantes para o monitoramento do negócio (KPIs)Ç
```
INSERT INTO flatenned_table
PARTITION(modifieddate, color)
SELECT p.productnumber, p.standardcost, p.listprice, sd.orderqty, sh.shipmethod, sh.taxamt, sh.freight,
month(date_format(from_unixtime(unix_timestamp(p.modifieddate, 'dd-MM-yyyy')),'yyyy-MM-dd')) as modifieddate , p.color as color
FROM salesorderhead sh
INNER JOIN salesorderdetail sd ON sh.salesorderid = sd.salesorderid
INNER JOIN product p ON sd.productid = p.productid;
```
![image](https://user-images.githubusercontent.com/13857701/236702185-b31fbbe7-3c47-4d4b-93c4-bc45a29b1a3d.png)

Flatenned Table:
<img src="https://user-images.githubusercontent.com/13857701/236701194-fdb8f23b-3f2f-4109-9f43-116923f48ad8.png" width=90% height=90%>

-  Justificativa das técnicas utilizadas para otimizar o modelo:

Utilizamos as tabelas salesorderhead, salesorderdetail e product como nossos KPIs para a montagem da flatenned table, pois nelas existem informações relevants sobre os produtos assim como o preços dos produtos (preço de fabrica, preço de venda, tarifas, fretes, etc..), a quantidade comprada de cada um e características do produto.

Partição:

Utilizamos a cor do produto e o mês para organizar os diretórios, logo teremos uma estrutura onde podemos identificar os produtos vendidos através da cor mensalmente e acessar os detalhes do produto como os preços.
