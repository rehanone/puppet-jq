require 'spec_helper_acceptance'

os_name = fact('os.name')
os_release = fact('os.release.major')

sut_os = "#{os_name}-#{os_release}"

package_source =
  case sut_os
  when 'Ubuntu-20.04'
    'os'
  else
    'github'
  end

describe 'jq class:', unless: UNSUPPORTED_PLATFORMS.include?(os[:family]) do
  it 'jq is expected run successfully' do
    pp = "class { 'jq': }"

    # Apply twice to ensure no errors the second time.
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to match(%r{error}i)
    end
    apply_manifest(pp, catch_failures: true) do |r|
      expect(r.stderr).not_to eq(%r{error}i)

      expect(r.exit_code).to be_zero
    end
  end

  context 'jq exists at the specified version' do
    it 'installed successfully and check the version' do
      pp = "class { 'jq': package_source => '#{package_source}', }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end

      show_result = shell('jq --version')
      expect(show_result.stdout).to match(%r{jq-1.6})
    end
  end
end
