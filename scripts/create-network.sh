#!/bin/bash

NETWORK=ca_net
if [ -z "$(docker network ls | grep $NETWORK)" ]; then
  # basic network not exited, create it
  docker network create --attachable $NETWORK
fi