# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

#Make sure loading carrierwave after loading ORM
require 'carrierwave/orm/activerecord'
require "carrierwave/storage/abstract"
require "carrierwave/storage/file"