# dags/dbt_run_dag.py
from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime, timedelta

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2024, 4, 1),
    'retries': 1,
    'retry_delay': timedelta(minutes=2),
}

with DAG(
    'dbt_run',
    default_args=default_args,
    description='A simple DBT DAG',
    schedule_interval=timedelta(days=1),
    catchup=False,
) as dag:

    # Task to run dbt run
    dbt_run = BashOperator(
        task_id='dbt_run',
        bash_command='dbt run --profiles-dir /opt/airflow/example_dbt_project --project-dir /opt/airflow/example_dbt_project --debug',
    )

    dbt_run