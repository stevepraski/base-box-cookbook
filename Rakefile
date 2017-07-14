# for chefdk:
#   chef gem install rake
#   chef exec rake

namespace :lint do
  task :foodcritic do
    chef_opt = ::File.directory?('/opt/chefdk') ? 'chefdk' : 'chef'
    sh "/opt/#{chef_opt}/embedded/bin/foodcritic . -f any"
  end
  task :rubocop do
    chef_opt = ::File.directory?('/opt/chefdk') ? 'chefdk' : 'chef'
    sh "/opt/#{chef_opt}/embedded/bin/rubocop"
  end
end

task lint: ['lint:foodcritic', 'lint:rubocop']
task default: [:lint]
