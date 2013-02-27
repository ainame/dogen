require 'dogen/template/local_file_loader'

class Dogen
  class Template
    include LocalFileLoader

    attr_reader :raw_body, :template_path
    attr_accessor :rendered_body, :name

    class NotFoundTemplateError < StandardError; end
    def initialize(params = {})
      raise NotFoundTemplateError unless params[:raw_body]

      @name          = params[:name] || ''
      @raw_body      = params[:raw_body]
      @rendered_body = params[:rendered_body] || nil
      @template_path = params[:template_path]
    end

    def set_install_path(template_path = @template_path)
      matched_base_path = Dogen.template_dirs.select {|base_dir|
        template_path.match(base_dir)
      }.first

      relative_path = template_path.sub(
        matched_base_path + '/', ''
      )
      @install_path = File.join(
        File.dirname(relative_path),
        File.basename(relative_path, @extname)
      )
    end

  end
end
