# frozen_string_literal: true

Dir[File.join(File.dirname(__FILE__), '..', 'challenges', '**', '*.rb')].each do |file|
  require file
end

RSpec.configure do |config|
  config.formatter = :progress
end
