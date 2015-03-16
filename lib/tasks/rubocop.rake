# rubocop:disable Lint/HandleExceptions
begin
  require 'rubocop'
  require 'rubocop/rake_task'

  RuboCop::RakeTask.new
rescue LoadError
end
