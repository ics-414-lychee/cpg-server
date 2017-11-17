<?php
//create.php
/**
------------------------- JSON Return ------------------------- 
Error: <true/false> //true meaning success
ErrorMessage: <message>
ProjectID: <projectID>
*/
if(isset($_POST['username']) && isset($_POST['auth']) && isset($_POST['projectname']) && isset($_POST['projectdeadline']))
{
	$authToken = $_POST['auth'];
	$username = $_POST['username'];
	$projectName = $_POST['projectname'];
	$projectDeadline = $_POST['projectdeadline'];
	
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
		$sqlQueryCreateProject = '{call CreateProject_Proc (?,?,?)}';
		$createProjectParams = array(
									array($username, SQLSRV_PARAM_IN),
									array($projectName, SQLSRV_PARAM_IN),
									array($projectDeadline, SQLSRV_PARAM_IN)
								);
		$resultSetCreateProject = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryCreateProject, $createProjectParams));
		
		//Print out the error, error message, and PID
		echo json_encode(array('Error' => $resultSetCreateProject[0], 'ErrorMessage' => $resultSetCreateProject[1], 'ProjectID' => $resultSetCreateProject[2]));
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