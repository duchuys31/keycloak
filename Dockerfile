FROM quay.io/keycloak/keycloak:latest as builder
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange,recovery-codes
ENV KC_DB=postgres

WORKDIR /opt/keycloak
COPY keywind.jar /opt/keycloak/providers/
RUN keytool -genkeypair -storepass password -storetype PKCS12 -keyalg RSA -keysize 2048 -dname "CN=server" -alias server -ext "SAN:c=DNS:localhost,IP:127.0.0.1" -keystore conf/server.keystore

ADD --chown=keycloak:keycloak https://repo1.maven.org/maven2/io/phasetwo/keycloak/keycloak-magic-link/0.20/keycloak-magic-link-0.20.jar /opt/keycloak/providers/keycloak-magic-link-0.20.jar
ADD --chown=keycloak:keycloak https://repo1.maven.org/maven2/io/phasetwo/keycloak/keycloak-events/0.20/keycloak-events-0.20.jar /opt/keycloak/providers/keycloak-events-0.20.jar

RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
