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

  $mysql = "mysql -h${sql_host} -u${admin_user} -p${admin_pass} ${sql_dbname}"
  $chk = "count(*) as chk"
  $chktable = "ftpuser"
  $mysql_query = "$mysql -e \"select $chk from $chktable where userid=$user > 0;\"  "
  $unless = "[ \"$($mysql_query | sed 1d )\" == \"0\" ] && exit 0 || exit 1"

  $sql = "insert into $sql_user_table (userid,passwdcrypt,uid,gid,homedir,shell) values ('$user','$password','$uid','$gid
    ','$homedir','$shell');"

  # if $import {

    exec { "import-$sql_dbname-$user":
      command => "$mysql -e \"$sql\"",
      path    => '/usr/bin:/usr/sbin:/bin',
      unless  => $unless
    }
  # }


}