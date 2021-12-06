FROM ruby:${RUBY_VERSION:-3.0.2-alpine}

ENV LANG=C.UTF-8 \
    GEM_HOME=/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=/bundle \
    BUNDLE_APP_CONFIG=/bundle \
    BUNDLE_BIN=/bundle/bin \
    PATH=/usr/src/app/backend/bin:/bundle/bin:$PATH

# build-base, xz-dev -- nokogiri
# git - to update bundler audit
# gcompat - grpc
# postgresql-client - for pg_dump thats used to make structure.sql [supports pg enums]
# postgresql-dev - pg
# tzdata - tzinfo-data to prevent TZInfo::DataSourceNotFound: tzinfo-data is not present on rails db create/migrate/etc.
# vim - edit credentials
# vips, libjpeg-turbo - image processing
RUN apk add --update --no-cache \
        build-base \
        git \
        gcompat \
        libjpeg-turbo \
        postgresql-client \
        postgresql-dev \
        tzdata \
        vim \
        vips \
        xz-dev \
    && ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime \
    && echo "Europe/Moscow" > /etc/timezone \
    && echo 'gem: --no-document' >> ~/.gemrc \
    && cp ~/.gemrc /etc/gemrc \
    && chmod +r /etc/gemrc \
    && gem install bundler -v '~> 2' \
    ;

WORKDIR /usr/src/app

COPY . .
