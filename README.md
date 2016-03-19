# SinatraSkeletonApp

## Configuration

### General

* Set ENV['SKELETON_APP_RACK_ENV']
* Set ENV['SKELETON_APP_BASE_URL']
* Set ENV['SKELETON_APP_PRIVATE_KEY_PASSPHRASE']
* Set ENV['SKELETON_APP_AWS_BUCKET']
* Set ENV['SKELETON_APP_AWS_ACCESS_KEY_ID']
* Set ENV['SKELETON_APP_AWS_SECRET_ACCESS_KEY']
* Set ENV['SKELETON_APP_AWS_REGION']
* Set ENV['SKELETON_APP_POSTMARK_EMAIL_ADDRESS']

### Staging and Production

* Set ENV['MONGOLAB_URI']

## AWS Setup

* Create a bucket for certificates
** Upload a private key and public key
* Create a bucket for each environment
* Create a user, grant read, write and admin privileges to this user
