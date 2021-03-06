#require 'sidekiq/testing'

require 'simplecov'
SimpleCov.start 'rails'
include RSpec::Core::Let::ExampleGroupMethods

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'tire'

Dir[Rails.root.join("lib/**/*.rb")].each { |f| requi/home/javadev/workspace/demo_appre f }
Dir[Rails.root.join("test/**/*.rb")].each { |f| require f }

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.

Tire.index("people").delete
OneOffTasks::TireIndex.create

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include ControllerMacros, :type => :controller
  config.include RequestMacros, :type => :request

  config.before(:suite) do
    Country.delete_all
    Pools::Loaders::CountryLoader.load
  end

  config.before(:each, :type => :controller) do
    http_login
  end

  config.before(:each, :type => :request) do

  end

  config.after(:all, type: :request) do

  end

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

end

def http_login(given_username="foo", given_password="bar")
  user = given_username
  password = given_password
  request.env["HTTP_AUTHORIZATION"]=ActionController::HttpAuthentication::Basic.encode_credentials(user, password)
end

#module ActionController::TestCase::Behavior
#
#  def get(action, parameters = nil, session = nil, flash = nil)
#    process(action, parameters, session, flash, "GET")
#  end
#
#end
