# Heroku Bucketeer S3 Sync

Tool for syncing a Heroku Bucketeer bucket to a non-Bucketeer bucket.

## Demonstration

- Bucketeer bucket name should be set in `./.env`
  ```properties
  # Bucket name for s3fs mounted at /mnt
  AWS_STORAGE_BUCKET_NAME=bucketeer-********-****-****-****-************
  ```
- Bucketeer credentials should be set in `./volumes/s3fs-authfile`
  ```txt
  <AWS_ACCESS_KEY_ID>:<AWS_SECRET_ACCESS_KEY>
  ```
- Access key ID and secret goes in `./volumes/aws-credentials` as an AWS cli credentials file
  ```ini
  [default]
  aws_access_key_id = <AWS_ACCESS_KEY_ID>
  aws_secret_access_key = <AWS_SECRET_ACCESS_KEY>
  ```
- Get a shell:
  ```console
  $ docker compose run -i --rm s3fs bash
  ==> Mounting S3 Filesystem
  Running command bash
  ```
- List the Bucketeer bucket:
  ```console
  $ docker compose run -i --rm s3fs ls /mnt/
  ==> Mounting S3 Filesystem
  Running command ls /mnt/
  file1.txt  file2.txt  folder1  folder2
  ```
- List the non-Bucketeer bucket:
  ```console
  $ docker compose run -i --rm s3fs aws s3 ls s3://example-bucket/
  ==> Mounting S3 Filesystem
  Running command aws s3 ls s3://example-bucket/
                             PRE folder1/
                             PRE folder2/
  2023-08-22 05:22:13          2 file1.txt
  2023-08-22 05:22:13          2 file2.txt
  ```
- Do the sync:
  ```console
  $ docker compose run -i --rm s3fs aws s3 sync /mnt/ s3://example-bucket/
  ==> Mounting S3 Filesystem
  Running command aws s3 sync /mnt/ s3://example-bucket/
  …
  ```
- Do the sync with [run.sh](./run.sh):
  ```console
  $ ./run.sh example-bucket
  Thu Aug 24 11:02:18 CDT 2023

  ==> Mounting S3 Filesystem
  Running command aws s3 sync /mnt/ s3://example-bucket/ --no-progress
  upload: …

  Thu Aug 24 11:02:23 CDT 2023

  Total time elapsed: 00:00:05 (HH:MM:SS)

  $ ls logs/
  sync-20230824110223.log
  ```

## Resources

- https://github.com/panubo/docker-s3fs
- https://aws.amazon.com/cli/
