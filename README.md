# Saltstack Learn-Environment with Docker
This repository was created to help me to get familiar with saltstack, without having to create and configure VMs. Instead I use Docker and Docker-Compose. While running salstack in Docker has its limitations, I found it helpful to get started with most basic concepts. 

For any improvments on the dockerfiles and how things are done, don't hestitate to let me know :)

Salstack was installed with the [bootstrap script](https://docs.saltproject.io/en/getstarted/fundamentals/install.html) which can be downloaded as followed:

    curl -L https://bootstrap.saltstack.com -o install_salt.sh

Docker compose is configured to mount the [srv/](srv/) path to `salt-master`, so that you can directly create and edit state files, while all salt machines are up and running. 

Whatever you install in the containers will stay as long you don't rebuild the docker images e.g.:

    docker compose up -d --build

## Simple runbook to test the setup

    # startup salt master and minion
    docker compose up -d

    # apply the salt state from `srv/salt` folder
    docker compose exec -it salt-master salt 'minion' state.apply file

    # verify if the file was created on the minion
    docker compose exec -it salt-master salt 'minion' cmd.run 'cat /test/file.txt'

    # shut down salt master and minion
    docker compose down

## Additional configuration options

You can set environment variables in [docker-compose.yaml](docker-compose.yaml) for additional control:

|ENV| Description |
|---|---|
| `LOG_LEVEL`  |set salt machine logs to e.g. `debug` or `info`   |
|`MINION_NAME` |allows to specify the name of the minion  |

## Useful saltstack commands

    # on salt-master
    # test connectivity to minion
    salt minion test.ping

    # check if minion is accepted by master
    salt-key -L

    # check status of minions
    salt-run manage.up
    salt-run manage.stats
    salt-run manage.down