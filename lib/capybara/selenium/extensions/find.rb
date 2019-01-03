# frozen_string_literal: true

module Capybara
  module Selenium
    module Find
      def find_xpath(selector, with_visiblity = false)
        els = find_context.find_elements(:xpath, selector)
        visibilities = if ((els.size <= 1) || !with_visiblity)
          []
        else
          execute_script("return arguments[0].map(%s)" % browser.send(:bridge).send(:read_atom, 'isDisplayed'), els)
        end
        els.map.with_index { |el, idx| build_node(el, visibilities[idx]) }
      end

      def find_css(selector, with_visiblity = false)
        els = find_context.find_elements(:css, selector)
        visibilities = if ((els.size <= 1) || !with_visiblity)
          []
        else
          execute_script("return arguments[0].map(%s)" % browser.send(:bridge).send(:read_atom, 'isDisplayed'), els)
        end
        els.map.with_index { |el, idx| build_node(el, visibilities[idx]) }
      end
    end
  end
end