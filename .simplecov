SimpleCov.start do
  add_group 'Services', 'app/services'

  minimum_coverage 90
  refuse_coverage_drop

  add_filter 'vendor'
end
