<?php
//save.php
/**
------------------------- JSON Return ------------------------- 
Error: <true/false> //true meaning success
ErrorMessage: <message>
*/

if(isset($_POST['auth']) && isset($_POST['username']) && isset($_FILES['json']) && $_FILES['json']['size'] < 1000000) //Cannot be greater than 1mb
{
	$authToken = $_POST['auth'];
	$username = $_POST['username'];
	$json = json_decode(file_get_contents($_FILES['json']['tmp_name']), true); //Contains all node information and projectid
	
	$serverName = 'localhost';
	$connInfo = array('Database'=>'LycheeActivityOnNode414');
	$conn = sqlsrv_connect($serverName, $connInfo);
	
	$sqlQueryConfirmAuth = '{call UserAuthentication_Proc (?,?)}';
	$confirmAuthParams = array(
								array($username, SQLSRV_PARAM_IN),
								array($authToken, SQLSRV_PARAM_IN)
							);
	
	$resultSetConfirmAuthentication = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryConfirmAuth, $confirmAuthParams));
	
	if($resultSetConfirmAuthentication[0] == "true")
	{
		$sqlQueryInitializeProjectSave = '{call UserInitializeSaveFullProject_Proc (?,?)}';
		$initializeProjectSaveParams = array(
											array($username, SQLSRV_PARAM_IN),
											array($json['ProjectID'], SQLSRV_PARAM_IN)
										);

		$resultInitializeProjectSave = sqlsrv_fetch_array(sqlsrv_query($conn, $sqlQueryInitializeProjectSave, $initializeProjectSaveParams));
		if($resultInitializeProjectSave[0] == "true")
		{
			$errors = false;
			
			foreach($json['NodeList'] as $nodeListItem)
			{
				$sqlQuerySaveNode = '{call UserSaveSingleNode_Proc (?,?,?,?,?,?,?,?,?)}';
				//Chance that dependencies for node does not exist. In which case, we will not loop through them. But if they do, we loop through them.
				if(array_key_exists('DependencyNodeID', $nodeListItem))
				{
					$dependencies = explode(',', $nodeListItem['DependencyNodeID']);
					foreach($dependencies as $nodeid)
					{
						$saveNodeParams = array(
													array($username, SQLSRV_PARAM_IN),
													array($json['ProjectID'], SQLSRV_PARAM_IN),
													array($nodeListItem['NodeID'], SQLSRV_PARAM_IN),
													array($nodeListItem['NodeName'], SQLSRV_PARAM_IN),
													array($nodeListItem['Optimistictime'], SQLSRV_PARAM_IN),
													array($nodeListItem['NormalTime'], SQLSRV_PARAM_IN),
													array($nodeListItem['PessimisticTime'], SQLSRV_PARAM_IN),
													array($nodeid, SQLSRV_PARAM_IN),
													array($nodeListItem['Description'], SQLSRV_PARAM_IN)
												);
						
						$execSaveNode = sqlsrv_query($conn, $sqlQuerySaveNode, $saveNodeParams);
						
						if(!$execSaveNode) //If fails to save at any point due to sql error
						{
							echo json_encode(array('Error' => 'false', 'ErrorMessage' => sqlsrv_errors()));
							$errors = true;
							break 2;
						}
						else
						{
							$saveNodeResult = sqlsrv_fetch_array($execSaveNode);
							//The only time this can return "false" is when the project does not belong to them
							//This should also never be the case because when we initialize the SaveFullProject, we are also performing this check. THis is just a "just in case" thing though
							//For the race condition such that while someone is performing a save, someone just did a delete
							if($saveNodeResult[0] == "false")
							{
								echo json_encode(array('Error'=>$saveNodeResult[0], 'ErrorMessage' => $saveNodeResult[1]));
								$errors = true;
								break 2;
							}
						}
					}
				}
				else
				{
					//Case where there are no dependencies
					$saveNodeParams = array(
												array($username, SQLSRV_PARAM_IN),
												array($json['ProjectID'], SQLSRV_PARAM_IN),
												array($nodeListItem['NodeID'], SQLSRV_PARAM_IN),
												array($nodeListItem['NodeName'], SQLSRV_PARAM_IN),
												array($nodeListItem['Optimistictime'], SQLSRV_PARAM_IN),
												array($nodeListItem['NormalTime'], SQLSRV_PARAM_IN),
												array($nodeListItem['PessimisticTime'], SQLSRV_PARAM_IN),
												array(-1, SQLSRV_PARAM_IN),
												array($nodeListItem['Description'], SQLSRV_PARAM_IN)
											);
					
					$execSaveNode = sqlsrv_query($conn, $sqlQuerySaveNode, $saveNodeParams);
					
					if(!$execSaveNode) //If fails to save at any point due to sql error
					{
						echo json_encode(array('Error' => 'false', 'ErrorMessage' => sqlsrv_errors()));
						$errors = true;
						break;
					}
					else
					{
						$saveNodeResult = sqlsrv_fetch_array($execSaveNode);
						//The only time this can return "false" is when the project does not belong to them
						//This should also never be the case because when we initialize the SaveFullProject, we are also performing this check. THis is just a "just in case" thing though
						//For the race condition such that while someone is performing a save, someone just did a delete
						if($saveNodeResult[0] == "false")
						{
							echo json_encode(array('Error'=>$saveNodeResult[0], 'ErrorMessage' => $saveNodeResult[1]));
							$errors = true;
							break;
						}
					}
				}
			}
			
			//Only print out the success if no errors occurred during save
			if(!$errors)
			{
				echo json_encode(array('Error' => $resultInitializeProjectSave[0], 'ErrorMessage' => $resultInitializeProjectSave[1]));
			}
		}//TODO confirmed that test works up to this point
		else
		{
			echo  json_encode(array('Error' => $resultInitializeProjectSave[0], 'ErrorMessage' => $resultInitializeProjectSave[1]));
		}
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