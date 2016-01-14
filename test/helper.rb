if ENV['CODECLIMATE_REPO_TOKEN']
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.configuration.git_dir = '.'
  CodeClimate::TestReporter.start
end
