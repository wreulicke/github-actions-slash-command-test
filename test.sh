#!/bin/sh

TARGET=
ENV=
while getopts e:t: OPTION
do
    case $OPTION in
        t) TARGET=".$OPTARG";;
        e) ENV=$OPTARG;;
    esac
done

ENVS=$(cat <<JSON
{
    "infra": {
      "development": {
        "env": "development"
      },
      "staging": {
        "env": "staging"
      },
      "production": {
        "env": "production"
      }
    }
}
JSON
)

if [ -z "$TARGET" ]; then
  TARGET="[]" ## all
fi

matrix=$(echo $ENVS | jq -cr "{ include: [.$TARGET[]] }")
echo ::set-output name=matrix::$matrix