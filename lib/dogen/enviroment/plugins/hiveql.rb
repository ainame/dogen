# -*- coding: utf-8 -*-

require 'json'
require 'date'
require 'active_support/all'
class Dogen
  class Enviroment
    module Plugins
      module Hiveql
        def self.included(base)
          base.register_variable('json_dataset', '')
          base.register_variable('_dataset', nil)
          base.register_helper(HelperMethods)
        end

        module HelperMethods
          def date_loop start_date_str, end_date_str
            start_date_obj = Date.parse(start_date_str)
            end_date_obj   = Date.parse(end_date_str)

            diff = end_date_obj - start_date_obj            
            diff.to_i.times do |delta|
              current_date = (start_date_obj + delta).to_s
              yield current_date if block_given?
            end
          end

          def match_path path
            %|parse_url(concat("http://aa.jp", url),"PATH") = "#{path}"|
          end

          def match_query key, value
            %|parse_url(concat("http://aa.jp", url),"QUERY", "#{key}") = "#{value}"|
          end

          def url_query key
            %|parse_url(concat("http://aa.jp", url),"QUERY", "#{key}")|
          end

          def url_path
            %|parse_url(concat("http://aa.jp", url),"PATH")|
          end

          def q expression
            quote(expression)
          end

          def quote expression
            %|"#{expression}"|
          end

          def and_where_valid_access
            where_clause = <<EOS
and status regexp '^2' and member_id <> '-'
EOS
            where_clause
          end

          def dataset
            JSON.parse(json_dataset)
          end
        end
      end
    end
  end
end
