
class jq::install inherits jq {

  assert_private("Use of private class ${name} by ${caller_module_name}")

  file { $jq::download_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  if $jq::wget_manage {
    require ::wget
  }

  $binary = $::facts['architecture'] ? {
    'i386'  => 'jq-linux32',
    'amd64' => 'jq-linux64',
    default => fail("Unsupported architecture: ${::facts['architecture']}"),
  }

  wget::retrieve { "${jq::download_url}/jq-${jq::download_version}/${binary}":
    destination => "${jq::download_dir}/${binary}",
    verbose     => true,
    mode        => '0755',
    require     => File[ $jq::download_dir],
  }
  ->
  file { "${jq::download_dir}/${binary}":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  ->
  file { "${jq::install_dir}/jq":
    ensure => link,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    target => "${jq::download_dir}/${binary}",
  }
}
