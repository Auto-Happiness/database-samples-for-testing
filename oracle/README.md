# Oracle Sample Database

This directory contains an Oracle Database sample setup using Docker Compose.

## Service
- Container name: `oracle-free`
- Image: `container-registry.oracle.com/database/free:latest-lite`
- Port: `1521` mapped to host `1521`

## Database
- Pluggable database service: `FREEPDB1`
- Connect string: `//localhost:1521/FREEPDB1`

## Credentials
- Admin user: `SYS`
- Admin password: `oracle`
- Connect as SYSDBA: `sqlplus sys/oracle@//localhost:1521/FREEPDB1 as sysdba`

### Sample schema user
- User: `MODELS_SCHEMA`
- Password: `models123`

### Additional user created by init script
- User: `MODELS`
- Password: `models`

## Files
- `docker-compose.yaml`: starts the Oracle container and mounts setup scripts.
- `setup.sh`: initialization script run by the container on first startup.
- `models.sql`: schema and sample data for the `MODELS_SCHEMA` database.
- `restart.ps1`: helper script for restarting the Oracle service on Windows.
- `seed.ps1`: PowerShell script to start the container, wait for health, and seed/initialize the database.

## Usage
1. Run the seeding PowerShell script in this directory:
   ```powershell
   .\seed.ps1
   ```
   This will spin up the container, wait until the database is ready, seed the tables/data, and output connection details.
2. Connect using `sqlplus` or another Oracle client.

## Notes
- The Oracle container uses a bind mount for the setup script and a named volume for persistent data.
- If you need to reset the database, stop the container and remove the `oracle-data` volume before restarting.
