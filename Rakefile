# encoding: utf-8
require "foodcritic"
require "rspec/core/rake_task"

desc "Run Foodcritic lint checks"
FoodCritic::Rake::LintTask.new(:lint) do |t|
  t.options = { :fail_tags => ["any"] }
end

desc "Run extra Foodcritic rulesets"
task :food_extra do
  sh 'if [ "$(ls -A foodcritic/)" ]; then bundle exec foodcritic -f any -I foodcritic/* .; fi'
end

desc "Run ChefSpec examples"
RSpec::Core::RakeTask.new(:spec)

desc "Run all tests"
task :test => [:cleanup_vendor, :lint, :food_extra, :spec, :tailor, :taste, :rubocop]
task :default => :test

desc "Run tailor tests"
task :tailor do
  sh 'bundle exec tailor *.rb ./**/*.rb ./**/**/**/**/*.rb'
end

desc "Run taste tests"
task :taste do
  sh 'bundle exec taste'
end

desc "Run rubocop tests"
task :rubocop do
  sh 'bundle exec rubocop'
end

desc "Cleanup Vendor directory"
task :cleanup_vendor do
  sh 'rm -rf vendor/cookbooks/*'
end

task :berksintall do
  sh 'berks install --path vendor/cookbooks'
end

desc "Syntax check and build Vagrant box"
task :build_vagrant => [:cleanup_vendor, :cleanup_vagrant, :lint, :spec, :tailor, :taste, :rubocop, :berksintall, :vagrantup]
task :vagrant => :build_vagrant

task :vagrantup do
  sh 'vagrant up --provision'
end

task :cleanup_vagrant do
  sh 'vagrant destroy -f'
end

desc "Syntax check and build all Packer targets"
task :build => [:cleanup_vendor, :lint, :spec, :tailor, :taste, :rubocop, :packer]

task :packer => [:cleanup_vendor, :packer_build]

task :packer_build do
  sh 'berks install --path vendor/cookbooks; packer build template.json'
end

desc "Syntax check and build AMI"
task :build_ami => [:cleanup_vendor, :lint, :spec, :tailor, :taste, :rubocop, :packer_ami]

task :packer_ami => [:cleanup_vendor, :packer_build_ami]

task :packer_build_ami do
  sh 'berks install --path vendor/cookbooks; packer build -only=amazon-ebs template.json'
end

desc "Syntax check and build Droplet"
task :build_droplet => [:cleanup_vendor, :lint, :spec, :tailor, :taste, :rubocop, :packer_droplet]

task :packer_droplet => [:cleanup_vendor, :packer_build_droplet]

task :packer_build_droplet do
  sh 'berks install --path vendor/cookbooks; packer build -only=digitalocean template.json'
end

desc "Syntax check and build Openstack Image"
task :build_openstack => [:cleanup_vendor, :lint, :spec, :tailor, :taste, :rubocop, :packer_openstack]

task :packer_openstack => [:cleanup_vendor, :packer_build_openstack]

task :packer_build_openstack do
  sh 'berks install --path vendor/cookbooks; packer build -only=openstack template.json'
end

begin
  require "kitchen/rake_tasks"
  Kitchen::RakeTasks.new

  desc "Alias for kitchen:all"
  task :integration => "kitchen:all"

  task :test => :integration
rescue LoadError
  puts ">>>>> Kitchen gem not loaded, omitting tasks" unless ENV['CI']
end
