<!DOCTYPE html>
<HTML>
<head>
<link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/include/sitecolors.css" />
</head>
<body>
<center>
<table border = '0' height='100%'>
<tr>
<td>

</td></tr><tr><td>

<br>
<a href="http://voncloft.dnsfor.me/include/logout.php?logout">Sign Out</a>
<?php
error_reporting(E_ERROR | E_PARSE);
session_start();
include_once 'dbconnect.php';
if(!isset($_SESSION['user']))
{
        header("Location: http://voncloft.dnsfor.me/index.php");
}
$res=mysqli_query($conn,"SELECT * FROM users WHERE user_id=".$_SESSION['user']);
$userRow=mysqli_fetch_array($res);
if ($_SESSION['clearance']<>1)
{
	echo "<br>Restricted Access";
	echo '<br><a href="/updated">Logs</a>';
}
else
{
	echo '<br><a href="/files">Videos</a>';
	echo '<br><a href="/temp">New Downloads</a>';
	echo '<br><a href="/audio">Music</a>';
        echo '<br><a href="/repository">REPO</a>';
        echo '<br><a href="/updated">Logs</a>';
        
}
?>
</BODY>
<footer>
</footer>
</HTML>
