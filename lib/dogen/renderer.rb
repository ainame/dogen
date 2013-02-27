require 'erb'

class Dogen::Renderer
  def initialize(template, enviroment)
    @template   = template
    @enivroment = enviroment
    @binding    = enviroment.get_binding.taint
  end
  
  def render
    render_erb
  end

  private
  def render_erb
    begin
      # safe_level = 4, trim_mode = 1
      #evaluator = ERB.new(@template.raw_body, 4, 1)
      evaluator = ERB.new(@template.raw_body)
      tmp = evaluator.result(@binding)
      @template.rendered_body = tmp
    rescue => e
      warn evaluator.src
      warn e.message
    end
  end
end
