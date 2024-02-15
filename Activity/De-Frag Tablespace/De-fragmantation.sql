
DE-FRAGMANTATION
--https://www.youtube.com/watch?v=4EaypEedWEU&list=WL&index=3
- identify objects in current tablespace
- create temporary
--enable row movement
--dissable row movement
- move tables/rebuild index to new temporary tablesapce
--alter tablespace original tablesapce coalesce;
- move tables/rebuild index back to the original tablesapce
--gather schema statistic
- drop the temporary tablespace 
- check tablespace details

atau
- setelah move to temporary tablespace
- the datafile of the original tablespace is resized first