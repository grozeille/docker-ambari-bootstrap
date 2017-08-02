
# Set environment variables here.

# AMS instance name
export AMS_INSTANCE_NAME={{hostname}}

# The java implementation to use. Java 1.6 required.
export JAVA_HOME={{java64_home}}

# Collector Log directory for log4j
export AMS_COLLECTOR_LOG_DIR={{ams_collector_log_dir}}

# Monitor Log directory for outfile
export AMS_MONITOR_LOG_DIR={{ams_monitor_log_dir}}

# Collector pid directory
export AMS_COLLECTOR_PID_DIR={{ams_collector_pid_dir}}

# Monitor pid directory
export AMS_MONITOR_PID_DIR={{ams_monitor_pid_dir}}

# AMS HBase pid directory
export AMS_HBASE_PID_DIR={{hbase_pid_dir}}

# AMS Collector heapsize
export AMS_COLLECTOR_HEAPSIZE={{metrics_collector_heapsize}}

# HBase Tables Initialization check enabled
export AMS_HBASE_INIT_CHECK_ENABLED={{ams_hbase_init_check_enabled}}

# AMS Collector options
export AMS_COLLECTOR_OPTS="-Djava.library.path=/usr/lib/ams-hbase/lib/hadoop-native"
{% if security_enabled %}
export AMS_COLLECTOR_OPTS="$AMS_COLLECTOR_OPTS -Djava.security.auth.login.config={{ams_collector_jaas_config_file}}"
{% endif %}

# AMS Collector GC options
export AMS_COLLECTOR_GC_OPTS="-XX:+UseConcMarkSweepGC -verbose:gc -XX:+PrintGCDetails -XX:+PrintGCDateStamps -Xloggc:{{ams_collector_log_dir}}/collector-gc.log-`date +'%Y%m%d%H%M'`"
export AMS_COLLECTOR_OPTS="$AMS_COLLECTOR_OPTS $AMS_COLLECTOR_GC_OPTS"

# Metrics collector host will be blacklisted for specified number of seconds if metric monitor failed to connect to it.
export AMS_FAILOVER_STRATEGY_BLACKLISTED_INTERVAL={{failover_strategy_blacklisted_interval}}

# Extra Java CLASSPATH elements for Metrics Collector. Optional.
export COLLECTOR_ADDITIONAL_CLASSPATH={{ams_classpath_additional}}