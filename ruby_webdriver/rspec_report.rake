require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '/Users/jimmywei/Documents/Git/ruby_webdriver/ruby_webdriver/rspec_test.rb --format html --out /Users/jimmywei/Documents/Git/ruby_webdriver/ruby_webdriver/rspec_results.html'
end

namespace :rspec_report do
  desc 'Run all specs and generate RSpec report in HTML'
  task :html => :spec

  desc 'Run all specs, generate RSpec report and open it in the browser'
  task :browser do
    Rake::Task[:spec].invoke
    `open /Users/jimmywei/Documents/Git/ruby_webdriver/ruby_webdriver/rspec_results.html` # This only works if running OS X.
  end
end