<!DOCTYPE html>
<HTML>
<head>
<link rel="stylesheet" type="text/css" href="http://voncloft.dnsfor.me/include/sitecolors.css" />
</head>
<body>
<center>
<table border = '2' height='100%'>
<tr><td>

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

//echo $_SESSION['user'];
print("<table border=2 width=100%><tr><td align='left' width='105'>Access Level: ".$_SESSION['clearance']."</td>");
print("<td align='center'><a href='http://voncloft.dnsfor.me/secondary.php'>Home</a></td>");
print("<td align='right' width='60'><a href='http://voncloft.dnsfor.me/include/logout.php?logout'>Sign Out</a></td>");
print("</tr></table></td></tr><tr><td>");
function formatSize( $bytes )
{
        $types = array( 'B', 'KB', 'MB', 'GB', 'TB', 'PB' );
        for( $i = 0; $bytes >= 1024 && $i < ( count( $types ) -1 ); $bytes /= 1024, $i++ );
                return( round( $bytes, 2 ) . " " . $types[$i] );
}

  $dir='.';
  if (is_dir($dir)) /*1*/{
    $fd = @opendir($dir);
    if($fd) /*2*/{
      while (($part = @readdir($fd)) == true) /*3*/{
        if ($part != "." && $part != "..") /*4*/{
          $file_array[]=$part;
        }/*4*/
      }/*3*/
    }/*2*/
    sort($file_array);
    reset($file_array);

   if(count($file_array)==1)
   {
      print("<br><b><u>No new downloads at the moment - please check back later</u></b>");
   }
   else
   {
   print("<table border='1' width='710px' id='menu' height='100%'><tr><td width='690' ><center><b>File Name</b></center></td><td width='100'><center><b>Size</b></center></td><td>File Type</td></tr>");

    for($i=0;$i<count($file_array);$i++)/*5*/{

      $npart=$file_array[$i];

      if (!strstr($npart,".flv") && !strstr($npart,".css") && !strstr($npart,".inc.php") && 
!strstr($npart,".php") && 
!strstr($npart,"secondary.php")&& 
!strstr($npart,".db")&& !strstr($npart,".sh")&& !strstr($npart,"$")&& !strstr($npart,"System Volume Information")&& !strstr($npart,"Recycled")&& !strstr($npart,"network password.txt")&& !strstr($npart,"App_Data")&& !strstr($npart,"Hidden Stuff")&& !strstr($npart,".htaccess")&&!strstr($npart,".jpg")&&!strstr($npart,".jpeg")&&!strstr($npart,".bmp")&&!strstr($npart,".gif")&&!strstr($npart,".BMP")&&!strstr($npart,".JPG")&&!strstr($npart,".JPEG")&&!strstr($npart,".GIF")&&!strstr($npart,".png")&&!strstr($npart,".PNG")&&!strstr($npart,".mp3")&&!strstr($npart,".wav")&&!strstr($npart,".avi")&&!strstr($npart,".AVI")&&!strstr($npart,".hidden")&&!strstr($npart,".windows-serial") && !strstr($npart,".mkv") && !strstr($npart,"mp4") && !strstr($npart,"html") && !strstr($npart,"log"))
	/*6*/{
        //$fsize = filesize($dir."/".$npart)/1000;
        if (is_dir($npart)) 
	{/*7*/
          print("<tr class='directory'><TD><a href='$npart/secondary.php'>$npart</a></TD><TD 
align='center'><i>N/A</i></TD><TD>Directory</TD></TR>\n");
        } /*7*/
	else 
	{/*8*/

		$fsize = filesize($dir."/".$npart);
		$test=formatSize($fsize);

		print("<tr class='default'><TD><a href='$npart'>$npart</a></TD><TD align='right'><center> 
$test</center></TD><TD>Misc</TD></TR>\n");




        }/*8*/
      }/*6*/
	elseif(strstr($npart,".jpg")||strstr($npart,".jpeg")||strstr($npart,".png")||strstr($npart,".bmp")||strstr($npart,".BMP")||strstr($npart,".JPG")||strstr($npart,".JPEG")||strstr($npart,".PNG")||strstr($npart,".gif")||strstr($npart,".GIF"))
	{

		$fsize = filesize($dir."/".$npart);
		$test=formatSize($fsize);

		print("<tr class='imagefile'><TD><a href='$npart'>$npart</a></TD><TD align='right'><center> 
$test</center></TD><TD>Image</TD></TR>\n");

	}
	elseif(strstr($npart,".mp3")||strstr($npart,".wav"))
	{


		$fsize = filesize($dir."/".$npart);
		$test=formatSize($fsize);

		print("<tr class='musicfile'><TD><a href='$npart'>$npart</a></TD><TD align='right'><center> 
$test</center></TD><TD>Audio File</TD></TR>\n");
	}


	elseif(strstr($npart,".html")||strstr($npart,".log"))
        {


                $fsize = filesize($dir."/".$npart);
                $test=formatSize($fsize);

                print("<tr class='musicfile'><TD><a href='$npart'>$npart</a></TD><TD align='right'><center>
$test</center></TD><TD>Server log</TD></TR>\n");
        }

	elseif(strstr($npart,".flv") || strstr($npart,".avi")||strstr($npart,".AVI") || 
strstr($npart,".mp4")||strstr($npart,".MP4") || strstr($npart,".MKV")||strstr($npart,".mkv") )
	{
		$fsize = filesize($dir."/".$npart);
		$test=formatSize($fsize);

		print("<tr class='vidfile'><TD><a href='$npart'>$npart</a></TD><TD align='right'><center> 
$test</center></TD><TD>Video File</TD></TR>\n");
	}
    }/*5*/

  }/*1*/
}
?>
    </table>

</td></tr></table>
</BODY>
<footer>
</footer>
</HTML>
