#/bin/bash

set -x

if [[ -z "${PHOENIX_PROJECT_NAME}" ]]; then
  echo "PHOENIX_PROJECT_NAME environment var not defined"
  exit 1
else
  echo "creating project $PHOENIX_PROJECT_NAME"
fi

# if the project directory doesn't exist, make it
if [ ! -d "$PHOENIX_PROJECT_NAME" ]; then
  # cd into hello_world and run 'mix phx.new hello_world'
  echo yes | mix phx.new $PHOENIX_PROJECT_NAME
  cd $PHOENIX_PROJECT_NAME
  echo yes | mix deps.get
fi

#TODO: change config files for the phoenix project to use 0.0.0.0 for listening address and Port to listne on
# sed config file <project_name>/config/config.exs
# url: [host:"x.x.x.x"],   --->  url: [host:"0.0.0.0"],
sed -i "s/url: \[host: \".*\"\]/url: [host: \"0.0.0.0\"]/" config/config.exs

# sed config file <project_name>/config/dev.exs
# username: "postgres",  --->  username: "<PHOENIX_PROJECT_DB_USER>",
sed -i "s/username: \".*\"/username: \"$PHOENIX_PROJECT_DB_USER\"/" config/dev.exs
# password: "postgres",  --->  password: "<PHOENIX_PROJECT_DB_PASSWORD>",
sed -i "s/password: \".*\"/password: \"$PHOENIX_PROJECT_DB_PASSWORD\"/" config/dev.exs
# hostname: "localhost", --->  hostname: "attendance_organizer",

PHOENIX_PROJECT_DB_HOSTNAME="${PHOENIX_PROJECT_NAME}_DB"
sed -i "s/hostname: \".*\"/hostname: \"$PHOENIX_PROJECT_DB_HOSTNAME\"/" config/dev.exs
# database: "hello_world_dev", --->  database: "<PHOENIX_PROJECT_DB_NAME>",
sed -i "s/database: \".*\"/database: \"$PHOENIX_DB_NAME\"/" config/dev.exs
# ...
# http: [ip:{127, 0, 0, 1}, port: 4000], ---> http: [ip:{0, 0, 0, 0}, port: <PHOENIX_PROJECT_PORT>],
sed -i "s/http:.*,/http: [ip: {0, 0, 0, 0}, port: $PHOENIX_PROJECT_PORT],/" config/dev.exs

# sed -i "s/http: \[ip:{[0-9]*, [0-9]*, [0-9]*, [0-9]*}, port: [0-9]*\]}/http: [ip: {0, 0, 0, 0}, port: $PHOENIX_PROJECT_PORT]/" config/dev.exs

# env vars
# ARG PROJECT_NAME
# ENV PHOENIX_PROJECT_NAME=$PROJECT_NAME

# ARG PHOENIX_PORT
# ENV PHOENIX_PROJECT_PORT=$PHOENIX_PORT

# ARG PHOENIX_DB_NAME
# ENV PHOENIX_PROJECT_DB_NAME=$PHOENIX_DB_NAME

# ARG PHOENIX_DB_USER
# ENV PHOENIX_PROJECT_DB_USER=$PHOENIX_DB_USER

# ARG PHOENIX_DB_PASSWORD
# ENV PHOENIX_PROJECT_DB_PASSWORD=$PHOENIX_DB_PASSWORD