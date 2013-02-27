require 'active_support/core_ext/string'

class Dogen
  class Enviroment
    module Plugins
      module Resource
        def self.included(base)
          base.register_variable('resource', '')
          base.register_helper(HelperMethods)
        end

        module HelperMethods
          def resource_class_name
            resource.to_s.classify
          end

          def table_name
            resource.to_s
          end
        end
      end
    end
  end
end
