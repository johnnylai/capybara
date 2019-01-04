# frozen_string_literal: true

module Capybara
  module Selenium
    module Find
      def find_xpath(selector, with_visibility = false)
        find_by(:xpath, selector, with_visibility)
      end

      def find_css(selector, with_visibility = false)
        find_by(:css, selector, with_visibility)
      end

    private

      def find_by(format, selector, with_visibility)
        els = find_context.find_elements(format, selector)
        visibilities = if with_visibility && els.size > 1
          element_visibilities(els)
        else
          []
        end
        els.map.with_index { |el, idx| build_node(el, visibilities[idx]) }
      end

      def element_visibilities(elements)
        execute_script(
          format('return arguments[0].map(%<atom>s)', atom: browser.send(:bridge).send(:read_atom, 'isDisplayed')),
          elements
        )
      end
    end
  end
end
