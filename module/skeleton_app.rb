# load path
lib_path = File.expand_path('../', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

Bundler.require(:default)

# load path
lib_path = File.expand_path('../', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

Bundler.require(:default)

Mongoid.load!("config/mongoid.yml", ENV['RACK_ENV'])
Mongoid.logger.level = Logger::INFO
Mongo::Logger.logger.level = Logger::INFO

Dir[File.dirname(__FILE__) + '/models/*.rb'].each do |file|
	require file
end

Dir[File.dirname(__FILE__) + '/services/*.rb'].each do |file|
	require file
end

## Configuring AWS for storing images
## To Do: Use Dragonfly for storing as well?
Aws.config.update({
  region: 'us-west-2',
  credentials: Aws::Credentials.new(ENV['SKELETON_APP_AWS_ACCESS_KEY_ID'], ENV['SKELETON_APP_AWS_SECRET_ACCESS_KEY'])
})

## Configuring Dragonfly for accessing images
Dragonfly.app.configure do
	plugin :imagemagick
	secret 'I miss my Sony camera'

  datastore :s3,
		region: 'us-west-2',
    bucket_name: ENV['SKELETON_APP_AWS_BUCKET'],
    access_key_id: ENV['SKELETON_APP_AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['SKELETON_APP_AWS_SECRET_ACCESS_KEY']
end

## Increasing max keyspace limit to allow photo uploads in base64 format...
if Rack::Utils.respond_to?("key_space_limit=")
  Rack::Utils.key_space_limit = 1048576 # 16 times the default size
end
