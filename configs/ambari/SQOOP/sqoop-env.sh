
# Set Hadoop-specific environment variables here.

#Set path to where bin/hadoop is available
#Set path to where bin/hadoop is available
export HADOOP_HOME=${HADOOP_HOME:-{{hadoop_home}}}

#set the path to where bin/hbase is available
export HBASE_HOME=${HBASE_HOME:-{{hbase_home}}}

#Set the path to where bin/hive is available
export HIVE_HOME=${HIVE_HOME:-{{hive_home}}}

#Set the path for where zookeper config dir is
export ZOOCFGDIR=${ZOOCFGDIR:-/etc/zookeeper/conf}

# add libthrift in hive to sqoop class path first so hive imports work
export SQOOP_USER_CLASSPATH="`ls ${HIVE_HOME}/lib/libthrift-*.jar 2> /dev/null`:${SQOOP_USER_CLASSPATH}"