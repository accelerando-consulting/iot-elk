#!/bin/bash
curl -s -X PUT -u ${ELASTICUSER}:${ELASTICPASS}  --header "Content-Type: application/json" -d @- ${ELASTICURL}/_template/default_location <<EOF
{
  "order": 0,
  "template": "*",
  "settings": {},
  "mappings": {
    "_default_": {
      "properties": {
        "coordinates": {
          "type": "geo_point"
        }
      }
    }
  }
}
EOF

exit 0
# FIXME: un-bork this

curl -s -X PUT -u ${ELASTICUSER}:${ELASTICPASS} --header "Content-Type: application/json" -d @- ${ELASTICURL}/_template/default_percolator <<EOF
{
  "template": "data-*",
  "order": 1,
  "settings": {},
  "mappings": {
    "doctype": {
      "properties": {
        "coordinates": {
          "type": "geo_point"
        }
      }
    },
    "queries" {
      "properties": {
        "query": {
           "type": "percolator"
	 }	   	     
      }
    }
  }
}
EOF
