FROM nginx:1.28-alpine

ARG GIT_COMMIT=local
ENV APP_COMMIT=${GIT_COMMIT}
ENV NGINX_ENVSUBST_FILTER=^(APP_COMMIT)$

COPY nginx/default.conf.template /etc/nginx/templates/default.conf.template
COPY *.html /usr/share/nginx/html/
COPY CSS/ /usr/share/nginx/html/CSS/
COPY js/ /usr/share/nginx/html/js/
COPY images/ /usr/share/nginx/html/images/
COPY favicon.ico favicon.svg /usr/share/nginx/html/

EXPOSE 80 8081
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD wget -q -O /dev/null http://127.0.0.1/health || exit 1