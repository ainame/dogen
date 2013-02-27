class Dogen
  class Enviroment
    module Plugins
      module Author
        def self.included(base)
          base.register_variable('author', '')
          base.register_helper(HelperMethods)
        end

        module HelperMethods
          def author_upcase
            author.upcase
          end
          
          def author_downcase
            author.downcase
          end
        end
      end
    end
  end
end
