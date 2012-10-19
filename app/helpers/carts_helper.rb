module CartsHelper
  def show_percentage(percent)
    number_to_percentage(percent, :precision => 0)
  end
end
