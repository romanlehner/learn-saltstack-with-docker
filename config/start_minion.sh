#!/bin/bash

echo $MINION_NAME > /etc/salt/minion_id

salt-minion -l $LOG_LEVEL