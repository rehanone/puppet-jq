class jq::install inherits jq {
  assert_private("Use of private class ${name} by ${caller_module_name}")

  $binary = $::facts['architecture'] ? {
    'i386'   => 'jq-linux32',
    'amd64'  => 'jq-linux64',
    'x86_64' => 'jq-linux64',
    default  => fail("Unsupported architecture: ${::facts['architecture']}"),
  }

  if $jq::package_manage {
    case $jq::package_source {
      'os': {
        file { "${jq::install_dir}/jq":
          ensure => absent,
        }

        package { $jq::package_name:
          ensure => $jq::package_ensure,
        }
      }
      'github': {
        package { $jq::package_name:
          ensure => absent,
        }

        file { $jq::download_dir:
          ensure => directory,
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        }

        require wget
        wget::retrieve { "${jq::download_url}/jq-${jq::download_version}/${binary}":
          destination => "${jq::download_dir}/${binary}",
          verbose     => true,
          mode        => '0755',
          require     => File[$jq::download_dir],
        }
        -> file { "${jq::download_dir}/${binary}":
          ensure => file,
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        }
        -> file { "${jq::install_dir}/jq":
          ensure => link,
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
          target => "${jq::download_dir}/${binary}",
        }
      }
      default: {
        fail("Unsupported package source: ${jq::package_source}")
      }
    }
  }
}
