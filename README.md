
docker ps -a
"Sirve para ver los contenedores"

Levantar servicios con docker-compose (en la carpeta con docker-compose.yml):

cd /home/anderson-coello/replica-mysql

docker compose up -d
para levantar el docker

docker compose down
para apagar el docker


Parar un contenedor:
docker stop mysql_master
docker stop mysql_slave

Listar volúmenes:
docker volume ls


B. Conectar al servidor MySQL (CLI)
Conectar al master (puerto 3307):

mysql -h 127.0.0.1 -P 3307 -u root -p
password: root1234


C. Conectar al slave (puerto 3308):
mysql -h 127.0.0.1 -P 3308 -u root -p
password: root1234

Comandos MySQL para replicación y verificación
Ver estado del master:

SHOW MASTER STATUS\G
