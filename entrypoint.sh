#!/bin/sh
set -xe

# Convert environment variables like THANOS_A_B_C=123 to command line arguments like --a.b.c=123:
args="$(env | grep "^DISC_" | awk -F= -v prefix=DISC_ \
'{
        arg=$1;
        value=$2;
        sub(prefix, "", arg);
        gsub("__", "-", arg);
        gsub("_", ".", arg);
        arg=tolower(arg);
        print "--"arg"="value
}')"

exec /bin/prometheus-ecs-discovery $args "$@"
