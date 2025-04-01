#!/bin/bash

echo "Kafka Connect 실행 시작"
/etc/confluent/docker/run &

# Kafka Connect 기동 대기
echo "Kafka Connect 부팅 대기 중..."
until $(curl --output /dev/null --silent --head --fail http://localhost:8083/connectors); do
    printf '.'
    sleep 3
done

echo -e "\nKafka Connect 준비 완료. 커넥터 등록 시작"

echo "등록할 JSON 파일들:"
ls /kafka-connect/connectors

for f in /kafka-connect/connectors/*.json; do
    echo "등록 중: $f"
    RESPONSE=$(envsubst < "$f" | curl -s -o /dev/stderr -w "%{http_code}" -X POST -H "Content-Type: application/json" --data @- http://localhost:8083/connectors)
    echo "응답 코드: $RESPONSE"
done

# Kafka Connect foreground 프로세스 대기
wait
