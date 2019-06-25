class proftpd::importdb (
  $sql_backend     = 'mysql',
  $sql_host        = 'localhost',
  $sql_dbname      = 'proftpd',
  $sql_username    = 'proftpd',
  $sql_password    = 'jhf64342tVVRvS',
  $sql_user_table  = 'ftpuser',
  $sql_group_table = 'ftpgroup',
  $admin_user      = $sql_username,
  $admin_pass      = $sql_password,
  Boolean $import  = true,
) {
  $dump = "/root/${sql_dbname}.sql"
  file { $dump:
    content => template('proftpd/proftpd.sql.erb'),


  }

  if $import {
    $mysql = "mysql -h${sql_host} -u${admin_user} -p${admin_pass} ${sql_dbname}"
    exec { "import-$sql_dbname":
      command => "$mysql < $dump",
      path    => '/usr/bin:/usr/sbin:/bin',
      unless  => "$mysql -e \"show tables\" 2>/dev/null"
    }
  }


}