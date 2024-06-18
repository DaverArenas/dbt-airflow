FROM apache/airflow:2.9.2

USER root

# #RUN echo 'Acquire::https::apt.postgresql.org::Verify-Peer "false";' > /etc/apt/apt.conf.d/99disable-ssl-verification
RUN echo 'Acquire::https::Verify-Peer "false";' > /etc/apt/apt.conf.d/99disable-ssl \ 
    && echo 'Acquire::https::Verify-Host "false";' >> /etc/apt/apt.conf.d/99disable-ssl

# RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf 

RUN sudo apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    python3-distutils \
    python3.8-dev

USER airflow

COPY . .

RUN python -m pip install .

RUN pip install --upgrade dbt-postgres==1.5.9

#RUN dbt deps --project-dir /opt/airflow/example_dbt_project
