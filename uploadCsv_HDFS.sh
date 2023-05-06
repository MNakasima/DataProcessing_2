#!/bin/bash

#Baixa os arquivos e joga pra pasta /data_processing/csv/
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1K0uYlD9En3hP2u7e1cCLgF_gBydilDWI&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1x6GuS7pq2M_pqv1s0CIP6qiGXZaEjeZd&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1EwXN_iNohdnpgw-CogzeNNXpFp_ZwwYu&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1Ybxo4GB7v73d1qacgVtCwnfSaQkQCOxS&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1ChW5hfwmD4l6llZIeLesvVZLUr9BnGu9&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1AKgHJ1InA7YAAFwQNGhwY29kiL34L7bc&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=11bDt7PGrVfdhJZRIeOLgrqLUXf2opUqF&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=18YskJR7QaZPPbt6uBNN48eGQNYbUYGpB&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1j0i4sGBuY996uC8qcS8ZZvLTBN2YqK6a&export=download
wget -P /data_processing/csv/ --content-disposition https://drive.google.com/uc?id=1xiR-JmKVcL2r4EJkrJ-mqd8HInLdqasa&export=download

export err=$?

if [ "$err"="0" ]; then

 hadoop fs -put /data_processing/csv/* /atividade_2/

 echo "Sucesso"
 exit 0
else
 echo "Falha"
 exit 1
fi