#!/bin/bash
# 
# Create a role that has full rights over the site, sensor, and data indices
#
#set -x
curl -s -X POST -u ${ELASTICUSER}:${ELASTICPASS} --header "Content-Type: application/json" -d @- ${ELASTICURL}/_xpack/security/role/iot_admin <<EOF
{
  "cluster": ["all"],
  "indices": [
    {
      "names": [ "site", "sensor", "data-*" ],
      "privileges": ["all"]
    }
  ]
}
EOF

#
# 
curl -s -X POST -u ${ELASTICUSER}:${ELASTICPASS} --header "Content-Type: application/json" -d @- ${ELASTICURL}/_xpack/security/user/iot_admin <<EOF
{
  "password" : "AllYourBitsAreBelongToYou",
  "roles" : [ "admin", "iot_admin" ],
  "full_name" : "IoT Admin",
  "email" : "elk@accelerando.com.au"
}
EOF
