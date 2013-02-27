# -*- coding: utf-8 -*-
require 'dogen/version'

class Dogen
  @template_dirs =  [
      File.expand_path(File.join(
          File.dirname(__FILE__), '../templates')
      )
  ]
  @plugin_dirs = [
    'dogen/enviroment/plugins'
  ]

  def self.add_template_dir(dir)
    @template_dirs.unshift(dir)
  end

  def self.add_plugin_dir(dir)
    @plugin_dirs.unshift(dir)
  end

  def self.template_dirs
    @template_dirs
  end

  def self.plugin_dirs
    @plugin_dirs
  end

  def initialize(builder)
    @builder = builder
  end

  def render
    @builder.render
    @builder.templates
  end

end

require_relative 'dogen/builder'
