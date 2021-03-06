FROM ruby:alpine
# FROM widla/gollum-material-ui:develop
LABEL maintainer="ouralien@gmail.com"

RUN apk update && \
    apk add make gcc g++ icu-libs icu-dev git && \
    gem install gollum org-ruby asciidoctor github-markdown && \
    apk del make gcc g++ icu-dev && \
    rm -fr /var/cache/apk/* /usr/local/bundle/cache /root/.gem/ /root/.gemrc /root/.ash_history && \
    find /usr/local/bundle/ \( -name 'gem_make.out' -o -name 'mkmf.log' \) -delete

COPY lib2/ /usr/local/bundle/gems/gollum-4.1.2/lib

WORKDIR /wiki
EXPOSE 4567

CMD ["gollum", "--allow-uploads", "page", "--base-path", "/wiki"]