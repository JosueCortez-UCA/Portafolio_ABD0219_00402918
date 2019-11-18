/*
    1
*/
sudo su
    -- desinstalacion
apt purge postgresql postgresql-11 postgresql-common
apt autoremove
rm -r /var/lib/postgresql/
rm -r /etc/postgresql-common/

    -- instalacion
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > \/etc/apt/sources.list.d/postgresql.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update
apt-get upgrade
apt-get install postgresql-11
apt-get install pgadmin4 --opcional

    -- comprobacion
pg_lsclusters
pg_ctlcluster 11 main status

    -- usuario uca
su postgres
psql

CREATE USER uca WITH PASSWORD 'wii';

/*
    2
*/
pg_createcluster 11 standby

/*
    3
*/
pg_ctlcluster 11 standby start

/*
    4
*/
apt-get install postgresql-11-pglogical

/*
    5
*/
nano /etc/postgresql/11/main/postgresql.conf
wal_level = 'logical'
max_worker_processes = 10
max_replication_slots = 10
max_wal_senders = 10
shared_preload_libraries = 'pglogical'
track_commit_timestamp = on

nano /etc/postgresql/11/standby/postgresql.conf
wal_level = 'logical'
max_worker_processes = 10
max_replication_slots = 10
max_wal_senders = 10
shared_preload_libraries = 'pglogical'
track_commit_timestamp = on

nano /etc/postgresql/11/main/pg_hba.conf
local all all md5
local replication all md5

nano /etc/postgresql/11/standby/pg_hba.conf
local all all md5
local replication all md5

service postgresql restart          -- opcion 1
/etc/init.d/postgresql restart      -- opcion 2
