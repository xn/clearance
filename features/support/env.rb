ENV["RAILS_ENV"] ||= "test"

PROJECT_ROOT = File.expand_path("../../..", __FILE__)
$LOAD_PATH << File.join(PROJECT_ROOT, "lib")

require 'rails/all'
Bundler.require

require 'diesel/testing'
require 'diesel/testing/integration'

require 'clearance'
require 'clearance/shoulda_macros'

Clearance.configure do |config|
end

class ApplicationController < ActionController::Base
  include Clearance::Authentication

  def show
    render :text => "", :layout => 'application'
  end
end

class User < ActiveRecord::Base
  include Clearance::User
end

require 'cucumber/formatter/unicode'
require 'cucumber/rails/world'
require 'cucumber/rails/hooks'
require 'cucumber/rails/capybara'
require 'cucumber/web/tableish'

Capybara.default_selector = :css
Capybara.save_and_open_page_path = 'tmp'
DatabaseCleaner.strategy = :transaction

Before do
  @aruba_timeout_seconds = 60
end

