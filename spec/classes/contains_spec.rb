# To check the correct dependencies are set up for wget.

require 'spec_helper'
describe 'jq' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }
      describe 'Testing the dependencies between the classes' do
        it { is_expected.to contain_class('jq::install') }
      end
    end
  end
end
