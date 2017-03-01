#!/bin/bash
docker rm  -f -v $(docker ps -a -q -f status=exited)
docker rmi -f $(docker images -f "dangling=true" -q)
docker volume rm $(docker volume ls -qf dangling=true)
exit 0
