# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::nginx' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs the libgd2-noxpm-dev package' do
    expect(chef_run).to install_package('libgd2-noxpm-dev')
  end

  it 'installs the libssl0.9.8' do
    expect(chef_run).to install_package('libssl0.9.8')
  end

  it 'installs the nginx package' do
    expect(chef_run).to install_package('nginx')
  end

  it 'stops and disables the nginx service' do
    expect(chef_run).to stop_service('nginx')
    expect(chef_run).to disable_service('nginx')
  end

  it 'creates the /etc/nginx/additional-vhosts directory' do
    expect(chef_run).to create_directory('/etc/nginx/additional-vhosts')
  end

  it 'creates the /var/www/default directory' do
    expect(chef_run).to create_directory('/var/www/default')
  end

  it 'installs the /var/www/default/index.html' do
    expect(chef_run).to create_cookbook_file('/var/www/default/index.html')
  end

  it 'installs the /etc/nginx/additional-vhosts/00default.conf' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/additional-vhosts/00default.conf')
  end

  it 'creates the /etc/nginx/containers' do
    expect(chef_run).to create_directory('/etc/nginx/containers')
  end

  it 'creates the /etc/nginx/templates' do
    expect(chef_run).to create_directory('/etc/nginx/templates')
  end

  it 'installs the nginx and consul templates' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/template.ctmpl')
    expect(chef_run).to create_cookbook_file('/etc/nginx/templateSSL.ctmpl')
    expect(chef_run).to create_cookbook_file('/etc/nginx/template.cfg')
    expect(chef_run).to create_cookbook_file('/etc/nginx/template.watch')
    expect(chef_run).to create_cookbook_file('/etc/nginx/template.kv.watch')
  end

  it 'installs the ssl.conf' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/ssl.conf')
  end

  it 'installs the location.conf' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/location.conf')
  end

  it 'installs the proxy proxy.conf' do
    expect(chef_run).to create_cookbook_file('/etc/nginx/proxy.conf')
  end

  it 'installs the proxy logrotate' do
    expect(chef_run).to create_cookbook_file('/etc/logrotate.d/nginx')
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

  it 'starts and enables the proxy service' do
    expect(chef_run).to enable_service('proxy')
    expect(chef_run).to start_service('proxy')
  end

  it 'installs ngxtop' do
    expect(chef_run).to install_python_pip('ngxtop')
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

  before  do
    #
  end
end
