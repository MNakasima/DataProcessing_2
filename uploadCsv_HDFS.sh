#!/bin/bash

#Baixa os arquivos e joga pra pasta /data_processing/csv/ (o content disposition esta pegando o nome duplicado, por isso esta assim o nome do arquivo)
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1K0uYlD9En3hP2u7e1cCLgF_gBydilDWI&export=download
hadoop fs -put /data_processing/csv/address.csvaddress.csv /atividade_2/address/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1x6GuS7pq2M_pqv1s0CIP6qiGXZaEjeZd&export=download
hadoop fs -put /data_processing/csv/customer.csvcustomer.csv /atividade_2/customer/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1EwXN_iNohdnpgw-CogzeNNXpFp_ZwwYu&export=download
hadoop fs -put /data_processing/csv/customeraddress.csvcustomeraddress.csv /atividade_2/customeraddress
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1Ybxo4GB7v73d1qacgVtCwnfSaQkQCOxS&export=download
hadoop fs -put /data_processing/csv/product.csvproduct.csv /atividade_2/product/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1ChW5hfwmD4l6llZIeLesvVZLUr9BnGu9&export=download
hadoop fs -put /data_processing/csv/productcategory.csvproductcategory.csv /atividade_2/productcategory/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1AKgHJ1InA7YAAFwQNGhwY29kiL34L7bc&export=download
hadoop fs -put /data_processing/csv/productdescription.csvproductdescription.csv /atividade_2/productdescription/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=11bDt7PGrVfdhJZRIeOLgrqLUXf2opUqF&export=download
hadoop fs -put /data_processing/csv/productmodel.csvproductmodel.csv /atividade_2/productmodel/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=18YskJR7QaZPPbt6uBNN48eGQNYbUYGpB&export=download
hadoop fs -put /data_processing/csv/productmodeldescription.csvproductmodeldescription.csv /atividade_2/productmodeldescription/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1j0i4sGBuY996uC8qcS8ZZvLTBN2YqK6a&export=download
hadoop fs -put /data_processing/csv/salesorderdetail.csvsalesorderdetail.csv /atividade_2/salesorderdetail/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1xiR-JmKVcL2r4EJkrJ-mqd8HInLdqasa&export=download
hadoop fs -put /data_processing/csv/salesorderhead.csvsalesorderhead.csv /atividade_2/salesorderhead/

export err=$?

if [ "$err"="0" ]; then
 echo "Sucesso"
 exit 0
else
 echo "Falha"
 exit 1
fi
