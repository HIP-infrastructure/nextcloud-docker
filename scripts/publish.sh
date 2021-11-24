#!/bin/sh

# exec 2>>/opt/nextcloud-scripts/trace.log
# set -x

# /opt/nextcloud-scripts/publish.sh %e %a %o %f

# %e	the event type	\OCP\Files::postCreate, \OCP\Files::postWrite or \OCP\Files::postRename
# %i	file id	142430
# %a	actor's user id	bob
# %o	owner's user id	alice
# %n	nextcloud-relative path	alice/files/Pictures/Wonderland/20180717_192103.jpg
# %f	locally available file	/tmp/oc_tmp_m6E6OO-.jpg
# %x	old nextcloud-relative file path (only on rename and copy)	alice/files/Workbench/20180717_192103.jpg
# /opt/nextcloud-scripts/publish.sh %e %i %a %o %f

# echo $@

# curl http://gateway:4000/api/v1/hello
# ./rabbitmqadmin -H hub.thehip.app -u user -p pwd list queues

DATA='{
    "properties":{},
    "routing_key":"red",
    "payload":"'$4'",
    "payload_encoding":"string"
}'

echo $DATA

curl \
    -u user:pwd \
    -H 'Content-Type: application/json' \
    https://hub.thehip.app/api/exchanges/%2F/test-exchange/publish \
    --data "${DATA}"

