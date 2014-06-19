<?php

	$users = array(
		array(
			"name" 	=> "Adnane",
			"email" => "adnane.deev@gmail.com",
			"hash"	=> "46d54f5d4f65e4"
		),
		array(
			"name" 	=> "Alexis",
			"email" => "alexis.deev@gmail.com",
			"hash"	=> "46d54f5d4f65e4"
		),
		array(
			"name" 	=> "Messi",
			"email" => "messi.deev@gmail.com",
			"hash"	=> "46d54f5d4f65e4"
		)
	);
	
	foreach($users as $user)
	{
		printf("%s %s %s", $user["name"], $user["email"], $user["hash"]);
	}
	
?>