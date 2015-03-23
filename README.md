# hetzner-boot-freebsd

This gem provides a convenient way to boot a Hetzner root server into FreeBSD rescue environment which is based on [mfsBSD](http://mfsbsd.vx.sk). The mfsBSD project consists of multiple scripts that create a bootable ISO image that create a minimal FreeBSD installation.

[![Gem Version](https://badge.fury.io/rb/hetzner-boot-freebsd.png)](http://badge.fury.io/rb/hetzner-boot-freebsd)

## What `hetzner-boot-freebsd` does

We are running a considerable number of [FreeBSD](http://www.freebsd.org) servers in production as well as for development. We usually run FreeBSD jail hosts on bare metal servers hosted at Hetzner and encapsulate all services into jails to get a separation of services and to increase the security of the entire setup. We use BSDploy, Ansible and Fabric to provision the jail hosts as well as the FreeBSD jails themselves.

An essential step to get the servers provisioned is to have a well-defined starting point which in our case is always a mfsBSD running on the server to be provisioned. Hetzner provides a FreeBSD rescue system that is based on mfsBSD which we use as a starting point to provision the server. This Ruby Gem offers a very convenient way to reboot a Hetzner root server into this rescue environment.

This Ruby Gem is basically a stripped down wrapper for the `hetzner-api` Gem with the focus on bringing up any Hetzner server into the FreeBSD rescue system. 

## Implemented steps:

1. Enable FreeBSD rescue mode (using Hetzner's webservice)
2. Resetting the System to boot into rescue mode (using Hetzner's webservice)
3. Log into the rescue system and launch the installation

## Requirements

First of all retrieve your API login credentials from the Hetzner admin interface at [https://robot.your-server.de](https://robot.your-server.de). Additionally you need the IP address of the system that you want to provision.

## Installation

    $~ gem install hetzner-boot-freebsd

The `hetzner-freebsd-boot` Ruby Gem requires the credentials for Hetzner's HTTP API to manage the server. These credentials must be available via the environment variables `HETZNER_ROBOT_USERNAME` and `HETZNER_USERNAME_PASSWORD`. You cen set the either in `~/.bash_profile`:

	export HETZNER_ROBOT_USERNAME="MyHetznerUsername"
	export HETZNER_ROBOT_PASSWORD="MyVerySecretHetznerPW"

or create a `.env` file in your Ruby project directory and define them there:

	HETZNER_ROBOT_USERNAME="MyHetznerUsername"
	HETZNER_ROBOT_PASSWORD="MyVerySecretHetznerPW"

## Example

See `example.rb` file for usage. The example requires valid credentials for the Hetzner HTTP API (see the both environment variables `HETZNER_ROBOT_USERNAME` and `HETZNER_ROBOT_PASSWORD` above) as well as a concrete target host to reboot (environment variables `HETZNER_ROBOT_IP_ADDRESS` and `HETZNER_ROBOT_HOSTNAME`). Export them either via your `~/.bash_profile`:

	export HETZNER_ROBOT_IP_ADDRESS="1.2.3.4"
	export HETZNER_ROBOT_HOSTNAME="freebsd.example com"

... or append them to the `.env` file within your project that will be read by `dotenv`:

	HETZNER_ROBOT_IP_ADDRESS="1.2.3.4"
	HETZNER_ROBOT_HOSTNAME="freebsd.example com"

Afterwards open a new shell and navigate into your project directory. All 4 environment variables should be now exposed for the example code.

```ruby

#!/usr/bin/env ruby
require "rubygems"
require "hetzner-boot-freebsd"

# Retrieve your API login credentials from the Hetzner admin interface
# at https://robot.your-server.de and assign the appropriate environment
# variables ENV['ROBOT_USER'] and ENV['ROBOT_PASSWORD']

bs = Hetzner::Boot::FreeBSD.new(:api => Hetzner::API.new(ENV['ROBOT_USER'], ENV['ROBOT_PASSWORD']))

# The post_install hook is the right place to launch further tasks (e.g.
# software installation, system provisioning etc.)
post_install = <<EOT
  # TODO
EOT

bs << {:ip => "1.2.3.4",
  :hostname => 'artemis.asconix.com',
  :public_keys => "~/.ssh/id_rsa.pub",
  :post_install => post_install
}

bs.bootstrap!

```

## Warnings:

* All existing data on the system will be wiped on bootstrap!
* This is not an official Hetzner AG project.
* The gem and the author are not related to Hetzner AG!

**Use at your very own risk. Satisfaction is NOT guaranteed.**

## Thank you greeting

This Ruby gem is inspired by the [hetzner-bootstrap](https://github.com/rmoriz/hetzner-bootstrap) gem and requires the underlying wrapper for the Hetzner server management API [hetzner-api](https://github.com/rmoriz/hetzner-api). Thus I want to thank [Roland Moriz](https://roland.io/developer) a lot for his great work!

## Cheat sheet

Hetzner provides a very powerfull HTTP API. Here are some simple use cases for this API:

*Put a server into rescue mode (here FreeBSD 64-bit)*:

	$~ curl -u $ROBOT_USER:$ROBOT_PASSWORD https://robot-ws.your-server.de/boot/136.243.0.21/rescue -d 'os=freebsd&arch=64'

*Restart the server by hardware reset*:

	$~ curl -u $ROBOT_USER:$ROBOT_PASSWORD https://robot-ws.your-server.de/reset/136.243.0.21 -d 'type=hw'

## Copyright

Copyright (c) 2015 Asconix Systems AS, Christoph Pilka, [http://asconix.com](http://asconix.com)
