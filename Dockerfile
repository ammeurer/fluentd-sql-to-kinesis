FROM fluent/fluentd:latest-onbuild

WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH
ENV AWS_ACCESS_KEY_ID=secret
ENV AWS_SECRET_ACCESS_KEY=secret
USER root
# Run all commands as different layers for development
# Combine commands into one RUN statement for production use
RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN apk update && apk add build-base postgresql-dev libffi-dev

RUN apk --no-cache --update add sudo build-base ruby-dev 
RUN sudo -u fluent gem install fluent-plugin-sql pg fluent-plugin-kinesis
# Must uninstall json gem 2.0.2 because it conflicts with the version of json that fluent-plugin-sql uses
RUN gem uninstall json --version 2.0.2
RUN gem install bigdecimal

RUN rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c
RUN apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

EXPOSE 24284

USER fluent
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
