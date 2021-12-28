<?php
error_reporting(E_ERROR | E_PARSE);
session_start();
include_once '/media/Websites/voncloft.dnsfor.me/include/dbconnect.php';

if(isset($_SESSION['user'])!="")
{
	header("Location: secondary.php");
}

if(isset($_POST['btn-login']))
{
	$email = mysqli_real_escape_string($conn,$_POST['email']);
	$upass = mysqli_real_escape_string($conn,$_POST['pass']);
	$res=mysqli_query($conn,"SELECT * FROM users WHERE email='$email'");
	$row=mysqli_fetch_array($res);
	//echo md5($upass);
	if($row['password']==md5($upass))
	{
		$_SESSION['user'] = $row['user_id'];
		$_SESSION['clearance']=$row['Clearance'];
		//header("Location: files/secondary.php");
		header("Location: secondary.php");
	}
	else
	{
		?>
        <script>alert('access denied');</script>
        <?php
	}
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Nickflix - Login & Registration System</title>
<link rel="stylesheet" href="http://voncloft.dnsfor.me/include/style.css" type="text/css" />
</head>
<body>
<center>
<div id="login-form">
<form method="post">
<table align="center" width="30%" border="2">
<tr>
<td><input type="text" name="email" placeholder="Your Email" required /></td>
</tr>
<tr>
<td><input type="password" name="pass" placeholder="Your Password" required /></td>
</tr>
<tr>
<td><button type="submit" name="btn-login">Sign In</button></td>
</tr>
<tr>
<td><a href="../include/register.php">Sign Up Here</a></td>
</tr>
</table>
</form>
</div>
</center>
</body>
</html>
