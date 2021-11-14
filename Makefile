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

get-connectors:
	curl http://localhost:8083/connectors

create-connector:
	curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-postgres.json
	# always, never, initial_only, exported, custom
	# pgoutput wal2json

delete-connector:
	curl -X DELETE http://localhost:8083/connectors/bookings-connector

status-connector:
	curl http://localhost:8083/connectors/bookings-connector/status

check-topic-registery:
	docker-compose exec schema-registry \
	kafka-avro-console-consumer --bootstrap-server kafka:9092 \
	--topic postgres.public.bookings --from-beginning --max-messages 2

kafkacat:
	docker-compose exec kafkacat \
	kafkacat -b kafka:9092 -C -s key=avro -s value=avro \
	-r http://schema-registry:8081 \
	-t postgres.public.bookings -f 'Key: %k\nValue: %s\n'

