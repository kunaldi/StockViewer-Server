$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
require 'mongoid'

Bundler.require :default, ENV['RACK_ENV']
Mongoid.load!(File.expand_path('mongoid.yml', './config'))

module Mongoid
  module Document
    def as_json(options={})
      attrs = super(options)
      attrs["id"] = attrs["_id"].to_s
      attrs
    end
  end
end

Dir[File.expand_path('../../app/**/*.rb', __FILE__)].each do |f|
  require f
end