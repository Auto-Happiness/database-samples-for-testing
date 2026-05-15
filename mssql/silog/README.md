# MSSQL Silog Database - Docker Setup

This directory contains a Docker Compose setup to quickly spin up a MSSQL Server database with the Silog food inventory system pre-configured.

## Prerequisites

- Docker Desktop installed and running
- Docker Compose (usually included with Docker Desktop)

## Quick Start

### 1. Start the Database

```bash
docker-compose up -d
```

This will:
- Download the MSSQL Server 2022 image
- Create and start the MSSQL container
- Initialize the database with tables and sample data
- Expose the database on `localhost:1433`

### 2. Verify the Database is Ready

```bash
docker-compose logs -f mssql
```

Wait for the message indicating the database is ready and all initialization is complete.

## Connection Details

**Server**: `localhost` or `127.0.0.1`
**Port**: `1433`
**Username**: `sa`
**Password**: `YourStrongPassword123!`
**Database**: `tapalord`

## Connection Strings

### SQL Server Management Studio (SSMS)
```
Server=localhost,1433
Username=sa
Password=YourStrongPassword123!
Database=tapalord
```

### .NET Entity Framework
```
Server=localhost,1433;Database=tapalord;User Id=sa;Password=YourStrongPassword123!;TrustServerCertificate=True;
```

### Python (pyodbc)
```python
import pyodbc
connection = pyodbc.connect(
    'Driver={ODBC Driver 17 for SQL Server};'
    'Server=localhost,1433;'
    'Database=tapalord;'
    'UID=sa;'
    'PWD=YourStrongPassword123!;'
    'TrustServerCertificate=yes;'
)
```

### Node.js (mssql)
```javascript
const sql = require('mssql');
const config = {
  server: 'localhost',
  port: 1433,
  authentication: {
    type: 'default',
    options: {
      userName: 'sa',
      password: 'YourStrongPassword123!'
    }
  },
  options: {
    database: 'tapalord',
    trustServerCertificate: true
  }
};
```

## Database Schema

The following tables are automatically created:

### Core Tables
- **food_categories** - Food item categories
- **food** - Inventory of food items
- **customers** - Customer information
- **orders** - Customer orders
- **invoice** - Invoice records
- **suppliers** - Supplier information

### Additional Tables
- **order_items** - Line items for each order
- **inventory_log** - Transaction history for inventory
- **meals** - Menu meals (silog, desserts, etc.)
- **meal_items** - Ingredients/recipes for meals

### Views
- **vw_customer_purchase_summary** - Customer purchase analytics
- **vw_low_stock_inventory** - Low stock alerts
- **vw_popular_meals_revenue** - Meal revenue analysis
- **vw_invoice_payment_report** - Invoice payment tracking

## Sample Data

The database is seeded with:
- 9 food categories
- 5 suppliers
- 20 food items (including 6 desserts)
- 6 customers (ordinary people)
- 6 sample orders
- 6 invoices
- 12 meals (6 silog + 6 desserts)
- Complete meal recipes with ingredients

## Useful Commands

### Stop the Database
```bash
docker-compose down
```

### Stop and Remove All Data
```bash
docker-compose down -v
```

### View Database Logs
```bash
docker-compose logs -f mssql
```

### Connect with Docker Exec
```bash
docker exec -it mssql-silog-db /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'YourStrongPassword123!' -d tapalord
```

### Rebuild the Container
```bash
docker-compose up -d --build
```

## Customization

### Change Password

Edit `docker-compose.yaml` and `init-db.sh`:
1. Update `MSSQL_SA_PASSWORD` in the `environment` section
2. Update `SA_PASSWORD` in `init-db.sh`
3. Update the healthcheck password

### Change Port

Edit `docker-compose.yaml`:
```yaml
ports:
  - "YOUR_PORT:1433"  # Change left side to desired port
```

### Change Database Name

Edit `init-db.sh`:
```bash
DB_NAME="your_database_name"
```

### Mount Custom SQL Script

Edit `docker-compose.yaml` volumes section to point to your own SQL file:
```yaml
volumes:
  - ./your-script.sql:/docker-entrypoint-initdb.d/01-init.sql
```

## Troubleshooting

### Container won't start
```bash
docker-compose logs mssql
```
Check the logs for errors. Common issues:
- Port 1433 already in use
- Insufficient system resources

### Database connection fails
- Ensure container is running: `docker ps`
- Wait for healthcheck to pass (5-6 retries after startup)
- Check password is correct in your connection string

### Reinitialize Database

```bash
docker-compose down -v
docker-compose up -d
```

This removes all data and reinitializes from the SQL script.

## Performance Notes

- Initial startup takes 30-60 seconds
- Database initialization takes another 10-30 seconds
- Data persists in the `mssql_data` volume even if container is stopped

## Security Notes

⚠️ **IMPORTANT**: The default password in this setup is for development only. For production use:
1. Generate a strong password
2. Store it in a `.env` file
3. Reference it in docker-compose.yaml: `${MSSQL_SA_PASSWORD}`
4. Add `.env` to `.gitignore`

Example `.env` file:
```
MSSQL_SA_PASSWORD=YourReallyStrongPasswordHere123!@#
```

## Support

For issues with MSSQL Docker images, see the official documentation:
https://hub.docker.com/_/microsoft-mssql-server

## License

This database setup is part of the Orcha Agent OS project.
