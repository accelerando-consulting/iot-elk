#!/bin/bash
curl -s -X PUT -u ${ELASTICUSER}:${ELASTICPASS}  --header "Content-Type: application/json" -d @- ${ELASTICURL}/_template/location <<EOF
{
  "order": 0,
  "index_patterns": "data-*",
  "settings": {},
  "mappings": {
        "properties": {
	      "location": {
	              "type": "geo_point"
	      }
	}
  }
}
EOF
