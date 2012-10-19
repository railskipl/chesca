module LooksHelper
  def all_children(look, array=[look.id])
    unless look.children.empty?
      look.children.each do |child|
        puts "#{child.id}-#{child.name}"
        array << child.id
        unless child.children.empty?
          all_children(child,array)
        end
      end
    end
    return array
  end
end
