require 'hetzner-api'
require 'spec_helper'

describe "Bootstrap" do
  before(:all) do
    @api = Hetzner::API.new ENV['HETZNER_ROBOT_USERNAME'], ENV['HETZNER_ROBOT_PASSWORD']
    @bootstrap = Hetzner::Boot::FreeBSD.new :api => @api
  end

  describe ".add_target(target)" do
    it "should be able to add a server to operate on" do
      @bootstrap.add_target dummy_target
      expect(@bootstrap.targets.size).to equal(1)
      expect(@bootstrap.targets.first).to be_an_instance_of(Hetzner::Boot::FreeBSD::Target)
    end
  end

  def dummy_target
    return {
      :ip            => "1.2.3.4",
      :login         => "MyHetznerUsername",
      :password      => "MyVerySecretPW",
      :rescue_os     => "freebsd",
      :rescue_os_bit => "64"
    }
  end

end
