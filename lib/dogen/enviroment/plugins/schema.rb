# -*- coding: utf-8 -*-

class Dogen
  class Enviroment
    module Plugins
      module Schema
        def self.included(base)
          base.register_variable('schema', Hash.new)
          base.register_variable('primary_key', Hash.new)
          base.register_helper(HelperMethods)
        end

        #
        # e.add_columnと書いても一緒だけど、あえて分けたい時に使える
        #
        def schema(&block)
          raise unless block_given?
          yield self
        end

        #
        # TODO: オプションを追加出来るようにする
        #
        def add_column(table, column, type)
          @schema[table.to_sym] = {} if @schema[table].nil?
          @schema[table.to_sym][column] = type
        end

        def primary_key(table_name, column = nil)
          return @primary_key[table_name.to_sym] unless column
          @primary_key[table_name.to_sym] = column
        end

        module HelperMethods
          def params_validate(table_name, options = {})
            target_table = if options[:only_primary_key]
                             {
                options[:only_primary_key] => @schema[table_name][options[:only_primary_key]]
              }
                           elsif options[:exclude_primary_key]
                             copy_table = @schema[table_name].dup
                             copy_table.delete(options[:exclude_primary_key])
                             copy_table
                           else
                             @schema[table_name]
                           end
            params_validate_block(target_table)
          end

          def params_validate_block(table)
            code_block = "my %params = Params::Validate::validate(@_, {\n"
            table.each do |column, type| 
              line = ''
              case type
              when 'integer'
                line = "=> { type => Params::Validate::SCALAR, regex => qr/\\A\\d+\\z/  },\n"
              when 'text', 'varchar'
                line = "=> { type => Params::Validate::SCALAR },\n"
              when 'datetime'
                line = "=> { type => Params::Validate::SCALAR, regex => qr/\\A\\d{4}\\-\\d{2}\\-\\d{2} \\d{2}:\\d{2}:\\d{2}\\z/ },\n"
              end
              line.prepend(formatted_column_name(column, get_longest_column_name(table)))
              code_block << line
            end

            code_block << "});\n"
          end

          def get_longest_column_name(table)
            table.map{|column, _| column.size }.max
          end

          def formatted_column_name(column, width)
            format = "    %-#{width}s "
            sprintf(format, column)
          end
        end
      end
    end
  end
end
