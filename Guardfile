# Defines the matching rules for Guard.
guard :minitest, spring: true, all_on_start: false do
  watch(%r{^test/(.*)/?(.*)_test\.rb$})
  puts 'Watching regex guard'
  
  watch('test/test_helper.rb') { 'test' }
  puts 'Watching test/test_helper.rb'
  
  watch('config/routes.rb')    { integration_tests }
  puts 'Watching config/routes.rb'
  
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    "test/models/#{matches[1]}_test.rb"
    puts 'Watching models'
  end
  
  watch(%r{^app/controllers/(.*?)_controller\.rb$}) do |matches|
    resource_tests(matches[1])
    puts 'Running controller tests'
  end
  watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do |matches|
    ["test/controllers/#{matches[1]}_controller_test.rb"] +
    integration_tests(matches[1])
    puts 'Running views tests'
  end
  watch(%r{^app/helpers/(.*?)_helper\.rb$}) do |matches|
    integration_tests(matches[1])
    puts 'Running helpers tests'
  end
  watch('app/views/layouts/application.html.erb') do
    'test/integration/site_layout_test.rb'
    puts 'Running layouts tests'
  end
  watch('app/helpers/sessions_helper.rb') do
    integration_tests << 'test/helpers/sessions_helper_test.rb'
    puts 'Running sessions tests'
  end
  watch('app/controllers/sessions_controller.rb') do
    ['test/controllers/sessions_controller_test.rb',
      'test/integration/users_login_test.rb']
      puts 'Running login tests'
  end
  watch('app/controllers/account_activations_controller.rb') do
    'test/integration/users_signup_test.rb'
    puts 'Running signup tests'
  end
  watch(%r{app/views/users/*}) do
    resource_tests('users') +
    ['test/integration/microposts_interface_test.rb']
    puts 'Running microposts tests'
  end
end

# Returns the integration tests corresponding to the given resource.
def integration_tests(resource = :all)
  if resource == :all
    Dir["test/integration/*"]
  else
    Dir["test/integration/#{resource}_*.rb"]
  end
end

# Returns the controller tests corresponding to the given resource.

def controller_test(resource)
  "test/controllers/#{resource}_controller_test.rb"
end

# Returns all tests for the given resource.

def resource_tests(resource)
  integration_tests(resource) << controller_test(resource)
end