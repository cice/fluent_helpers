require 'rspec/expectations'

RSpec::Matchers.define :have_a_switch do |name, param, default|
  match do |page|
    param = param.to_s
    btn = page.find_link name

    uri = URI(btn[:href])
    params = Hash[URI.decode_www_form(uri.query)]

    param_matches = default ? !params.has_key?(param) : params[param] == '1'
    param_matches
  end

  failure_message do |page|
    "expected #{page.current_scope.tag_name} to have a switch named #{name} for param #{param}, checked: #{default}"
  end
end

RSpec::Matchers.define :have_a_search_field do |name, param|
  match do |page|
    param = param.to_s
    field = page.find_field name

    field[:name] == param.to_s
  end

  failure_message do |page|
    "expected #{page.current_scope.tag_name} to have a search field #{name} for param #{param}"
  end
end

RSpec::Matchers.define :have_a_page_header do |header|
  match do |page|
    h2 = page.find '.page-heading h2'

    @actual = h2.text
    header == @actual
  end

  diffable
end

RSpec::Matchers.define :have_breadcrumbs do |current, crumbs|
  match do |page|
    breadcrumb = page.find '.page-heading ol.breadcrumb'

    links = breadcrumb.find_all('li a').each_with_object({}) do |link, h|
      name = link.text
      href = link[:href]

      h[name] = URI(href).path
    end
    links[:current] = breadcrumb.find('li.active strong').text

    @actual = links

    links == crumbs.stringify_keys.transform_values { |v| URI(v).path }.merge(current: current)
  end

  diffable
end

RSpec::Matchers.define :have_row_action do |url_args, icon|
  match do |page|
    url = url.is_a?(String) ? url_args : polymorphic_url(url_args, routing_type: :path)
    link = page.find(:xpath, ".//a[@href='#{url}']")
    link.find "i.fa.fa-#{icon.to_s.gsub('_', '-')}"
  end
end

RSpec::Matchers.define :have_columns do |*column_classes|
  match do |page|
    page.within 'thead tr' do
      column_classes.each do |col|
        page.find "th.#{col}"
      end
    end
  end
end
