module AsciiDoc
  module Filters
    
    # This filter runs through all the elements and converts their type from :title to one of h1, h2, h3, h4, h5, h6
    # This is because docbook has no level indication on <title>, instead it relies on nested <section> tags
    
    class TitleFilter
      def self.filter(element)
        find_title_in_children(element, 1)
      end
      
      def self.find_title_in_children(element, level)
        element.children.each do |child|
          unless child.is_a? String
            if child.type == :title
              child.type = "h#{level}".to_sym
              puts "h#{level}"
            end
            if child.children
              find_title_in_children(child, child.type == :section ? level + 1 : level)
            end
          end
        end
      end
    end
  end
end