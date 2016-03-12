require_relative '../../spec_helper'
require 'rack/test'
require 'minitest/autorun'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe app do

  describe 'get /' do

    it 'must say hello world' do
      get '/'
      last_response.body.must_equal "Hello World!"
    end

  end

end
