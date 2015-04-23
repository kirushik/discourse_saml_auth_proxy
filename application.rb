#!/usr/bin/env ruby

require 'goliath'
require_relative "app/apis/sso"

class Application < Goliath::API
  def response(env)
    API::SSO.call(env)
  end
end
