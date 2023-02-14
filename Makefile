COUNTER := 1

.PHONY: all
all: up terraform wait cartography

.PHONY: up
up:
	# docker compose build
	docker compose up -d neo4j moto

.PHONY: down
down:
	docker compose down

.PHONY: terraform
terraform:
	docker compose run --rm terraform

.PHONY: wait
wait:
	$(info Waiting for neo4j to start...)
	@while [[ -z "$$(docker compose logs neo4j | grep Started)" && $$COUNTER -le 10 ]]; do \
		sleep 1; \
		((COUNTER = COUNTER + 1)); \
	done
	@if [[ $(COUNTER) -gt 10 ]]; then \
		echo "Neo4j failed to start"; \
		exit 1; \
	else \
		echo "Neo4j started"; \
	fi

.PHONY: cleanup
cleanup: down
	rm -rf .terraform/{terraform.tfstate, terraform.tfstate.backup}

.PHONY: cartography
cartography:
	docker compose run --rm cartography
