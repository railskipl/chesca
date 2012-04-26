module Admin::ProductsHelper
  def collection_level(object, selected)
    if selected.is_a? Fixnum
      selected =[selected]
    end
    array =[]
    if selected
      object.each do |o|
        if o.parent.nil?
          if selected.include? o.id.to_i
            array << "<option value=\"#{o.id}\" selected=\"selected\">#{o.name}</option>"
          else
            array << "<option value=\"#{o.id}\">#{o.name}</option>"
          end
          if !o.children.empty?
            level=1
            array << childrens_only(o,level,array,selected)
          end
        end
      end
    else
      object.each do |o|
        if o.parent.nil?
          array << "<option value=\"#{o.id}\">#{o.name}</option>"
          if !o.children.empty?
            level=1
            array << childrens_only(o,level,array, nil)
          end
        end
      end
    end
    return array
  end
  def childrens_only(object,level,array, selected)
    if selected
      object.children.each do |child|
        aux = "&nbsp;&nbsp;&nbsp;&nbsp;"*level
        if selected.include? child.id.to_i
          array << "<option value=\"#{child.id}\" selected = \"selected\">#{aux}#{child.name}</option>"
        else
          array << "<option value=\"#{child.id}\">#{aux}#{child.name}</option>"
        end
        if !child.children.empty?
          childrens_only(child,level+1,array,selected)
        end
      end
    else
      object.children.each do |child|
        aux = "&nbsp;&nbsp;&nbsp;&nbsp;"*level
        array << "<option value=\"#{child.id}\">#{aux}#{child.name}</option>"
        if !child.children.empty?
          childrens_only(child,level+1,array, nil)
        end
      end
    end
    return array
  end
  def options_colors(colors)
    options=""
    colors.each do |o|
      options += content_tag :option, :title => o.image.url(:square), :value => o.id do
        o.name
      end
    end
    return options
  end
end
