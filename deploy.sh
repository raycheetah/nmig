#!/bin/bash
export NAMESPACE=twm-cloud
export NAMEPATH=twmcloud
export API_VERSION=v1
export APPNAME=migrate
export NAME=${APPNAME}-${API_VERSION}
export PORT=80
export IMAGE_SERVER=harbor.metaage.com.tw/${NAMEPATH}/${APPNAME}
export VERSION=20250401
export IMAGE=$IMAGE_SERVER:$VERSION
export pgsql_host=192.168.30.170
export pgsql_port=5432
export pgsql_db=twm_cloud
export pgsql_user=postgres
export pgsql_password=Ab123456
export mysql_host=192.168.30.170
export mysql_port=3306
export mysql_db=twm_cloud
export mysql_user=root
export mysql_password=Ab123456

docker rmi $IMAGE
docker build --build-arg pgsql_host=${pgsql_host} \
             --build-arg pgsql_port=${pgsql_port} \
             --build-arg pgsql_db=${pgsql_db} \
             --build-arg pgsql_user=${pgsql_user} \
             --build-arg pgsql_password=${pgsql_password} \
             --build-arg mysql_host=${mysql_host} \
             --build-arg mysql_port=${mysql_port} \
             --build-arg mysql_db=${mysql_db} \
             --build-arg mysql_user=${mysql_user} \
             --build-arg mysql_password=${mysql_password} \
             -t $IMAGE .
docker push $IMAGE

envsubst < template.yaml > job.yaml
#kubectl apply -f deploy.yaml
#\rm deploy.yaml
