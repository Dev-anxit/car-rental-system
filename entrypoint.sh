#!/bin/bash
set -e

# If cloud environment (Render, Railway, Cloud Run) passes $PORT, adjust Tomcat HTTP connector
if [ -n "$PORT" ]; then
    echo "[Entrypoint] Configuring Apache Tomcat to listen on PORT=$PORT"
    sed -i "s/port=\"8080\"/port=\"$PORT\"/g" /usr/local/tomcat/conf/server.xml
fi

exec catalina.sh run
