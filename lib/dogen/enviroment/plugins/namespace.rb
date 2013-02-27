class Dogen
  class Enviroment
    module Plugins
      module Namespace
        def self.included(base)
          base.register_variable('namespace', '')
        end
      end
    end
  end
end
