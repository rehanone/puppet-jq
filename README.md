# jq

[![Puppet Forge](http://img.shields.io/puppetforge/v/rehan/jq.svg)](https://forge.puppetlabs.com/rehan/jq) [![Build Status](https://travis-ci.org/rehanone/puppet-jq.svg?branch=master)](https://travis-ci.org/rehanone/puppet-jq)

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with jq](#setup)
    * [Basic usage](#basics)
    * [Setup requirements](#setup-requirements)
3. [Usage - Configuration options and additional functionality](#usage)
    * [Classes](#classes)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Dependencies - Other modules used by this module.](#dependencies)
6. [Development - Guide for contributing to the module](#development)

## Description

`jq` is a lightweight and flexible command-line JSON processor. This module can manage installation and configuration of [jq](https://stedolan.github.io/jq/).
It downloads the jq binaries from the github [releases](https://github.com/stedolan/jq/releases).

## Setup

### Basics

In order to install `rehan-jq`, run the following command:
```bash
$ puppet module install rehan-jq
```
The module can be used with `hiera` to provide all configuration options. See [Usage](#usage) for examples on how to configure it.

### Setup Requirements

This module is designed to be as clean and compliant with latest puppet code guidelines. It works with:

  - `puppet >=5.5.10`

## Usage

### Classes

#### `jq`

A basic install with the defaults would be:
```puppet
include jq
```

Otherwise using the parameters:  
```puppet
  class{ 'jq':
    download_version => '1.6',
    download_url     => 'https://github.com/stedolan/jq/releases/download',
    download_dir     => '/opt/jq',
    install_dir      => '/usr/local/bin',
  }
```

##### Parameters

* **download_version**: The version of `jq` to install. The default is the latest version available.
* **download_url**: Download URL for `jq`. The default is github releases page of `jq`.
* **download_dir**: Location where the `jq` binaries are being downloaded. Defaults to `/opt/jq`
* **install_dir**: Location where the `jq` binaries are linked to that makes them available to system path. Defaults to `/usr/local/bin`.


All of this data can be provided through `Hiera`. 

**YAML**
```yaml
jq::download_version: '1.6'
jq::download_url: 'https://github.com/stedolan/jq/releases/download'
jq::download_dir: '/opt/jq'
jq::install_dir: '/usr/local/bin'
```


## Limitations

Currently, this module only supports Linux based systems.

## Dependencies

* [stdlib][1]
* [wget][2]

[1]:https://forge.puppet.com/puppetlabs/stdlib
[2]:https://forge.puppet.com/rehan/wget

## Development

You can submit pull requests and create issues through the official page of this module on [GitHub](https://github.com/rehanone/puppet-jq).

For more details about the development workflow and on how to contribute,
please check the [CONTRIBUTING.md](.github/CONTRIBUTING.md).

Please do report any bug and suggest new features/improvements.
