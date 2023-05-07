CREATE TABLE flatenned_table
(productnumber string, standardcost float, listprice float, orderqty int, shipmethod string, taxamt float, freight float)
PARTITIONED BY (modifieddate int,color string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/atividade_2/flatenned/';

INSERT INTO flatenned_table
PARTITION(modifieddate, color)
SELECT p.productnumber, p.standardcost, p.listprice, sd.orderqty, sh.shipmethod, sh.taxamt, sh.freight,
month(date_format(from_unixtime(unix_timestamp(p.modifieddate, 'dd-MM-yyyy')),'yyyy-MM-dd')) as modifieddate , p.color as color
FROM salesorderhead sh
INNER JOIN salesorderdetail sd ON sh.salesorderid = sd.salesorderid
INNER JOIN product p ON sd.productid = p.productid;
