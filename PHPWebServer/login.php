<?php
//login.php
/*
Takes in a user and pass
Hashes the password 

Calls SQL proc and if result set is for Error is null and Status is "true" then all is good
Also returns authtoken

------------------------- AUTHTOKEN NOTES ------------------------- 
Authtoken will be used as a parameter everytime the RESTApi is called. Authtoken is then used as a preemptive check to every action on the sql server
and will be a similar check to this login sequence
*/

$username = $_POST['username'];
$pass = $_POST['password'];

$sqlstatement = mssql_init('UserLogin_Proc');

$passhash = password_hash($pass, PASSWORD_BCRYPT, array('cost'=>11));

mssql_bind($sqlstatement, '@Username', $username, SQLVARCHAR, false, false, 50);
mssql_bind($sqlstatement, '@Password', $passhash, SQLVARCHAR, false, false, 60);
mssql_bind($sqlstatement, '@Action', 0, SQLBIT, false, false, 1);

$query = mssql_execute($sqlstatement);

mssql_result($sqlstatement)

//There's only one result set which contains status, errormsg, and authtoken
$resultSet = mssql_result($query);

if(resultSet[0] == "true")
{
	echo resultSet[2]; //Authtoken
}
else
{
	echo resultSet[1]; //Error message
}

mssql_free_result($resultSet);

mssql_free_statement($sqlstatement);

?>