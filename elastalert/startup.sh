#! /bin/bash

sed "s/\$HOST_ES/$HOST_ES/" config.yaml.template > config.yaml
sed -i "s/\$PORT_ES/$PORT_ES/" config.yaml

elastalert-create-index
elastalert --config config.yaml --verbose --rule frequency.yaml
