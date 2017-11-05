<?php
//save.php
$authToken = $_POST['auth'];
$saveInformation = $_POST['saveInformation']; //json

/**
-------------------------- ALL JSON FILES LOOK LIKE THIS --------------------------
username: <user>
project: <projectname/id>


*/

$json = json_decode($saveInformation);

$sqlVerify = mssql_init('UserVerifyAuthtoken_Proc');

mssql_bind($sqlVerify, '@Authtoken', $username, SQLVARCHAR, false, false, 50);

$query = mssql_execute($sqlVerify);

mssql_result($sqlVerify)

//There's only one result set which contains status, errormsg
$resultSet = mssql_result($query);

if(resultSet[0] == "true")
{
	echo "success";
	
	$sqlSave = mssql_init('UserSaveProject_Proc');
	
	mssql_bind($sqlSave, '@Username', $json->username, SQLVARCHAR, false, false, 50);
	mssql_bind($sqlSave, '@Project', $json->project, SQLVARCHAR, false, false, 20);
	mssql_bind($sqlSave, '@', $json->username, SQLVARCHAR, false, false, 50);
	mssql_bind($sqlSave, '@Username', $json->username, SQLVARCHAR, false, false, 50);
	
}
else
{
	echo resultSet[1];
}

mssql_free_result($sqlVerify);

mssql_free_statement($sqlVerify);

?>