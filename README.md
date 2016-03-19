# SinatraSkeletonApp

## Configuration

### General

* Set ENV['RACK_ENV']
* Set ENV['SKELETON_APP_BASE_URL']
* Set ENV['SKELETON_APP_PRIVATE_KEY_PASSPHRASE']
* Set ENV['SKELETON_APP_AWS_BUCKET']
* Set ENV['SKELETON_APP_AWS_ACCESS_KEY_ID']
* Set ENV['SKELETON_APP_AWS_SECRET_ACCESS_KEY']
* Set ENV['SKELETON_APP_AWS_REGION']
* Set ENV['SKELETON_APP_POSTMARK_EMAIL_ADDRESS']

### Production and Staging

* Need to add a non-public domain email address for Postmark


## AWS Setup

* Create a bucket for certificates
** Upload a private key and public key
* Create a bucket for each environment
* Create a user, grant read, write and admin privileges to this user
