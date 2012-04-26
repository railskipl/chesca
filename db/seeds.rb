# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

conn = ActiveRecord::Base.connection

def bool(value)
  ActiveRecord::Base.connection.quote ActiveRecord::ConnectionAdapters::Column.value_to_boolean(value)
end

def quote(value)
  ActiveRecord::Base.connection.quote(value)
end

departments = []
styles = []

puts 'Creating departments and styles...'

rows = FasterCSV.read("#{RAILS_ROOT}/config/seed_data/categories.csv", :headers => :first_row)
rows.each do |row|
  if row.field('type') == 'department'
    departments[row.field('id').to_i] = { :name => row.field('name') }
  else
    styles[row.field('id').to_i] = { :name => row.field('name') }
  end
end

Department.create(departments.compact) if Department.all.empty?
Style.create(styles.compact) if Style.all.empty?

departments.map! { |department| Department.find_by_name(department[:name]) unless department.nil? }
styles.map! { |style| Style.find_by_name(style[:name]) unless style.nil? }

puts 'Done.'

if Product.all.empty?
  product_main_images = {}

  puts 'Creating products...'

  rows = FasterCSV.read("#{RAILS_ROOT}/config/seed_data/products.csv", :headers => :first_row)
  rows.each do |row|
    now = "'#{Time.now.strftime('%Y-%m-%d %X')}'"

    department = departments[row.field('department_id').to_i] ? departments[row.field('department_id').to_i].id : 'NULL'

    style = styles[row.field('style_id').to_i] ? styles[row.field('style_id').to_i].id : 'NULL'

    conn.execute("INSERT INTO products (id, name, code, description, composition, price, old_price, visible, available, page_hits, department_id, style_id, created_at, updated_at) VALUES (#{row.field('id').to_i}, #{quote(row.field('name'))}, #{quote(row.field('code'))}, #{quote(row.field('long_desc'))}, #{quote(row.field('composition'))}, #{row.field('price').to_i}, #{row.field('old_price').to_i}, #{bool(row.field('visible'))}, #{bool(row.field('available'))}, #{row.field('page_hits').to_i}, #{department}, #{style}, #{now}, #{now})")

    product_main_images[row.field('id').to_i] = row.field('primary_picture')
  end

  puts 'Done.'
  puts 'Adding related products...'

  rows = FasterCSV.read("#{RAILS_ROOT}/config/seed_data/related_products.csv", :headers => :first_row)
  rows.each do |row|
    conn.execute("INSERT INTO products_products (product_id, related_product_id) VALUES (#{row.field('product_id').to_i}, #{row.field('related_product_id').to_i})")
  end

  puts 'Done.'
  puts 'Adding product images...'

  rows = FasterCSV.read("#{RAILS_ROOT}/config/seed_data/product_images.csv", :headers => :first_row)
  rows.each do |row|
    image_path = File.join(Rails.root, 'config/seed_data/product_images', row.field('picture_id'))
    if File.file?(image_path)
      product = Product.find(row.field('product_id').to_i)
      product.product_images << ProductImage.create(:product_id => product.id, :image => File.open(image_path))
      product.product_images.last.update_attribute(:main_image, true) if product_main_images[row.field('product_id').to_i] == row.field('picture_id')
    end
  end

  puts 'Done.'
end

=begin
products = {}
if Product.all.empty?
  rows = FasterCSV.read("#{RAILS_ROOT}/config/seed_data/products.csv", :headers => :first_row)
  rows.each do |row|
    product = Product.create({ :name => row.field('name'), :code => row.field('code'), :description => row.field('long_desc'), :composition => row.field('composition'), :price => row.field('price').to_i, :old_price => row.field('old_price').to_i, :visible => row.field('visible'), :available => row.field('available'), :page_hits => row.field('page_hits'), :department => departments[row.field('department_id').to_i], :style => styles[row.field('style_id').to_i] })

    products[row.field('id').to_i] = { :id => product.id, :main_image => row.field('primary_picture') }
  end
end

if !products.empty?
  rows = FasterCSV.read("#{RAILS_ROOT}/config/seed_data/related_products.csv", :headers => :first_row)
  rows.each do |row|
    if !products[row.field('product_id').to_i].nil? && !products[row.field('related_product_id').to_i].nil?
      product = Product.find(products[row.field('product_id').to_i][:id])
      product.related_products << Product.find(products[row.field('related_product_id').to_i][:id])
    end
  end
end

if ProductImage.all.empty?
  rows = FasterCSV.read("#{RAILS_ROOT}/config/seed_data/product_images.csv", :headers => :first_row)
  rows.each do |row|
    image_path = File.join(Rails.root, 'config/seed_data/product_images', row.field('picture_id'))
    if File.file?(image_path)
      product = Product.find(products[row.field('product_id').to_i][:id])
      product.product_images << ProductImage.create(:product_id => product.id, :image => File.open(image_path))
      product.product_images.last.update_attribute(:main_image, true) if products[row.field('product_id').to_i][:main_image] == row.field('picture_id')
    end
  end
end
=end

