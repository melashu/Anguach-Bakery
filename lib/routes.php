<?php

if(isset($_POST['action'])){
  try {
   $con = new PDO("mysql:host=localhost;dbname=your_db", "root", "");
   $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
   $con->setAttribute(PDO::ATTR_PERSISTENT, true);
   if ($con) {
  $stat = $con->prepare("select id from Student");
  $stat->execute();
            $row = $stat->fetchAll(PDO::FETCH_ASSOC);
            if ($row==null) {
                echo 'empty';
            } else {
                echo json_encode($row);
            }
   }
  } catch (PDOException $ex) {
   die($ex->getMessage());
  }
}
 
 

?>