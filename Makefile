pull:
	docker-compose pull

up:
	docker-compose up -d

logs:
	docker-compose logs -f

ps:
	docker-compose ps
	
down:
	docker-compose down -v

kafka:
	docker-compose up -d zookeeper
	sleep 5
	docker-compose up -d kafka
	sleep 5
	docker-compose up -d schema-registry connect kafkacat

start-mysql:
	docker-compose up -d mysql

stop-mysql:
	docker-compose stop mysql
	echo y | docker-compose rm mysql

pinot:
	docker-compose up -d zookeeper
	sleep 5
	docker-compose up -d pinot-controller
	sleep 5
	docker-compose up -d pinot-broker
	sleep 5
	docker-compose up -d pinot-server

get-connectors:
	curl http://localhost:8083/connectors

create-connector:
	# curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-mysql.json
	curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-mysql-v2.json

delete-connector:
	curl -X DELETE http://localhost:8083/connectors/ad_click-connector

status-connector:
	curl http://localhost:8083/connectors/ad_click-connector/status

check-topic-registery:
	docker-compose exec schema-registry \
	kafka-avro-console-consumer --bootstrap-server kafka:9092 \
	--topic dbz.mysql.events_db.ad_click --from-beginning --max-messages 2

kafkacat:
	# docker-compose exec kafkacat \
	# kafkacat -b kafka:9092 -C -s key=avro -s value=avro \
	# -r http://schema-registry:8081 \
	# -t dbz.mysql.events_db.ad_click -f 'Key: %k\nValue: %s\n'
	docker-compose exec kafkacat \
	kafkacat -b kafka:9092 -C -t dbz.mysql.json.events_db.ad_click -f 'Key: %k\nValue: %s\n'

topic-list:
	docker-compose exec zookeeper \
	kafka-topics --list --zookeeper localhost:2181