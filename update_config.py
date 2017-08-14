#!/usr/bin/env python

from ambari_cli.ambariClient import AmbariClient
from requests import Session
import logging
import os
import json
import sys
import time
import argparse
import deploy

if __name__ == "__main__":

    # logging configuration
    logFormatter = logging.Formatter("%(asctime)s [%(threadName)-12.12s] [%(levelname)-5.5s]  %(message)s")
    rootLogger = logging.getLogger()
    rootLogger.setLevel(logging.DEBUG)

    consoleHandler = logging.StreamHandler()
    consoleHandler.setFormatter(logFormatter)
    rootLogger.addHandler(consoleHandler)

    parser = argparse.ArgumentParser(description='Update configuration')
    parser.add_argument('--ambari-host',
                        dest='ambari_host',
                        required=True,
                        help='hostname of the ambari server')
    parser.add_argument('--cluster-name',
                        dest='cluster_name',
                        default="hdp",
                        help='name of the cluster')
    parser.add_argument('--ambari-port',
                        dest='ambari_port',
                        type=int,
                        default=8080,
                        help='ambari port')

    args = parser.parse_args()

    config_folder = "configs/ambari"

    ambari_client = AmbariClient()
    ambari_client.connect(args.ambari_host, args.cluster_name , port=args.ambari_port)

    host_groups = deploy.build_host_groups(config_folder, 1, args.cluster_name)

    logging.info(host_groups)

    ambari_client.dump_config(config_folder, host_groups)
