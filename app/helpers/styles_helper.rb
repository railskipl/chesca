module StylesHelper
  def all_children(boutique, array=[boutique.id])
    unless boutique.children.empty?
      boutique.children.each do |child|
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
