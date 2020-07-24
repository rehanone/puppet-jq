require 'spec_helper'

describe 'jq' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to contain_class('jq::install') }

      describe 'jq with package_source => github' do
        let(:params) do
          {
            package_manage: true,
            package_source: 'github',
            download_version: '1.6',
            download_url: 'https://github.com/stedolan/jq/releases/download',
            download_dir: '/opt/jq',
            install_dir: '/usr/local/bin',
          }
        end

        it {
          is_expected.to contain_package('jq').with(
            ensure: 'absent',
          )
        }

        it {
          is_expected.to contain_file('/opt/jq').with(
            ensure: 'directory',
            mode: '0755',
          )
        }

        it {
          is_expected.to contain_wget__retrieve('https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64').with(
            destination: '/opt/jq/jq-linux64',
          )
        }

        it {
          is_expected.to contain_file('/opt/jq/jq-linux64').with(
            ensure: 'file',
            mode: '0755',
          )
        }

        it {
          is_expected.to contain_file('/usr/local/bin/jq').with(
            ensure: 'link',
            mode: '0755',
          )
        }
      end

      describe 'jq::install with package_source => os' do
        let(:params) do
          {
            package_manage: true,
            package_source: 'os',
          }
        end

        it {
          is_expected.to contain_file('/usr/local/bin/jq').with(
            ensure: 'absent',
          )
        }

        it {
          is_expected.to contain_package('jq').with(
            ensure: 'present',
          )
        }
      end
    end
  end
end
