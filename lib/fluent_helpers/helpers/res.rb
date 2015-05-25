module FluentHelpers
  module Helpers
    class Res < Base
      def initialize template, resource
        super template
        @resource = resource
      end

      def action type
        action_for @resource, type
      end

      def action_for resource, type
        @_.link.to(resource).title(@_.t type, scope: 'actions').named @_.icn.for type
      end

      def show
        action :show
      end

      def edit
        action_for([:edit, *@resource], :edit).remote
      end

      def edit_name
        action_for([:edit_name, *@resource], :edit).remote
      end

      def delete
        action(:delete).method :delete
      end

      def new
        action_for [:new, *@resource], :new
      end

      def index
        action :index
      end
    end
  end
end
