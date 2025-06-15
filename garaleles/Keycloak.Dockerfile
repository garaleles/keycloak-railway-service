    # Railway için optimize edilmiş Keycloak Dockerfile
    FROM quay.io/keycloak/keycloak:23.0

    # Gerekli hazırlıklar
    USER root
    WORKDIR /opt/keycloak

    # Realm yapılandırma dosyasını kopyala
    COPY keycloak-realm-config.json /opt/keycloak/data/import/

    # Ortam Değişkenleri
    ENV KC_PROXY=edge
    ENV KC_DB=postgres
    ENV KC_HEALTH_ENABLED=true
    ENV KC_METRICS_ENABLED=true

    # Keycloak user'a geri dön
    USER 1000

    # Keycloak'ı build et (production için optimize)
    RUN /opt/keycloak/bin/kc.sh build

    # Port expose
    EXPOSE 8080

    # Keycloak'ı başlat
    ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
    CMD ["start", "--import-realm"]
