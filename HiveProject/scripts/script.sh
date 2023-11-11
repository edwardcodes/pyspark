
hdfs dfs -mkdir -p /user/cloudera/project/stg/flight_stg/airports_staging/
hdfs dfs -mkdir -p /user/cloudera/project/stg/flight_stg/airlines_staging/
hdfs dfs -mkdir -p /user/cloudera/project/stg/flight_stg/routes_staging/
hdfs dfs -mkdir -p /user/cloudera/project/landing/flight_landing/airports/
hdfs dfs -mkdir -p /user/cloudera/project/landing/flight_landing/airlines/
hdfs dfs -mkdir -p /user/cloudera/project/landing/flight_landing/routes/

echo "********** HDFS folder structure created successfully **********"

cd ./files
hdfs dfs -put airports_data /user/cloudera/project/stg/flight_stg/airports_staging/
hdfs dfs -put airlines_data /user/cloudera/project/stg/flight_stg/airlines_staging/
hdfs dfs -put routes_data /user/cloudera/project/stg/flight_stg/routes_staging/

echo "********** File upload into HDFS successfully **********"

cd ../hqls

hive -e "create database if not exists flight_stg"
hive -e "create database if not exists flight_landing"

echo "********** Hive Databases Created successfully **********"

hive -f "airports_stg.hql"
hive -f "airlines_stg.hql"
hive -f "routes_stg.hql"
hive -f "airports.hql"
hive -f "airlines.hql"
hive -f "routes.hql"

echo "********** Hive Table Created successfully **********"

hive -e "INSERT INTO TABLE flight_landing.airport SELECT * FROM flight_stg.airport_stg;"
hive -e "INSERT INTO TABLE flight_landing.airlines SELECT * FROM flight_stg.airlines_staging;"
hive -e "INSERT INTO TABLE flight_landing.routes SELECT * FROM flight_stg.routes_staging;"  

cd ../files

# hdfs dfs -rm -r /user/cloudera/project/stg/flight_stg/airports_staging/*
# hdfs dfs -rm -r /user/cloudera/project/stg/flight_stg/airlines_staging/*
# hdfs dfs -rm -r /user/cloudera/project/stg/flight_stg/routes_staging/*

#hive --service metastore &
#hiveserver2 &
























































# /Desktop/HiveProject$ . scripts/script.sh

