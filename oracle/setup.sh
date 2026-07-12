#!/bin/bash
echo "Creating user models..."
sqlplus / as sysdba <<EOF
ALTER SESSION SET CONTAINER = FREEPDB1;
DROP USER models CASCADE;
CREATE USER models IDENTIFIED BY models;
GRANT CONNECT, RESOURCE, DBA TO models;
EXIT;
EOF

echo "Initializing database using models.sql under models schema..."
sqlplus models/models@//localhost:1521/FREEPDB1 @/opt/oracle/models.sql
echo "Database initialization completed."
