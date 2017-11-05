<?php
//save.php
$authToken = $_POST['auth'];
$username = $_POST['username'];
$json = $_POST['json']; //Contains all node information and projectid

/**
------------------------- JSON Return ------------------------- 
Error: <true/false> //true meaning success
ErrorMessage: <message>

---------------------------------------------------------------------------------------------
--NOTES FOR ME
-------------------------- ALL JSON FILES LOOK LIKE THIS FROM JAVA --------------------------
    for (ActivityNode n : a.getNodeList()) {
      JSONObject node = new JSONObject();
      node.put("NodeID", n.getNodeId());
      node.put("NodeName", n.getName());
      node.put("Description", n.getDescription());

      // Times are accessed as an array.
      double times[] = n.getTimes();
      node.put("NormalTime", times[0]);
      node.put("Optimistictime", times[1]);
      node.put("PessimisticTime", times[2]);

      // We store our dependency list as a comma-separated list. Store the nodes in the main list.
      node.put("DependencyNodeID", String.join(",", n.getDependencies().toString()));
      nodeList.add(node);
    }

    net.put("ProjectID", a.getNetworkId());
    net.put("NodeList", nodeList);
	
	{
		"NodeList":
		[
			{
				"Description":"testn",
				"NodeName":"test",
				"NodeID":0,
				"PessimisticTime":1414.0,
				"DependencyNodeID":"[]",
				"NormalTime":122.0,
				"Optimistictime":133.0
			},
			{
				"Description":"testn",
				"NodeName":"test1",
				"NodeID":1,
				"PessimisticTime":1414.0,
				"DependencyNodeID":"[]",
				"NormalTime":122.0,
				"Optimistictime":133.0
			}
		],
		"ProjectID":0
	}
*/

$json = json_decode($saveInformation);



?>