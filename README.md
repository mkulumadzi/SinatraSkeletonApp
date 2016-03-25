# SinatraSkeletonApp

## Configuration

### General Configuration

The following environment variables are required for basic functionality of the app:

* RACK_ENV _Set to the appropriate development environment_
* SKELETON_APP_BASE_URL _Points to the application url (eg, http://localhost:9292), for resolving URIs in header responses_

### AWS Configuration

The app uses Amazon S3 for storing image files and for retrieving public and private certificate files for app authentication. Before configuring the app, create an S3 bucket and an AWS user with IAMS privileges for reading and writing on this bucket. Then set up the following variables for AWS configuration:

* SKELETON_APP_AWS_REGION _Eg, Oregon_
* SKELETON_APP_AWS_BUCKET _Eg, skeleton-app-development-bucket_
* SKELETON_APP_AWS_ACCESS_KEY_ID _Access key for the user_
* SKELETON_APP_AWS_SECRET_ACCESS_KEY _Secret for the user_

### OAuth Configuration

The app uses OAuth for API authentication. To configure:

1. Create a public key certificate file called 'public.pem'
- Create a private key certificate file called 'private.pem', optionally protected by a passphrase
- Create a new bucket on AWS S3 and upload these files

Then configure the following environment variables

* SKELETON_APP_CERTIFICATE_BUCKET
* SKELETON_APP_PRIVATE_KEY_PASSPHRASE _Passphrase for the public key file_

### Email Configuration

The app can optionally be configured to send email address verification and password reset emails. The app uses the email service 'Postmark'. To enable emails:

1. Create an account on Postmark using a private domain email address (public domain emails are not allowed to send emails via Postmark)
- Create a sender signature for this email address

Then configure the following environment variables:

* SKELETON_APP_EMAIL_ENABLED = yes _Set to "yes" if enabled_
* SKELETON_APP_POSTMARK_EMAIL_ADDRESS _Email address configured in postmark_
* POSTMARK_API_KEY _Sender signature api key generated by Postmark_

## API Documentation

### People

Create a person (note that, if email is enabled, this person will receive automated mail to authenticate their email):

```
POST /person/new

{
	"given_name": "Test",
  "family_name": "Person"
	"username": "username",
	"email": "person@test.com",
	"phone": "555-444-1234",
	"password": "password",
	"address1": "Street Address",
	"city": "City",
	"state": "ST",
	"zip": "11111"
}

Status: 201

Headers:
location = /person/id/{person_id}
```

Log in:

```
POST /login

{
	"username": "username",
	"password": "password"
}

Status: 200
```

Get a person record:

```
GET /person/id/{person_id}

Status: 200

Response body:

{
	_id: {
		$oid: "uuid"
	},
	name: "Person Name",
	username: "username",
	address1: "Street Address",
	city: "City",
	state: "ST",
	zip: "11111",
	updated_at: "2015-06-17T20:36:39.024Z"
	created_at: "2015-06-17T20:36:39.009Z"
}
```

Update a person:

```
POST /person/id/{person_id}

{
	"address1": "Street Address",
	"city": "City",
	"state": "ST",
	"zip": "11111"
}

Status: 204
```

Reset a person's password:

```
POST /person/id/{person_id}/reset_password

{
	"old_password": "password",
	"new_password": "password123"
}

Status: 204
```

Get a collection of people:

```
GET  /people?parameter=value

Status: 200

Response body:

[
	{
		_id: {
			$oid: "uuid"
		},
		name: "Person Name",
		username: "username",
		address1: "Street Address",
		city: "City",
		state: "ST",
		zip: "11111",
		updated_at: "2015-06-17T20:36:39.024Z"
		created_at: "2015-06-17T20:36:39.009Z"
	}
]
```

Search people:
* Search terms are case-sensitive
* Terms are used to search both name and username records
* If no limit to the number of results is set, the default limit is 25

```
GET /people/search?term=Evan&limit=3

Status: 200

Response body:
[
	{
		_id: {
			$oid: "uuid"
		},
		name: "Evan 1",
		username: "username1",
		address1: "Street Address",
		city: "City",
		state: "ST",
		zip: "11111",
		updated_at: "2015-06-17T20:36:39.024Z"
		created_at: "2015-06-17T20:36:39.009Z"
	},
	{
		_id: {
			$oid: "uuid"
		},
		name: "Evan 2",
		username: "username2",
		address1: "Street Address",
		city: "City",
		state: "ST",
		zip: "11111",
		updated_at: "2015-06-17T20:36:39.024Z"
		created_at: "2015-06-17T20:36:39.009Z"
	}
]

```

Perform a bulk search of people using emails and phone numbers:
* The iOS app searches a person's contacts and passes in an array of these contacts, including email and phone numbers for each contact
* The postoffice server returns a unique list of any people who match the contact records

```

POST /people/bulk_search

[
	{
		"emails": ["person1@test.com", "person1@gmail.com"],
		"phoneNumbers": ["5554441243"]
	},
	{
		"emails": ["person2@test.com"],
		"phoneNumbers": ["5553332222"]
	}
]

Status: 200

Reponse body:
[
	{
		_id: {
			$oid: "uuid"
		},
		name: "Evan 1",
		username: "username1",
		email: "person1@test.com",
		address1: "Street Address",
		city: "City",
		state: "ST",
		zip: "11111",
		updated_at: "2015-06-17T20:36:39.024Z"
		created_at: "2015-06-17T20:36:39.009Z"
	},
	{
		_id: {
			$oid: "uuid"
		},
		name: "Evan 2",
		username: "username2",
		emails: "person2@test.com",
		address1: "Street Address",
		city: "City",
		state: "ST",
		zip: "11111",
		updated_at: "2015-06-17T20:36:39.024Z"
		created_at: "2015-06-17T20:36:39.009Z"
	}
]
```
