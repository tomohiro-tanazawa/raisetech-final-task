require 'spec_helper'

# 指定のポートが開いているか
listen_ports = [22, 80]
listen_ports.each do |listen_port|
  describe port(listen_port) do
    it { should be_listening }
  end
end
# curlでhttpアクセスしたときに200が返ってくるか
describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

# パスは通っているか
describe command('which mysql') do
  its(:exit_status) { should eq 0 }
end

# ImageMagickがインストールされているか
describe command('convert --version') do
  its(:exit_status) { should eq 0 }
end


# nginxがインストールされているか
describe package('nginx') do
  it { should be_installed }
end
# nginxが自動起動設定されているか & 起動しているか
describe service('nginx'), :if => os[:family] == 'amazon' do
  it { should be_enabled }
  it { should be_running }
end
# nginx設定ファイルが指定のパスに存在するか
describe file('/etc/nginx/conf.d/raisetech-live8-sample-app.conf') do
  it { should exist }
end

# yarnは指定のバージョンか
describe package('yarn') do
  it { should be_installed.with_version('1.22.19') }
end

# master.keyが存在するか
describe command('ls -al /var/www/raisetech-live8-sample-app/config')do
  its(:stdout) { should match /master.key/}
end

# nginxとunicornのソケットファイルが指定の場所に存在するか
describe file('/var/www/raisetech-live8-sample-app/tmp/unicorn.sock') do
  it { should be_socket }
end

# railsアプリケーションを格納しているディレクトリのパスの確認 & 所有者とグループがec2-userになっているか
describe file('/var/www/raisetech-live8-sample-app') do
  it { should be_directory }
  it { should be_owned_by 'ec2-user' }
  it { should be_grouped_into 'ec2-user'}
end
