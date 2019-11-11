#!/bin/sh

fecha_archivo = `date +%Y%m%d-%H%M`
fichero_respaldo = ucasoft-$fecha_archivo.bkp

pg_dump -U admin -v ucasoft > /var/backups/ucasoft/$fichero_respaldo
