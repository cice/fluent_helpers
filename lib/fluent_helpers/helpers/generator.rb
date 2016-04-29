module FluentHelpers
  module Helpers
    class Generator < ActiveSupport::ProxyObject
      def initialize(template)
        @template = template
      end

      TAGS = %w[
        a
        abbr
        address
        article
        aside
        b
        blockquote
        body
        br
        button
        canvas
        caption
        cite
        code
        col
        colgroup
        data
        datalist
        dd
        del
        details
        dfn
        div
        dl
        dt
        em
        fieldset
        figure
        footer
        form
        h1
        h2
        h3
        h4
        h5
        h6
        header
        hr
        i
        iframe
        img
        input
        ins
        kbd
        label
        legend
        li
        main
        mark
        mathml
        menu
        meter
        nav
        ol
        optgroup
        option
        output
        p
        pre
        progress
        q
        s
        samp
        section
        select
        small
        span
        strong
        sub
        summery
        sup
        svg
        table
        tbody
        tbody
        td
        textarea
        th
        thead
        time
        title
        tr
        u
        ul
        var
        wbr
      ]

      TAGS.each do |tag|
        class_eval <<-RUBY
          def #{tag} *args, &block
            @template.content_tag :#{tag}, *args, &block
          end

          def #{tag}! *args, &block
            @template.concat #{tag}(*args, &block)
          end
        RUBY
      end

      protected
      def method_missing(method, *args, &block)
        name = method.to_s
        name_to_define, name_to_call = name.ends_with?('!') ? [name[0..-2], name] : [name, name]
        __def_proxy__ name_to_define
        __send__ name_to_call, *args, &block
      end

      private
      def __def_proxy__(name)
        ::FluentHelpers::Helpers::Generator.class_eval <<-RUBY
          def #{name} *args, &block
            @template.send :#{name}, *args, &block
          end

          def #{name}! *args, &block
            @template.concat #{name}(*args, &block)
          end
        RUBY
      end
    end
  end
end
