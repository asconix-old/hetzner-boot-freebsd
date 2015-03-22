#!/usr/bin/env ruby
require 'rubygems'
require 'hetzner-boot-freebsd'

# Retrieve your API login credentials from the Hetzner admin interface
# at https://robot.your-server.de and assign the appropriate environment
# variables:
#
#   $~ export HETZNER_ROBOT_USERNAME="MyHetznerUsername"
#   $~ export HETZNER_ROBOT_PASSWORD="MyVerySecretPassword"
#   $~ export HETZNER_ROBOT_IP_ADDRESS="1.2.3.4"
#   $~ export HETZNER_ROBOT_HOSTNAME="freebsd.example.com"
#
# Next launch the bootstrap script:
#
#     $~ ./example.rb

api = Hetzner::API.new ENV['HETZNER_ROBOT_USERNAME'], ENV['HETZNER_ROBOT_PASSWORD']
rescue_env = Hetzner::Boot::FreeBSD.new :api => @api

rescue_env << {
    :ip => ENV['HETZNER_ROBOT_IP_ADDRESS'],
    :hostname => ENV['HETZNER_ROBOT_HOSTNAME'],
    :public_keys => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAxpbPqgja8qK0pRBu423nuj7ZqJY/VPyABvBtcHQBpnaz20hSo89K+yEJmdg4upKk54906u7OT5tGaFpTYQKUxGgdKO1my8y2tXHDdTGw1A3BZotgIwDDvNTrIYW8JlGOBTVQuHGm6EYf8tEVut+dhueSe0VsK3keTQQwwatSf4uBgYxRMorsVWFVwk+YH2RKC25pbh0teoagL1TVts4OqGTcRJtrO9PHkuHFNCqA5IQVf+BRzwyCNWGaLuX3W/+DOOx3u76UhKBWrWXicVksFUD7tnFJrZohLu6PtKBoSSlVYVO/YgXQEJtsvG1EmEaoMnM2TvdzIWcopdd2jIo8Cw== c.pilka@asconix.com'
}

rescue_env.bootstrap!
