class Dogen
  class Enviroment
    module Plugins
      module ClassName
        def self.included(base)
          base.register_variable('class_name', '')
        end
      end
    end
  end
end
