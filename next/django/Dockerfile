ARG build_tag
FROM chembience/rdkit:$build_tag
ARG conda_py

LABEL maintainer="markus.sitzmann@gmail.com"

RUN mkdir -p /home/nginx /home/template /opt/django

COPY docker-entrypoint.sh /
COPY requirements.txt /opt/django
COPY nginx/* /home/nginx
COPY template/* /home/template

ENV PATH /opt/conda/bin:$PATH

RUN apt-get update && apt-get -y --no-install-recommends install nginx supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoremove -y && \
    apt-get clean

RUN /bin/bash -c "source activate chembience" && \
    CONDA_PY=$conda_py conda install --yes --file /opt/django/requirements.txt && \
    conda clean -afy && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.pyc' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete

RUN chown -R www-data.www-data /home/nginx && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    rm /etc/nginx/sites-enabled/default && \
    ln -s /home/nginx/nginx.conf /etc/nginx/sites-enabled/ && \
    ln -s /home/nginx/supervisord.conf /etc/supervisor/conf.d/

WORKDIR /home/app

# Dirty hack fix a nginx module problem
#RUN rm -rf /etc/nginx/modules-enabled/50-mod-http-image-filter.conf

EXPOSE 80
#CMD ["/home/nginx/run.sh"]