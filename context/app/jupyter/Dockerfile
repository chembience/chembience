ARG build_label
FROM chembience/jupyter_base:$build_label
LABEL maintainer="markussitzmann@gmail.com "

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get -y --no-install-recommends install \
    nginx \
    supervisor \
    joe \
    && rm -rf /var/lib/apt/lists/*

COPY ./nginx /home/nginx/

RUN chown -R www-data.www-data /home/nginx && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default && \
    ln -s /home/nginx/nginx.conf /etc/nginx/sites-enabled/ && \
    ln -s /home/nginx/sites-includes/ /etc/nginx/ && \
    ln -s /home/nginx/supervisord.conf /etc/supervisor/conf.d/

EXPOSE 8888
CMD ["/home/nginx/run.sh"]