# cpg-server

## Database
The SQL Server database is used to keep track of the user's topological sorted data, so users can, from any device, access their topologically sorted data viewed through the client.
When a user logs in, it provides the client a login-token with an expiration. For every procedure executed, a parameter passed will be the user's login token, and will not run the proc should the login-token be expired. On that prompt, it will log the user out within the front end.
Expiration occurs after an hour of no activity to the back-end.

## API
Responsible for verifying users.
Takes in the raw data from the client (activities and their dependencies), executes the top-sort on the backend, retrieves the data in json format, parses through the data and stores the finalized results in the database and returns the JSON to the client.
