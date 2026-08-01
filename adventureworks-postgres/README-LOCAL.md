# AdventureWorks for Postgres (Local Workspace Setup)

This folder contains the AdventureWorks-for-Postgres sample database.

## Quick start

1. Ensure the `adventure_works_2014_OLTP_script.zip` file is present in this folder.
2. Run:

```powershell
cd .\adventureworks-postgres
docker-compose up --build
```

3. Wait for Postgres to start and initialize the database.

4. Connect:

```powershell
psql -h localhost -U postgres -d Adventureworks
```

5. If you want to use the `docker` user created by the image:

```powershell
psql -h localhost -U docker -d Adventureworks
```

## Notes

- The Docker image builds the sample when `docker-compose up --build` runs.
- The archive file is already downloaded into this folder.
- The root repo should ignore `pg/data` and local backup folders, not this folder.
