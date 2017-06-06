# FROM shifudao/gollum:latest
FROM widla/gollum-material-ui:develop

COPY lib/ /usr/local/bundle/gems/gollum-4.1.1/lib

WORKDIR /wiki
EXPOSE 4567

CMD ["gollum", "--allow-uploads", "page", "--base-path", "/wiki"]