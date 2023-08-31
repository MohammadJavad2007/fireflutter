<?php

$file = json_decode(file_get_contents("data.json"), true);
$post = array("user" => $_POST["user"], "pass" => $_POST["pass"]);

if (array_search($post,$file,true)) {
    header("Location: page.html");
} else {
    header("Location: log_in.html");
}

?>