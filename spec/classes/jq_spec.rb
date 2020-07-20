require 'spec_helper'

describe 'jq' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('wget::install') }

      describe 'wget::install' do
        let(:params) do
          {
            download_version: '1.6',
            download_url: 'https://github.com/stedolan/jq/releases/download',
            download_dir: '/opt/jq',
            install_dir: '/usr/local/bin',
          }
        end

        it {
          is_expected.to contain_package('wget').with(
            ensure: 'present',
          )
        }
      end
    end
  end
end
