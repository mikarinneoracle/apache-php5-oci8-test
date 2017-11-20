<?php

$username = getenv('DB_USERNAME') ? getenv('DB_USERNAME') : '';
$password = getenv('DB_PASSWORD') ? getenv('DB_PASSWORD') : '';
$connect = getenv('DB_CONNECT') ? getenv('DB_CONNECT') : '';

echo $username . "<br>\n";
echo $password . "<br>\n";
echo $connect . "<p>\n";

$conn = oci_connect($username, $password, $connect, '', OCI_SYSDBA);

$query = 'select sysdate from dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);

while ($row = oci_fetch_array($stid, OCI_ASSOC + OCI_RETURN_NULLS)) {
    echo ($row['SYSDATE']);
}
