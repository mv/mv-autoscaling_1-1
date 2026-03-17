#!/usr/bin/env bash
#
# ferreira.mv
# 2024-11

# to be rendered
connection_info="${placeholder}"

usage() {
  echo
  echo "Usage: $0 -options"
  echo
  echo "Get SSM values for 'connection-info'"
  echo "   -h: this help"
  echo "   -d: use defaults."
  echo "   -c: connect-info. Default: [$connection_info]"
  echo "   -p: generate 'psql' command line"
  echo "   -s: generate 'sqlcmd' command line"
  echo
  echo "Current SSM path: [$connection_info]"
  echo
  echo "Examples:"
  echo "   $0 -d"
  echo "   $0 -c /ssm/path/to/connection-info -p"
  echo "   $0 -p"
  echo "   $0 -s"
  echo "   $0 -ps"
  echo
  exit 1
}


[ -z "$1" ] && usage

while getopts "hdc:ps" opt
do
  echo "Opt: [$opt]"
  case "$opt" in
    h) usage
       ;;
    d) connection_info="$connection_info"
       ;;
    c) connection_info="$OPTARG"
       ;;
    p) _psql=true
       ;;
    s) _sqlcmd=true
       ;;
    *) usage
       ;;
    esac
done

echo
echo "SSM parameters path: [$connection_info]"

json=$( aws ssm get-parameter --name $connection_info --with-decryption --query Parameter.Value --output json | jq -r)

db_host=$(       echo $json | jq -r .host )
db_port=$(       echo $json | jq -r .port )
db_admin_user=$( echo $json | jq -r .db_admin_user )
db_admin_pass=$( echo $json | jq -r .db_admin_pass )

echo
echo $json | jq
echo

psql() {
  echo
  echo "## Remote: inside VPC"
  echo "PGPASSWORD='$db_admin_pass' psql -U $db_admin_user -h $db_host -p $db_port -l"
  echo
  echo "## Local: Port Forward"
  echo "PGPASSWORD='$db_admin_pass' psql -U $db_admin_user -h localhost -p $db_port -l"
  echo
}

sqlcmd() {
  echo
  echo "export SQLCMDUSER=$db_admin_user"
  echo "export SQLCMDPASSWORD=$db_admin_pass"
  echo
  echo "## Remote: inside VPC"
  echo "export SQLCMDSERVER=$db_host"
  echo
  echo "## Local: Port Forward"
  echo "export SQLCMDSERVER=localhost"
  echo
  echo "sqlcmd -Q 'select name from sys.databases;'"
  echo "sqlcmd -Q 'select @@VERSION'"
  echo "sqlcmd"
  echo
}


if [ "$_psql" == "true" ]
then
  echo "## psql"
  psql
  psql > pg.sh
  chmod +x pg.sh
  echo "## Generated: ./pg.sh"
  echo
fi

if [ "$_sqlcmd" == "true" ]
then
  echo "## sqlcmd"
  sqlcmd
  sqlcmd > sqlcmd.sh
  chmod +x sqlcmd.sh
  echo "## Generated: ./sqlcmd.sh"
  echo
fi
