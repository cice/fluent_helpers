module FluentHelpers
  module Helpers
    class Icn < Base
      MAPPING = {
        sign_out: :sign_out,
        new: :plus,
        show: :arrow_right,
        back: :arrow_left,
        refresh: :refresh,
        edit: :pencil,
        add: :plus_circle,
        remove: :minus_circle,
        delete: :trash,
        merge: :link,
        settings: :cog,
        cross: :th,
        grid: :th,
        list: :th_list,
        rendered: :eye,
        html: :code,
        md: :align_left,
        yes: :check,
        no: :close,
        test: :database,
        search: :search,
        fix: :wrench,
        run: :play,
        upload: :upload,
        download: :download,
        change_class: :long_arrow_right,
        close: :close,
        key: :key,
        copy: :files_o,
        quicklook: :eye,
        import: :plus_square,
        move: :long_arrow_right,
        collapse: :chevron_up,
        prices: :tags,
        unchecked: :square_o,
        checked: :check_square_o,
        requeue: :play_circle,
        mapped_to: :long_arrow_right,
        kill: :close,
        revive: :medkit
      }

      def to_s
        @_.span '', class: css_class
      end

      def type type
        @type = type
        self
      end

      def for action
        type MAPPING[action.to_sym]
      end

      protected
      def css_class
        "fa fa-#{@type}".gsub '_', '-'
      end
    end
  end
end
