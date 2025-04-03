#!/usr/bin/env bash
# From https://github.com/vishnubob/wait-for-it

host="$1"
port="$2"
shift 2

timeout="${WFI_TIMEOUT:-15}"

until timeout "$timeout" bash -c "</dev/tcp/$host/$port" 2>/dev/null; do
  echo "⏱️ En attente de la connexion à $host:$port..."
  sleep 2
done

echo "✅ $host:$port est maintenant disponible"
exec "$@"
