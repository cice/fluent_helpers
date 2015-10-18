module FluentHelpers
  module Helpers
    module DefaultDecoration
      module_function
      def check_class
        'check'
      end

      def check_all_name
        'check_all'
      end

      def actions_class
        'actions'
      end

      def check_name
        'ids[]'
      end

      def action_class
        'action'
      end

      def default_classes
        ['table']
      end

      def row_data_id_name
        :id
      end
    end
  end
end
