#!/bin/bash

set -exo pipefail

echo "Install spark-bigquery"
gsutil cp gs://spark-lib/bigquery/spark-bigquery-latest_2.12.jar /usr/lib/spark/jars/

#gsutil cp gs://hadoop-lib/gcs/gcs-connector-hadoop3-2.2.3.jar /usr/lib/hadoop/lib/
#ln -s -f /usr/lib/hadoop/lib/gcs-connector-hadoop3-2.2.3.jar /usr/lib/hadoop/lib/gcs-connector.jar
#gsutil cp gs://hadoop-lib/bigquery/bigquery-connector-hadoop3-1.2.0.jar /usr/lib/hadoop/lib/
#ln -s -f /usr/lib/hadoop/lib/bigquery-connector-hadoop3-1.2.0.jar /usr/lib/hadoop/lib/bigquery-connector.jar


PIP_PATH="/opt/conda/miniconda3/bin/pip"
export PIP_PATH="/opt/conda/miniconda3/bin/pip"


echo "Install google-compute-engine google-cloud-pubsub google-cloud-dataproc"

${PIP_PATH} install google-compute-engine google-cloud-pubsub google-cloud-dataproc

echo "Install pandas pandas-gbq pandas-profiling"
${PIP_PATH} install pandas pandas-gbq pandas-profiling

echo "Install pyarrow matplotlib seaborn numpy scipy scikit-learn pillow"
${PIP_PATH} install pyarrow matplotlib seaborn numpy scipy scikit-learn pillow

echo "Install sklearn h5py"
${PIP_PATH} install sklearn h5py

echo "Install tensorflow tensorflow-gpu"
${PIP_PATH} install tensorflow tensorflow-gpu

echo "Install keras xgboost apyori mlxtend"
${PIP_PATH} install keras xgboost apyori mlxtend

echo "Install nltk statsmodels gcsfs Cython"
${PIP_PATH} install nltk statsmodels gcsfs Cython

echo "Install gensim ibis-framework "
${PIP_PATH} install gensim ibis-framework

echo "Install dask[complete]"
${PIP_PATH} install "dask[complete]"

echo "Install ChannelAttribution"
${PIP_PATH} install ChannelAttribution

echo "Install plotly Boruta imbalanced-learn rfpimp pyclustering"
${PIP_PATH} install plotly Boruta imbalanced-learn rfpimp pyclustering

echo "Install h2o"
${PIP_PATH} install h2o

echo "Install prefixspan Lifetimes"
${PIP_PATH} install prefixspan Lifetimes

echo "Install ipython ipywidgets"
${PIP_PATH} install ipython ipywidgets

echo "Install sequential_pattern_mining"
git clone https://github.com/alessandroaere/ERMiner.git /tmp/ERMiner
mv /tmp/ERMiner/sequential_pattern_mining  /opt/conda/miniconda3/lib/python3.8/site-packages/

echo "Install python_http_client starkbank-ecdsa sendgrid dnspython"
${PIP_PATH} install python_http_client starkbank-ecdsa sendgrid dnspython

echo "Install mlflow folium pmdarima pystan"
${PIP_PATH} install mlflow folium pmdarima pystan

echo "Install prophet fbprophet"
${PIP_PATH} install prophet fbprophet

echo "Install requests tabulate future h2o_pysparkling_3.1"
${PIP_PATH} install requests tabulate future h2o_pysparkling_3.1

echo "Install pycspade hyperopt html5lib PyCryptodome datetime"
${PIP_PATH} install pycspade hyperopt html5lib PyCryptodome datetime

echo "Install shap lightgbm modin dask koalas sweetviz"
${PIP_PATH} install shap lightgbm modin dask koalas sweetviz

echo "Install for AIM"
${PIP_PATH} install dtw-python pystan fbprophet ipywidgets logzero ortools pytest python-dotenv streamlit xlrd

