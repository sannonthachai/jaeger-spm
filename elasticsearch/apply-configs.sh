#!/bin/bash

# Wait for Elasticsearch to be ready
until curl -s http://localhost:9200 -o /dev/null; do
    echo "Waiting for Elasticsearch to start..."
    sleep 5
done

# Apply ILM policy
echo "Applying ILM policy..."
curl -X PUT "http://localhost:9200/_ilm/policy/jaeger-ilm-policy" -H 'Content-Type: application/json' -d @/usr/share/elasticsearch/config/jaeger-ilm-policy.json

# Apply index template
echo "Applying index template..."
curl -X PUT "http://localhost:9200/_template/jaeger-template" -H 'Content-Type: application/json' -d @/usr/share/elasticsearch/config/jaeger-template.json

echo "Configuration applied successfully."
