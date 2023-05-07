CREATE TABLE servico_contratados as
SELECT p.productnumber as numero_produto,sd.orderqty as Quantidade, p.listprice as preco_unidade, sd.unitpricediscount as Desconto,
pm.catalogdescription as Descricao
FROM salesorderdetail sd
INNER JOIN product p ON sd.productid = p.productid
INNER JOIN productmodel pm ON p.productmodelid = pm.productmodelid;

CREATE TABLE analise_cliente as
SELECT c.salesperson as Pessoa, c.companyname as Companhia, a.city as Cidade FROM customeraddress ca
INNER JOIN customer c ON ca.customerid = c.customerid
INNER JOIN address a ON ca.addressid = a.addressid;
