FROM apache/airflow:2.9.2

USER root

RUN echo 'Acquire::https::Verify-Peer "false";' > /etc/apt/apt.conf.d/99disable-ssl \ 
    && echo 'Acquire::https::Verify-Host "false";' >> /etc/apt/apt.conf.d/99disable-ssl

RUN sudo apt-get update \
    && apt-get install -y --no-install-recommends \
    gcc \
    git-all \
    python3-distutils \
    python3.8-dev

USER airflow

COPY --chown=airflow . .

RUN python -m pip install .

RUN pip install dbt-mysql
RUN pip install --upgrade dbt-postgres==1.5.9


#RUN dbt deps --project-dir /opt/airflow/example_dbt_project
