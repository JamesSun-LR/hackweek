#!/bin/bash
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS-IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -euxo pipefail

readonly LIVY_VERSION="0.8.0"
readonly LIVY_DIR="/usr/local/lib/livy"
readonly LIVY_BIN="${LIVY_DIR}/bin"
readonly LIVY_CONF="${LIVY_DIR}/conf"

# Generate livy environment file.
function make_livy_env() {
  cat << EOF > "${LIVY_CONF}/livy-env.sh"
export SPARK_HOME=/usr/lib/spark
export SPARK_CONF_DIR=/etc/spark/conf
export HADOOP_CONF_DIR=/etc/hadoop/conf
export LIVY_LOG_DIR=/var/log/livy
export PYSPARK_PYTHON=/opt/conda/miniconda3/bin/python
export PYSPARK_DRIVER_PYTHON=/opt/conda/miniconda3/bin/ipython
export PATH=$PATH:$SPARK_HOME/bin
EOF
}

# Create Livy service.
function create_systemd_unit() {
  cat << EOF > "/etc/systemd/system/livy.service"
[Unit]
Description=Apache Livy service
After=network.target

[Service]
Group=livy
User=livy
Type=forking
ExecStart=${LIVY_BIN}/livy-server start
ExecStop=${LIVY_BIN}/livy-server stop
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
}

function main() {
  # Only run this initialization action on the master node.
  local role
  role=$(/usr/share/google/get_metadata_value attributes/dataproc-role)
  if [[ "${role}" != 'Master' ]]; then
    exit 0
  fi

  # Download Livy binary.
  local temp
  temp=$(mktemp -d)
  gsutil cp gs://datalake-sea-eng-us-dev-dataproc-initialization-actions/livy/apache-livy-${LIVY_VERSION}-incubating-bin.zip ${temp}/livy.zip
  #wget -O "${temp}/livy.zip" "${APACHE_MIRROR}=${BIN_PKG}"
  unzip "${temp}/livy.zip" -d "${temp}"

  # Create Livy user.
  useradd -G hadoop livy

  # Setup livy package.
  install -d "${LIVY_DIR}"
  cp -r "${temp}/apache-livy-${LIVY_VERSION}-incubating-bin"/* "${LIVY_DIR}"
  echo livy.spark.master=yarn >> ${LIVY_DIR}/conf/livy.conf
  echo livy.spark.deployMode=client >> ${LIVY_DIR}/conf/livy.conf
  chown -R "livy:livy" "${LIVY_DIR}"

  # Setup log directory.
  mkdir /var/log/livy
  chown -R "livy:livy" /var/log/livy

  # Cleanup temp files.
  rm -Rf "${temp}"

  # Generate livy environment file.
  make_livy_env

  # Start livy service.
  create_systemd_unit
  systemctl enable "livy.service"
  systemctl start "livy.service"
}

main

