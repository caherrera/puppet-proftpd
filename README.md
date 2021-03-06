Puppet module for ProFTPd (http://proftpd.open-source-solution.org/)

Description
-------------

This is a comprehensive Puppet module for managing ProFTPd. It replicates the Apache model for storing and enabling modules through the mods-enabled/mods-available model.

Dependencies
--------------
This module uses the fact osfamily which is supported by Facter 1.6.1+.

This module depends on creates_resources function which is introduced in Puppet 2.7. Users on puppet 2.6 can use th
e following module which provides this functionality:

[http://github.com/puppetlabs/puppetlabs-create_resources](http://github.com/puppetlabs/puppetlabs-create_resources
)


Usage
-------
```
node 'server.domain.com' {
  class { proftpd::server:
    config_hash => {
      'server_name'  => 'Adams FTP Server',
      'tls_engine'   => 'off',
      'sql_engine'   => 'on',
      'sql_backend'  => 'mysql',
      'sql_host'     => 'dbhost',
      'sql_dbname'   => 'adam_proftpd',
      'sql_username' => 'adam_proftpd',
      'sql_password' => 'topsecretpassword',
    },
  }
}
```
License
-------

Apache license v2.0

Contact
-------

Carlos Herrera <caherrera@gmail.com>

Support
-------

Please log tickets and issues at [https://github.com/caherrera/puppet-proftpd/issues](https://github.com/caherrera/puppet-proftpd/issues)
