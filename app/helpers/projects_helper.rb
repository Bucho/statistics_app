module ProjectsHelper
  def parser_stat(stats=[])
    content = ""
    if stats.is_a?(Array)
      stats.each do |s|
        content += content_tag(:ul) do
          content_tag(:li) do
            "#{s["title"]}: #{s["value"]} #{parser_stat(s["childs"])}"
          end
        end
      end
    end
    content
  end
end
