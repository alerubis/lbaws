# Comandi utili

## Build immagine
docker build -t lba -f Dockerfile ..

## Esporta immagine in tar
docker save lba:latest -o lba.tar

## Load su un altro host
docker load -i lba.tar

## Avvia più container su porte diverse
docker run -d --name cliente1 -p 9000:8080 -e SECRET='ktbgMOIkpcINpkZxSsh07APgr4ufr2mxz6SmNoq4Ics=' -e DATABASE_URL='mysql://docker:MyS3cur3_Pass!@172.17.0.1:3306/lba' lba
docker run -d --name cliente2 -p 9001:8080 -e SECRET='ktbgMOIkpcINpkZxSsh07APgr4ufr2mxz6SmNoq4Ics=' -e DATABASE_URL='mysql://docker:MyS3cur3_Pass!@172.17.0.1:3306/lba_cliente2' lba

## Vedere i log
docker logs cliente1
docker logs cliente1 > logs.txt

## Entrare nel docker
docker exec -it cliente1 sh

# Microsoft Azure

## Connessione alla vm
ssh -i /home/alessio-rubis/Projects/kiddo/kiddo-virtual-machine_key.pem azureuser@52.236.37.78

## Copia tar con rsync
rsync -avz -e "ssh -i /home/alessio-rubis/Projects/kiddo/kiddo-virtual-machine_key.pem" /home/alessio-rubis/Projects/lba/lbaws/lba.tar azureuser@52.236.37.78:/home/azureuser/

## Load tar
sudo docker load -i lba.tar

## Reload
sudo docker stop lba
sudo docker rm lba
sudo docker run -d --name lba -p 9100:8080 -e SECRET='ktbgMOIkpcINpkZxSsh07APgr4ufr2mxz6SmNoq4Ics=' -e DATABASE_URL='mysql://kiddo:Kiddo!2025@kiddo-mysql-server-italy.mysql.database.azure.com:3306/lba' lba
