# remotato

Deploy little docker containers with ssh servers to simulate VMs.

## Usage

generate ssh keys for passwordless ssh access
`ssh-keygen -t rsa -f remotato_key`


build & launch containers (3 by default, edit docker-compose to change)
`docker compose up -d --build`


ssh into a container (default ports are 2222 - 2224)
`ssh user@localhost -p 2222 -i remotato_key`


## Notes

check what's running / stop / destroy
`docker compose ps`
`docker compose stop`
`docker compose down`

for testing just one container
`docker build -t remo . && docker run -d --rm -p 2222:22 --name remo-cont remo`

