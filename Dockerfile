FROM fluent/fluentd:latest-onbuild

WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root

RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN apk update && apk add build-base postgresql-dev libffi-dev

RUN apk --no-cache --update add sudo build-base ruby-dev && \
sudo chmod -R ugo+rwx  /usr/lib/ruby/gems/ && \ 
sudo gem update --system && \
    sudo -u fluent gem install fluent-plugin-sql pg fluent-plugin-kinesis json && \
sudo gem pristine gem pristine json --version 2.0.2 && \

    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

EXPOSE 24284

USER fluent
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
