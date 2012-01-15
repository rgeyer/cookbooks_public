maintainer       "RightScale, Inc."
maintainer_email "support@rightscale.com"
license          IO.read(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'LICENSE')))
description      "Installs/configures a MySQL database server with automated backups."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

depends "db"
depends "block_device"
depends "sys_dns"
depends "rs_utils"

recipe  "db_mysql::default", "Runs the client 'db::install_server' recipes."

attribute "db_mysql",
  :display_name => "General Database Options",
  :type => "hash"
  
attribute "db/admin/user",
  :display_name => "Database Admin Username",
  :description => "The username of the database user that has 'admin' privileges.",
  :required => true,
  :recipes => [ "db_mysql::setup_admin_privileges" ]

attribute "db/admin/password",
  :display_name => "Database Admin Password",
  :description => "The password of the database user that has 'admin' privileges.",
  :required => true,
  :recipes => [ "db_mysql::setup_admin_privileges" ]
  
attribute "db/application/user",
  :display_name => "Database Application Username",
  :description => "The username of the database user that has 'user' privileges.",
  :required => true,
  :recipes => [ "db_mysql::setup_application_privileges" ]

attribute "db/application/password",
  :display_name => "Database Application Password",
  :description => "The password of the database user that has 'user' privileges.",
  :required => true,
  :recipes => [ "db_mysql::setup_application_privileges" ]

#
# recommended attributes
#
attribute "db_mysql/server_usage",
  :display_name => "Server Usage",
  :description => "Use 'dedicated' if the mysql config file allocates all existing resources of the machine.  Use 'shared' if the MySQL config file is configured to use less resources so that it can be run concurrently with other apps like Apache and Rails for example.",
  :recipes => [ "db_mysql::default" ],
  :choice => ["shared", "dedicated"],
  :default => "dedicated"

#
# optional attributes
#
attribute "db_mysql/log_bin",
  :display_name => "MySQL Binlog Destination",
  :description => "Defines the filename and location of your MySQL stored binlog files.  This sets the log-bin variable in the MySQL config file.  If you do not specify an absolute path, it will be relative to the data directory. Ex: /mnt/mysql-binlogs/mysql-bin",
  :recipes => [ "db_mysql::default" ],
  :default => "/mnt/mysql-binlogs/mysql-bin"
  
attribute "db_mysql/datadir_relocate",
  :display_name => "MySQL Data-Directory Destination",
  :description => "Sets the final destination of the MySQL data directory. (i.e. an LVM or EBS volume)",
  :default => "/mnt/mysql"


