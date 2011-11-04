plugin = {
  :name => :ordered_list,
	:regexp  =>  /^.\s{1}/,
	:handler => lambda { |lines, element|
    
    lis = []
    e = AsciiDoc::AsciiElement.new(:li)
    e.children <<  lines.current_line.gsub(/^.\s{1}/, "")
    lis << AsciiDoc::AsciiBlock.new(e).element 
    
    while(lines.shift_line) do
      break if not lines.current_line =~ /^.\s{1}/
      e = AsciiDoc::AsciiElement.new(:li)
      e.children <<  lines.current_line.gsub(/^.\s{1}/, "")
      lis << AsciiDoc::AsciiBlock.new(e).element 
    end
    
    ordered_list = AsciiDoc::AsciiElement.new(plugin[:name])
    ordered_list.children = lis
    element.children << ordered_list
	}
}

AsciiDoc::AsciiPlugins::register(plugin)