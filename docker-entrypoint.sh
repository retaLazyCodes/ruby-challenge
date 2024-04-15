#!/bin/bash
set -e

if [ -z "$(ls -A /rails/db)" ]; then
  echo "Inicializando base de datos..."
  bundle exec rake db:create
  bundle exec rake db:migrate
  bundle exec rake features:fetch
fi

exec "$@"
