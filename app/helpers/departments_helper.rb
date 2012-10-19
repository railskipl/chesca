module DepartmentsHelper
  def all_children(department, array=[department.id])
    unless department.children.empty?
      department.children.each do |child|
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
