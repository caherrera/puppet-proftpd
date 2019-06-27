define proftpd::user (
  $sql_backend     = 'mysql',
  $sql_host        = 'localhost',
  $sql_dbname      = 'proftpd',
  $sql_username    = 'proftpd',
  $sql_password    = 'jhf64342tVVRvS',
  $sql_user_table  = 'ftpuser',
  $sql_group_table = 'ftpgroup',
  $admin_user      = $sql_username,
  $admin_pass      = $sql_password,
  $user            = $title,
  $password        = "password",
  $uid             = 5500,
  $gid             = 5500,
  $homedir         = "/home/${user}",
  $shell           = '/sbin/noshell'
) {

  $mysql = "/usr/bin/mysql -h${sql_host} -u${admin_user} -p${admin_pass} ${sql_dbname}"
  $mysql_query = "$mysql -e \"show tables like '$sql_user_table' ;\"  "
  $unless = "test $($mysql_query 2>/dev/null | sed 1d) -eq 0 "


  $sql = join(["REPLACE into $sql_user_table (userid,passwdcrypt,uid,gid,homedir,shell)",
    " values ('${user}','${password}','${uid}','${gid}','${homedir}','${shell}');"],' ')


  exec { "import-$sql_dbname-$user":
    command => "$mysql -e \"$sql\"",
    path    => '/usr/bin:/usr/sbin:/bin',
    unless  => $unless
  }


}