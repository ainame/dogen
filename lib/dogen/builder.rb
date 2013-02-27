# -*- coding: utf-8 -*-
require 'dogen/enviroment'
require 'dogen/renderer'
require 'dogen/template'

class Dogen::Builder

  def initialize(env)
    @enviroment = env
    @templates  = []
  end

  def build(params = nil, &block)
    yield self if params.nil? && block_given?
  end

  def enviroment(params = nil, &block)
    return @enviroment unless block_given?
    yield @enviroment
  end

  def render
    @templates.map do |template|
      renderer = Dogen::Renderer.new(template, @enviroment)
      renderer.render
      template
    end
  end

  def templates
    @templates
  end

  def add_template(template)
    @templates.push template
  end

end
