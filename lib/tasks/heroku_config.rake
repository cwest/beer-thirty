# rubocop:disable Lint/HandleExceptions
begin
  require 'dotenv-heroku/tasks'
rescue LoadError
end
