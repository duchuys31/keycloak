## Build custom docker image
```
docker build . -t olpkeycloak
```
## Run custom docker image
```
source .env
docker compose up -d
```
Keycloak starts in production mode, using only secured HTTPS communication, and is available on https://localhost:8443.

Health check endpoints are available at https://localhost:8443/health, https://localhost:8443/health/ready and https://localhost:8443/health/live.

Opening up https://localhost:8443/metrics leads to a page containing operational metrics that could be used by your monitoring solution.

