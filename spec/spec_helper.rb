# spec/spec_helper.rb
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rspec/rails"
require 'webmock/rspec'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end

WebMock.disable_net_connect!(allow_localhost: true)
