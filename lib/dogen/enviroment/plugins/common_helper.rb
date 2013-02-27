class Dogen
  class Enviroment
    module Plugins
      module CommonHelper
        DEFAULT_INDENT_TAB_WIDTH = 4

        def self.included(env)
          env.register_variable('indent_tab_width', DEFAULT_INDENT_TAB_WIDTH)
          env.register_helper(HelperMethods)
        end

        module HelperMethods
          def package_name
            [namespace, class_name].join('::')
          end

          def indent_format(code_block, indent_level)
            p indent_level
            p indent_tab_width
            format_indent_width = indent_level * indent_tab_width
            indent_formatted_code_block(code_block, format_indent_width)
          end

          def indent_formatted_code_block(code_block, indent_width)
            indent_whitespaces = " " * indent_width
            aligned_code_block = code_block.each_line.map do |line| 
              line.prepend(indent_whitespaces)
            end.join

            aligned_code_block
          end

        end
      end
    end
  end
end
