ARG build_tag
FROM chembience/django-base:$build_tag
LABEL maintainer="markus.sitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get -y --no-install-recommends install \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

RUN chown -R www-data.www-data /home/nginx && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default && \
    ln -s /home/nginx/nginx.conf /etc/nginx/sites-enabled/ && \
    ln -s /home/nginx/supervisord.conf /etc/supervisor/conf.d/

EXPOSE 80
CMD ["/home/nginx/run.sh"]