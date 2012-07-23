require 'spec_helper'

describe 'sudoers::allowed_command', :type => :define do
  let(:title) { 'everyone-can-run-riak-admin-as-riak' }
  let(:params) {
    {
      :command => '/usr/sbin/riak-admin',
      :user => 'ALL',
      :run_as => 'riak',
      :require_password => false
    }
  }
  it {
    should contain_file('/etc/sudoers.d/everyone-can-run-riak-admin-as-riak').with(
      :content => "ALL ALL=(riak) NOPASSWD: /usr/sbin/riak-admin\n"
    )
  }

end
