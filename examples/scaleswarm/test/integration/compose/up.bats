#!/usr/bin/env bats

load compose_helpers

function teardown() {
	swarm_manage_cleanup
	stop_docker
}

@test "docker-compose up" {
	start_docker_with_busybox 2
	swarm_manage
	FILE=$TESTDATA/compose/simple.yml

	docker-compose_swarm -f $FILE up -d

	run docker_swarm ps -q
	[ "${#lines[@]}" -eq  2 ]
}


