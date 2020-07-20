require 'spec_helper_acceptance'

describe 'jq class:', unless: UNSUPPORTED_PLATFORMS.include?(fact('osfamily')) do
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
      pp = "class { 'jq': download_version => '1.6' }"

      apply_manifest(pp, catch_failures: true) do |r|
        expect(r.stderr).not_to match(%r{error}i)
      end

      show_result = shell('jq --version')
      expect(show_result.stdout).to match(%r{jq-1.6})
    end
  end
end
