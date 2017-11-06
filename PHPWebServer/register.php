<?php
//register.php
/*
Calls register proc

------------------------- JSON Return ------------------------- 
Error: <true/false> //true meaning success
ErrorMessage: <message>

*/

if(isset($_POST['username']) && isset($_POST['password']))
{
	$username = $_POST['username'];
	$pass = $_POST['password'];

	$serverName = 'localhost';
	$connInfo = array('Database'=>'LycheeActivityOnNode414');
	$conn = sqlsrv_connect($serverName, $connInfo);
	
	$sqlQueryGetSalt = '{call ViewRandomGeneratedSalt_Proc}';
	$resultSetGetSalt = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryGetSalt));
	
	$passhash = password_hash($pass, PASSWORD_BCRYPT, array('salt'=>$resultSetGetSalt[0]));
	
	$registerParams = array(
								array($username, SQLSRV_PARAM_IN),
								array($passhash, SQLSRV_PARAM_IN),
								array($resultSetGetSalt[0], SQLSRV_PARAM_IN),
								array(1, SQLSRV_PARAM_IN)
							);
	$sqlQuery = '{call UserLoginOrCreate_Proc (?,?,?,?)}';	
	$ex = sqlsrv_query($conn, $sqlQuery, $registerParams);
	
	$resultRegister = sqlsrv_fetch_array($ex);
	echo json_encode(array('Error' => $resultRegister[0], 'ErrorMessage' => $resultRegister[1]));
	
	sqlsrv_close($conn);
}
else
{
	echo json_encode(array('Error' => 'false', 'ErrorMessage'=>'Invalid parameters'));
}

?>