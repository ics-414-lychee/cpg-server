<?php
//register.php
/*
Calls register proc
*/

$username = $_POST['username'];
$pass = $_POST['password'];

$sqlstatement = mssql_init('UserLoginOrCreate_Proc');

$passhash = password_hash($pass, PASSWORD_BCRYPT, array('cost'=>11));

mssql_bind($sqlstatement, '@Username', $username, SQLVARCHAR, false, false, 50);
mssql_bind($sqlstatement, '@Password', $passhash, SQLVARCHAR, false, false, 60);
mssql_bind($sqlstatement, '@Action', 1, SQLBIT, false, false, 1);

$query = mssql_execute($sqlstatement);

mssql_result($sqlstatement)

//There's only one result set which contains status, errormsg
$resultSet = mssql_result($query);

if(resultSet[0] == "true")
{
	echo "success";
}
else
{
	echo resultSet[1];
}

mssql_free_result($resultSet);

mssql_free_statement($sqlstatement);

?>