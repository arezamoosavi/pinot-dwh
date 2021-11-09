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

kafkacat:
	docker-compose exec kafkacat \
	kafkacat -b kafka:9092 -C -s key=avro -s value=avro \
	-r http://schema-registry:8081 \
	-t postgres.public.bookings -f 'Key: %k\nValue: %s\n'

