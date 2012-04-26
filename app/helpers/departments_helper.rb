module DepartmentsHelper
  def all_children(category, array=[category.id])
    unless category.children.empty?
      category.children.each do |child|
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
