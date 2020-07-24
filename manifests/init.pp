
class jq (
  Enum[github, os]      $package_source,
  Boolean               $package_manage,
  String                $package_ensure,
  String                $package_name,
  String[1]             $download_version,
  Stdlib::Httpsurl      $download_url,
  Stdlib::Absolutepath  $download_dir,
  Stdlib::Absolutepath  $install_dir,
) {
  anchor { "${module_name}::begin": }
  -> class { "${module_name}::install": }
  -> anchor { "${module_name}::end": }
}
