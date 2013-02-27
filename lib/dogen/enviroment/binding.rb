#
#
#
class Dogen
  class Enviroment
    class Binding < BasicObject
      def initialize(init_params = {})
        @params ||= {}
        set_from_hash(init_params)
      end

      def get_binding
        binding
      end

      private
      def params
        @params
      end
    end
  end
end
