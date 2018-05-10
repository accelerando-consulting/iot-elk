if [ -z "$ELASTICSEARCH" ]
then
  if [ -n "$1" ]
  then
        ELASTICSEARCH=$1
        shift
  else
        ELASTICSEARCH=localhost
  fi
fi  
[ -n "$ELASTICSEARCH" ] || ELASTICSEARCH=elasticsearch
[ -n "$ELASTICUSER" ]   || ELASTICUSER=elastic
[ -n "$ELASTICPASS" ]   || ELASTICPASS=changeme
[ -n "$ELASTICPROTO" ]  || ELASTICPROTO=http
[ -n "$ELASTICPORT" ]   || case $ELASTICPROTO in http) ELASTICPORT=9200 ;; https) ELASTICPORT=9243 ;; *) echo "unknown ELASTICPROTO" ; exit 1 ;; esac
[ -n "$ELASTICURL" ]    || ELASTICURL=${ELASTICPROTO}://${ELASTICUSER}:${ELASTICPASS}@${ELASTICSEARCH}:${ELASTICPORT}
export ELASTICURL ELASTICUSER ELASTICPASS
