require 'spec_helper'




describe 'systemd::unit', :type => :define do
  context 'without dep cycles' do
    let(:title) { 'nginx' }
    it { is_expected.to compile }
    it { is_expected.to contain_exec('systemd-daemon-reload').with_command('systemctl daemon-reload') }
    it { is_expected.to contain_file('/etc/systemd/system/nginx.service') }
    it { is_expected.to contain_service('nginx').with_ensure('running') }

  end

  context "with environment file" do
    let(:params) {{ 'environment_file' => 'true', 'service_exports' => { 'foo' => 'bar', 'baz' => 'toto' } } }
    let(:title) { 'atd' }
    it { is_expected.to contain_file('/etc/sysconfig/atd') }
  end

end
