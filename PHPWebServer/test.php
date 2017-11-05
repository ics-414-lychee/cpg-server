<?php

$serverName = 'localhost';
$connInfo = array('Database'=>'LycheeActivityOnNode414');

$conn = sqlsrv_connect($serverName, $connInfo);
if($conn)
{
	echo 'good';
}
else
{
	echo 'bad';
}

?>