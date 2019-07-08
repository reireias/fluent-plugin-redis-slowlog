FROM fluentd:v1.4-2

USER root
RUN apk add --update git && \
    gem install specific_install && \
    gem specific_install https://github.com/reireias/fluent-plugin-redis-slowlog.git
USER fluent
