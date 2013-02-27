# -*- coding: utf-8 -*-
class Dogen
  class Enviroment
    module Pluggable
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        @@initializers = {}

        def self.extended(base)
          base.class_eval do
            def initialize_plugins
              @@initializers.each do |variable_name, intializer| 
                initialized_value = @@initializers[variable_name].call
                set_param(variable_name, initialized_value)
                self.class.define_getter_and_setter(variable_name)
              end
            end

            # pluginのデフォルト値が先に@paramsに設定される
            # without_pluginsでユーザーの入力を反映させる
            def initialize_with_plugins(params = {})
              @params = {}
              initialize_plugins
              initialize_without_plugins(params)
            end

            alias_method :initialize_without_plugins, :initialize 
            alias_method :initialize, :initialize_with_plugins
          end
        end
      
        def define_getter_and_setter(variable_name)
          define_method("#{variable_name}=") do |value|
            @params[variable_name.to_s] = value
          end
          
          define_method(variable_name) do 
            @params[variable_name.to_s]
          end
        end

        def register_plugin(plugin_module)
          include(plugin_module)
        end
        
        def register_variable(variable_name, initializer)
          initializer_proc = initializer.kind_of?(Proc) ? initializer : Proc.new { initializer }
          @@initializers[variable_name] = initializer_proc
        end

        def register_helper(helper_module)
          include(helper_module)
        end
      end
    end
  end
end
