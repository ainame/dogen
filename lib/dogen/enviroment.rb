# -*- coding: utf-8 -*-
require 'dogen/enviroment/pluggable'
require 'dogen/enviroment/plugins_loader'

# TODO: 現在のEnviromentクラスをFactoryクラスにし、
#       環境の実体をBasicObjectを継承したclassに切り出す
class Dogen
  class Enviroment
    def initialize(init_params = {})
      @params ||= {}
      set_from_hash(init_params)
    end

    def set_from_hash(init_params)
      init_params.each do |key,value|
        key_str = key.to_s
        set_param(key_str, value)
        self.class.define_getter_and_setter(key_str)
      end
    end

    def add_params(params)
      raise "Invalid Type Error" unless params.kind_of?(Hash)
      @params.merge!(params)
    end

    def set_custom_field(name, value)
      set_param(name.to_s, value)
    end

    def custom_field(name)
      @params[name.to_s]
    end

    def inspect
      str = "--------Dogen::Enviroment-------\n"
      params.each do |key, value|
        str += "#{key} : #{value}\n"
      end
      str += "--------------------------------------\n"

      str
    end

    def get_binding
      binding
    end

    def get_param(key)
      @param[key.to_s]
    end

    private
    def params
      @params
    end

    def set_param(key, value)
      @params[key.to_s] = value
    end

    include Pluggable
    %w{
      namespace schema resource common_helper author class_name hiveql
    }.each do |plugin_name|
      PluginsLoader.perform(plugin_name)      
    end
  end
end
