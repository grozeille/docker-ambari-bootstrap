from ambari_cli.ambariClient import AmbariClient
from requests import Session
import logging
import os
import json

def build_host_groups(config_folder, cluster_size, stack_name):
    blueprint_file = os.path.join(config_folder, "blueprint.json")
    with open(blueprint_file, 'r') as file:
        blueprint_json = json.load(file)

    result = []

    for host_group in blueprint_json["host_groups"]:
        name = host_group["name"]
        cluster_host_group = {
            'name': name,
            'hosts': []
        }

        size = 1
        if name == "host_group_datanode":
            size = cluster_size

        for cpt in range(1, size + 1):
            cluster_host_group['hosts'].append(
                {'fqdn': '{0}-ambari-agent-{1}-{2}'.format(stack_name, name[11:], cpt)})

            result.append(cluster_host_group)

    return result

if __name__ == "__main__":

    # logging configuration
    logFormatter = logging.Formatter("%(asctime)s [%(threadName)-12.12s] [%(levelname)-5.5s]  %(message)s")
    rootLogger = logging.getLogger()
    rootLogger.setLevel(logging.INFO)

    consoleHandler = logging.StreamHandler()
    consoleHandler.setFormatter(logFormatter)
    rootLogger.addHandler(consoleHandler)

    logging.info("Deploy ambari blueprint")

    HDP_REPO_URL=os.environ.get('HDP_REPO_URL')
    HDP_UTIL_REPO_URL=os.environ.get('HDP_UTIL_REPO_URL')

    rancher_metadata_session = Session()
    r = rancher_metadata_session.get("http://rancher-metadata/latest/self/stack/name")
    r.raise_for_status()

    stack_name = r.content

    r = rancher_metadata_session.get("http://rancher-metadata/latest/self/stack/services/ambari-agent-datanode/scale")
    r.raise_for_status()

    cluster_size = int(r.content)

    config_folder = "configs/ambari"

    ambari_client = AmbariClient()
    ambari_client.connect('ambari-server', stack_name, port=8080)

    host_groups = build_host_groups(config_folder, cluster_size, stack_name)

    ambari_client.create_cluster(
        config_folder,
        host_groups,
        hdp_repo_url=HDP_REPO_URL,
        hdp_util_repo_url=HDP_UTIL_REPO_URL)
