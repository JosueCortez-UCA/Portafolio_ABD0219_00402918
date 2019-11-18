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
