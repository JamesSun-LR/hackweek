
python ./generate_custom_image.py \
    --image-name dl-dataproc-image-jamsun-v2-4 \
    --dataproc-version 2.0-debian10 \
    --customization-script ./install_actions.sh \
    --project=datalake-landing-eng-us-dev \
    --subnet=projects/datalake-landing-eng-us-dev/regions/europe-west4/subnetworks/landing-dev-data-zone1-ew4 \
    --zone europe-west4-a \
    --gcs-bucket gs://jamsun-test-loading-bucket-eu/ \
    --disk-size=30 \
    --metadata=block-project-ssh-keys=TRUE \
    --no-smoke-test

