#!/bin/bash
# 
# Create a role that has full rights over the schema, participant and dataset indices
#
#set -x
curl -s -X POST -u ${ELASTICUSER}:${ELASTICPASS} --header "Content-Type: application/json" -d @- ${ELASTICURL}/_xpack/security/role/iotadmin <<EOF
{
  "cluster": ["all"],
  "indices": [
    {
      "names": [ "schema", "participant", "dataset", "dataset-*" ],
      "privileges": ["all"]
    }
  ]
}
EOF

#
# 
curl -s -X POST -u ${ELASTICUSER}:${ELASTICPASS} --header "Content-Type: application/json" -d @- ${ELASTICURL}/_xpack/security/user/iotadmin <<EOF
{
  "password" : "AllYourBitsAreBelongToYou",
  "roles" : [ "admin", "iotadmin" ],
  "full_name" : "IoT Admin",
  "email" : "iotadmin@example.com"
}
EOF
