# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the `ubuntu_base` recipe' do
    expect(chef_run).to include_recipe('ubuntu_base::default')
  end

  it 'includes the `octobase` recipe' do
    expect(chef_run).to include_recipe('octobase::default')
  end

  it 'includes the `docker` recipe' do
    expect(chef_run).to include_recipe('docker::default')
  end

  it 'includes the `redis` recipe' do
    expect(chef_run).to include_recipe('redis::default')
  end

  it 'includes the `openresty` recipe' do
    expect(chef_run).to include_recipe('openresty::default')
  end

  it 'includes the `gitreceive` recipe' do
    expect(chef_run).to include_recipe('gitreceive::default')
  end

  it 'includes the `etcd` recipe' do
    expect(chef_run).to include_recipe('etcd::default')
  end

  it 'installs the proxy proxy.conf' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/proxy.conf')
  end

  it 'installs the proxy logrotate' do
    expect(chef_run).to create_cookbook_file('/etc/logrotate.d/nginx')
  end

  it 'installs the proxy api.conf' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/api.conf')
  end

  it 'installs the proxy upstream.conf' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/upstream.conf')
  end

  it 'installs the proxy default' do
    expect(chef_run).to create_cookbook_file('/etc/default/proxy')
  end

  it 'installs the proxy init.d' do
    expect(chef_run).to create_cookbook_file('/etc/init.d/proxy')
  end

  it 'installs the proxy ssl.key' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/ssl.key')
  end

  it 'installs the proxy ssl.crt' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/ssl.crt')
  end

  it 'disables nginx' do
    expect(chef_run).to disable_service('nginx')
  end

  it 'stops nginx' do
    expect(chef_run).to stop_service('nginx')
  end

  it 'enables proxy' do
    expect(chef_run).to enable_service('proxy')
  end

  it 'starts proxy' do
    expect(chef_run).to start_service('proxy')
  end

  it 'enables redis-server' do
    expect(chef_run).to enable_service('redis-server')
  end

  it 'starts redis-server' do
    expect(chef_run).to start_service('redis-server')
  end

  it 'installs a redis config file' do
    expect(chef_run).to create_cookbook_file('/etc/redis/redis.conf')
  end

  it 'installs python-pip' do
    expect(chef_run).to install_package('python-pip')
  end

  it 'installs a tentacles init file' do
    expect(chef_run).to create_cookbook_file('/etc/init/tentacles.conf')
  end

  it 'creates the GeopIP directory' do
    expect(chef_run).to create_directory('/usr/local/share/GeoIP/')
  end

  it 'downloads the GeoIP country data file' do
    expect(chef_run).to create_remote_file('/usr/local/share/GeoIP/GeoIP.dat.gz')
  end

  it 'downloads the GeoIP city data file' do
    expect(chef_run).to create_remote_file('/usr/local/share/GeoIP/GeoLiteCity.dat.gz')
  end

end
