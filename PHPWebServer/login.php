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

------------------------- JSON Return ------------------------- 
SINGLE JSON

ErrorJSON:
	Error: <true/false>
	ErrorMessage: <message>
	Auth: <auth>
ProjectsJSON:
	//WHEN "Error" IN JSON IS TRUE, SECOND JSON WILL NTO BE NULL
	//For viewing all projects that the user is added to/owns
	ProjectIDs: <id1,id2,id3,id4...>
	ProjectNames: <name1,name2,name3,name4...>

*/

if(isset($_POST['username']) && isset($_POST['password']))
{
	$username = $_POST['username'];
	$pass = $_POST['password'];

	$serverName = 'localhost';
	$connInfo = array('Database'=>'LycheeActivityOnNode414');
	$conn = sqlsrv_connect($serverName, $connInfo);

	$getSaltParams = array(array($username, SQLSRV_PARAM_IN));
	$sqlQueryGetSalt = '{call ViewSaltForUser_Proc (?)}';
	$resultSetGetSalt = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryGetSalt, $getSaltParams));
	
	if($resultSetGetSalt[0] == "true")
	{
		$passhash = password_hash($pass, PASSWORD_BCRYPT, array('salt'=>$resultSetGetSalt[2]));

		$loginParams = array(
								array($username, SQLSRV_PARAM_IN),
								array($passhash, SQLSRV_PARAM_IN),
								array('', SQLSRV_PARAM_IN),
								array(0, SQLSRV_PARAM_IN)
							);
		
		$sqlQuery = '{call UserLoginOrCreate_Proc (?,?,?,?)}';
		
		$ex = sqlsrv_query($conn, $sqlQuery, $loginParams);
		
		//There's only one result set which contains status, errormsg, and authtoken
		$resultSet = sqlsrv_fetch_array($ex);

		$jsonArrayReturn = array('Error'=>$resultSet[0], 'ErrorMessage'=>$resultSet[1], 'Auth'=>$resultSet[2]);
		
		if($resultSet[0] == "true")
		{
			$viewProjectsParams = array(array($username, SQLSRV_PARAM_IN));
			$sqlQueryViewProjects = '{call ViewAllAvailableProjects_Proc (?)}';
			
			$exViewProjects = sqlsrv_query($conn, $sqlQueryViewProjects, $viewProjectsParams);
			
			$pidsArray = [];
			$pnamesArray = [];
			
			
			while( $row = sqlsrv_fetch_array( $exViewProjects, SQLSRV_FETCH_NUMERIC ))
			{
				array_push($pidsArray, $row[0]);
				array_push($pnamesArray, $row[1]);
			}
			
			$pids = implode(',', $pidsArray);
			$pnames = implode(',', $pnamesArray);
			
			echo json_encode(array('ErrorJSON' => $jsonArrayReturn, 'ProjectsJSON' => array('ProjectIDs' => $pids, 'ProjectNames' => $pnames)));
		}
		else
		{
			echo json_encode(array('ErrorJSON' => $jsonArrayReturn, 'ProjectsJSON' => null));
		}
	}
	else
	{
		echo json_encode(array('ErrorJSON'=>array('Error' => $resultSetGetSalt[0], 'ErrorMessage'=>$resultSetGetSalt[1], 'Auth'=>null), 'ProjectsJSON'=>null));
	}
	
	sqlsrv_close($conn);
}
else
{
	echo json_encode(array('ErrorJSON'=>array('Error' => 'false', 'ErrorMessage' => 'Invalid parameters', 'Auth'=>null), 'ProjectsJSON'=>null));
}

?>