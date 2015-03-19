require 'securerandom'
if ENV["TRAVIS"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

def random_hash
  {SecureRandom.hex => SecureRandom.hex} 
end

