<?php
//load.php
/**
ErrorJSON:
	Error: <true/false>
	ErrorMessage: <message>
NodesJSON:
	//WHEN "Error" IN JSON IS TRUE, SECOND JSON WILL NOT BE NULL
	//For viewing all projects that the user is added to/owns
	Nodes: {
		ProjectID: <projectid>
		NodeID: <nodeid>
		NodeName: <nodename>
		OptimalTime: <time>
		NormalTime: <time>
		PessimisticTime: <time>
		DependencyNode: <nodeid> //Single id, there may be multiple nodes with the same ID being returned to represent different DependencyNode IDs
		Description: <description>
	}
*/

if(isset($_POST['auth']) && isset($_POST['username']) && isset($_POST['projectid'])) //Cannot be greater than 1mb
{
	$auth = $_POST['auth'];
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
								array($auth, SQLSRV_PARAM_IN)
							);
	
	$resultSetConfirmAuthentication = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryConfirmAuth, $confirmAuthParams));
	
	if($resultSetConfirmAuthentication[0] == "true")
	{
		$sqlLoadQuery = '{call ViewSingleProject_Proc (?,?)}';
		$sqlLoadParameters = array(
								array($username, SQLSRV_PARAM_IN),
								array($projectid, SQLSRV_PARAM_IN)
							);
		$exLoad = sqlsrv_query($conn, $sqlLoadQuery, $sqlLoadParameters);
		$resultSetProject = sqlsrv_fetch_array($exLoad);
		
		//echo print_r(sqlsrv_next_result($exLoad));
		if($resultSetProject[0] == "true")
		{
			$resultSetProject = sqlsrv_next_result($exLoad);
			$nodeArray = [];
			if($resultSetProject)
			{
				while( $row = sqlsrv_fetch_array( $exLoad, SQLSRV_FETCH_NUMERIC ))
				{
					array_push($nodeArray, array($row[0], 
												$row[1], 
												$row[2], 
												$row[3], 
												$row[4], 
												$row[5],
												$row[6], 
												$row[7]));
				}
			}
			else
			{
				//Case where the project is loaded, but the project is also empty.
				$nodeArray = null;
			}
			echo json_encode(array('ErrorJSON' => array('Error' => 'true', 'ErrorMessage' => ''), 'NodesJSON' => array('Nodes' => $nodeArray)));
			
		}
		else
		{
			echo json_encode(array('ErrorJSON' => array('Error' => $resultSetProject[0], 'ErrorMessage' => $resultSetProject[1]), 'NodesJSON' => null));
		}
	}
	else
	{
		echo json_encode(array('ErrorJSON' => array('Error' => $resultSetConfirmAuthentication[0], 'ErrorMessage' => $resultSetConfirmAuthentication[1]), 'NodesJSON' => null));
	}
	
	sqlsrv_close($conn);
}
else
{
	echo json_encode(array('ErrorJSON' => array('Error'=>'false', 'ErrorMessage'=>'Invalid parameters'), 'NodesJSON' => null));
}