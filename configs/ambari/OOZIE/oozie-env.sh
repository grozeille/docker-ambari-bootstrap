
#!/bin/bash

if [ -d "/usr/lib/bigtop-tomcat" ]; then
  export OOZIE_CONFIG=${OOZIE_CONFIG:-{{conf_dir}}}
  export CATALINA_BASE=${CATALINA_BASE:-{{oozie_server_dir}}}
  export CATALINA_TMPDIR=${CATALINA_TMPDIR:-/var/tmp/oozie}
  export OOZIE_CATALINA_HOME=/usr/lib/bigtop-tomcat
fi

#Set JAVA HOME
export JAVA_HOME={{java_home}}

export JRE_HOME=${JAVA_HOME}

# Set Oozie specific environment variables here.

# Settings for the Embedded Tomcat that runs Oozie
# Java System properties for Oozie should be specified in this variable
#
{% if java_version < 8 %}
export CATALINA_OPTS="$CATALINA_OPTS -Xmx{{oozie_heapsize}} -XX:MaxPermSize={{oozie_permsize}}"
{% else %}
export CATALINA_OPTS="$CATALINA_OPTS -Xmx{{oozie_heapsize}}"
{% endif %}
# Oozie configuration file to load from Oozie configuration directory
#
# export OOZIE_CONFIG_FILE=oozie-site.xml

# Oozie logs directory
#
export OOZIE_LOG={{oozie_log_dir}}

# Oozie pid directory
#
export CATALINA_PID={{pid_file}}

#Location of the data for oozie
export OOZIE_DATA={{oozie_data_dir}}

# Oozie Log4J configuration file to load from Oozie configuration directory
#
# export OOZIE_LOG4J_FILE=oozie-log4j.properties

# Reload interval of the Log4J configuration file, in seconds
#
# export OOZIE_LOG4J_RELOAD=10

# The port Oozie server runs
#
export OOZIE_HTTP_PORT={{oozie_server_port}}

# The admin port Oozie server runs
#
export OOZIE_ADMIN_PORT={{oozie_server_admin_port}}

# The host name Oozie server runs on
#
# export OOZIE_HTTP_HOSTNAME=`hostname -f`

# The base URL for callback URLs to Oozie
#
# export OOZIE_BASE_URL="http://${OOZIE_HTTP_HOSTNAME}:${OOZIE_HTTP_PORT}/oozie"
export JAVA_LIBRARY_PATH={{hadoop_lib_home}}/native/Linux-{{architecture}}-64

# At least 1 minute of retry time to account for server downtime during
# upgrade/downgrade
export OOZIE_CLIENT_OPTS="${OOZIE_CLIENT_OPTS} -Doozie.connection.retry.count=5 "

{% if sqla_db_used or lib_dir_available %}
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:{{jdbc_libs_dir}}"
export JAVA_LIBRARY_PATH="$JAVA_LIBRARY_PATH:{{jdbc_libs_dir}}"
{% endif %}