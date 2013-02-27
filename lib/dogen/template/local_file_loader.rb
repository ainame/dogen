class Dogen
  class Template
    module LocalFileLoader
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def create_from_local_file(template_name)
          template_path = self.find_file_from_template_name(template_name)
          raise NotFoundTemplateError.new("not found #{template_path}") if template_path.blank?

          raw_body = self.load_file(template_path)
          raise NotFoundTemplateError.new("template is empty.") if raw_body.blank?

          params = {
            :template_path => template_path,
            :extname       => File.extname(template_path),
            :raw_body      => raw_body,
            :rendered_body => nil,
          }
          template = Template.new(params)
          template.set_install_path
          template.get_custom_fields

          template
        end

        def load_file(template_path)
          File.read(template_path)
        end

        def find_file_from_template_name(template_name)
          self.template_paths.select do |path|
            path =~ /#{template_name}/
          end.first
        end

        def template_paths
          template_dir_globs = Dogen.template_dirs.map do |base_dir|
            File.join(base_dir,'/**/*')
          end
          Dir[*template_dir_globs].select do |path|
            path =~ /\./
          end
        end
      end
    end
  end
end
