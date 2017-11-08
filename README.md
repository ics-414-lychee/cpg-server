# cpg-server

## Database
The SQL Server database is used to keep track of the user's topological sorted data, so users can, from any device, access their topologically sorted data viewed through the client.
When a user logs in, it provides the client a login-token with an expiration. For every procedure executed, a parameter passed will be the user's login token, and will not run the proc should the login-token be expired. On that prompt, it will log the user out within the front end.
Expiration occurs after an hour of no activity to the back-end.

## API
Responsible for verifying users.
Takes in the raw data from the client (activities and their dependencies), executes the top-sort on the backend, retrieves the data in json format, parses through the data and stores the finalized results in the database and returns the JSON to the client.

## Installation
### Requirements:
- PHP 5.6.x or newer
- MS SQL Server (install PHP drivers for your version of SQL Server and PHP version)
  - You will need to modify your php.ini to include the sqlsrv extensions

### Instructions
#### SQL Server
- Create a Database "LycheeActivityOnNode414", execute script.sql or the individual table and proc x.sql files
- Make a new SQL Server Agent Job
- Have the following configurations:
  - Schedule: Daily, Occurs every 30 minutes, no end date
  - Steps: ```exec MaintenanceAuthentication_proc on LycheeActivityOnNode414 database```

 
#### PHP Web Server
- Put all php files in your web server and configure $serverName, and database information to match your database configuration. Include password in $connInfo if password is set
