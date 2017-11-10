<?php
//delete.php
/**
------------------------- JSON Return ------------------------- 
Error: <true/false> //true meaning success
ErrorMessage: <message>
*/
if(isset($_POST['username']) && isset($_POST['auth']) && isset($_POST['projectid']))
{
	$authToken = $_POST['auth'];
	$username = $_POST['username'];
	$projectid = $_POST['projectid'];
	
	$serverName = 'localhost';
	$connInfo = array('Database'=>'LycheeActivityOnNode414');
	$conn = sqlsrv_connect($serverName, $connInfo);
	
	if(!$conn)
	{
		echo json_encode(array('Error' => 'false', 'ErrorMessage' => 'Connection to database not established'));
		die( print_r( sqlsrv_errors(), true));
	}
	
	$sqlQueryConfirmAuth = '{call UserAuthentication_Proc (?,?)}';
	$confirmAuthParams = array(
								array($username, SQLSRV_PARAM_IN),
								array($authToken, SQLSRV_PARAM_IN)
							);
	
	$resultSetConfirmAuthentication = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryConfirmAuth, $confirmAuthParams));
	
	if($resultSetConfirmAuthentication[0] == "true")
	{
		$sqlQueryDeleteProject = '{call DeleteProject_Proc (?,?)}';
		$deleteProjectParams = array(
									array($username, SQLSRV_PARAM_IN),
									array($projectid, SQLSRV_PARAM_IN)
								);
		$resultSetDeleteProject = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryDeleteProject, $deleteProjectParams));
		
		//Print out the error, error message, and PID
		echo json_encode(array('Error' => $resultSetDeleteProject[0], 'ErrorMessage' => $resultSetDeleteProject[1]));
	}
	else
	{
		echo json_encode(array('Error' => $resultSetConfirmAuthentication[0], 'ErrorMessage' => $resultSetConfirmAuthentication[1]));
	}
	
	sqlsrv_close($conn);
}
else
{
	echo json_encode(array('Error'=>'false', 'ErrorMessage'=>'Invalid parameters'));
}

?>