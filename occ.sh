#!/bin/bash
docker-compose exec --user www-data app php occ
#docker-compose exec --user www-data app php occ db:add-missing-indices
#docker-compose exec --user www-data app php occ db:convert-filecache-bigint
