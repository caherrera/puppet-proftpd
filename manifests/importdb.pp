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
  $mysql = "mysql -h${sql_host} -u${admin_user} -p${admin_pass} ${sql_dbname}"
  $chk = "sum(DATA_LENGTH+INDEX_LENGTH) as chk"
  $chktable = "information_schema.TABLES"
  $mysql_query = "$mysql -e \"select $chk from $chktable where TABLE_SCHEMA='$sql_dbname' and TABLE_ROWS > 0;\"  "
  $unless="[ \"$($mysql_query | sed 1d )\" == \"0\" ] && exit 0 || exit 1"

  if $import {

    exec { "import-$sql_dbname":
      command => "$mysql < $dump",
      path    => '/usr/bin:/usr/sbin:/bin',
      unless  => $unless
    }
  }


}