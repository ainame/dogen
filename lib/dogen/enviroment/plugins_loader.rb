# -*- coding: utf-8 -*-
require 'dogen/enviroment'
require 'active_support/core_ext/string'

class Dogen
  class Enviroment
    module PluginsLoader
      def self.perform(plugin_name)
        plugin_filename = plugin_name.underscore
        class_name      = plugin_name.classify
        Dogen.plugin_dirs.each do |base_dir|
          begin
            require File.join(base_dir, plugin_filename)
            klass = ::Dogen::Enviroment::Plugins.const_get(class_name)
            ::Dogen::Enviroment.register_plugin(klass)
          rescue => e
            warn e.message
            next
          end
        end
      end
    end
  end
end
