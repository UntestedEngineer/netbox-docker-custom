# from configuration import _read_secret
from os import environ
import sys
sys.path.insert(0, "/etc/netbox/config/")
from configuration import _read_secret

## By default uploaded media is stored on the local filesystem. Using Django-storages is also supported. Provide the
## class path of the storage driver in STORAGE_BACKEND and any configuration options in STORAGE_CONFIG. For example:
STORAGES = {
    "aws": {
        "BACKEND": 'storages.backends.s3boto3.S3Boto3Storage',
        "OPTIONS": {
            'AWS_ACCESS_KEY_ID': _read_secret('aws_access_key_id', environ.get('AWS_ACCESS_KEY_ID', '')),
            'AWS_SECRET_ACCESS_KEY': _read_secret('aws_secret_access_key', environ.get('AWS_SECRET_ACCESS_KEY', '')),
            'AWS_STORAGE_BUCKET_NAME':  _read_secret('aws_storage_bucket_name', environ.get('AWS_STORAGE_BUCKET_NAME', '')),
            'AWS_S3_REGION_NAME': _read_secret('aws_s3_region_name', environ.get('AWS_S3_REGION_NAME', '')),
            },
        },
    }
