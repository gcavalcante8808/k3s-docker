#!/bin/bash

current_dir=$(pwd)
alias k3sctl="docker-compose -f ${current_dir}/docker-compose.yml exec node1 k3s kubectl"
