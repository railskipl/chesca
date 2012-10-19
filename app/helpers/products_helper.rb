module ProductsHelper
  def main_image_for_product(product, size)
    if product.main_image
      product.main_image.image(size.to_sym)
    else
      if !product.product_images.empty?
        product.product_images.first.image(size.to_sym)
      else
        "#{size.to_s}/missing.png"
      end
    end
  end

  def sizes_for_product(product)
    if product.code.start_with?('8')
      if product.name.match(/\bShoes?\b/i)
        return [5, 6, 7, 8]
      else
        return ['Only one size']
      end
    elsif product.code.start_with?('4')
      return [1, 2, 3, 4]
    end

    [14, 16, 18, 20, 22, 24]
  end

  def display_sizing_chart_for_product?(product)
    !product.department.nil? && ['Dresses', 'Blouses', 'Skirts', 'Trousers', 'Knitwear', 'Jerseys'].include?(product.department.name)
  end

  def sizing_chart_for_product(product)
    case product.department.name
    when 'Dresses', 'Blouses'
      return 'sizing-chart-dresses-and-blouses'
    when 'Skirts'
      return 'sizing-chart-skirts'
    when 'Trousers'
      return 'sizing-chart-trousers'
    when 'Knitwear', 'Jerseys'
      return 'sizing-chart-knitwear-and-jersey-tops'
    else
      return ''
    end
  end
end

