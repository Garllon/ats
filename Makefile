setup:
	([ ! -f env.development ] && cp env.example env.development) || true
	docker compose -f docker-compose.yml build
	docker compose -f docker-compose.yml run --rm development bundle exec rails db:create
	docker compose -f docker-compose.yml run --rm development bundle exec rails db:migrate
	echo 'Successfully finished setup.'

terminal:
	docker compose -f docker-compose.yml run --rm development bash

console:
	docker compose -f docker-compose.yml run --rm development bundle exec rails c

development:
	docker compose -f docker-compose.yml up development

seed:
	docker compose -f docker-compose.yml run --rm development bundle exec rails db:seed
