require 'spec_helper'

describe FluentHelpers::Helpers::Using do
  let(:template) { TemplateStub.new.tap { |t| t.extend FluentHelpers::Helpers::Using::Mixin } }

  example 'Simple record and replay' do
    helper = double :helper
    with_using = template.method :with_using
    allow(template).to receive(:some_helper) { with_using.call helper }

    expect(helper).to receive :whatever_method
    expect(helper).to receive :you_like

    template.using.whatever_method.you_like do
      template.some_helper
    end
  end

  example 'Nested record and replay' do
    helper = double :helper
    allow(template).to receive(:some_helper) { template.send :with_using, helper }

    expect(helper).to receive :whatever_method
    expect(helper).to receive :you_like

    template.using.whatever_method do
      template.using.you_like do
        template.some_helper
      end
    end
  end

  example 'Restore the using stack after block ends' do
    helper_a = double :helper
    helper_b = double :helper
    allow(template).to receive(:some_helper) { template.send :with_using, helper_a }
    allow(template).to receive(:some_other_helper) { template.send :with_using, helper_b }

    expect(helper_a).to receive :whatever_method
    expect(helper_a).to receive :you_like

    expect(helper_b).to receive :whatever_method

    template.using.whatever_method do
      template.using.you_like do
        template.some_helper
      end

      template.some_other_helper
    end
  end
end

