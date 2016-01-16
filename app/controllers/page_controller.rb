class PageController < ApplicationController
  def home
    set_meta_tags description: 'Astra это Беларуский производитель рюкзаков и сумок. Astra Store - интернет-магазин, где вы сможете купить городской рюкзак или сумку в Минске по низкой цене.',
      title: 'Магазин городских рюкзаков и сумок',
      image_src: root_url + ActionController::Base.helpers.asset_path("logo.png", type: :image)


    # @products = Product.by_pos.show
    @galery = LookbookCategory.last.lookbook_items.order(:row).to_json(:only => [:id], :methods => [:col, :row, :size_x, :size_y, :bg_position, :bg_size])
    render 'new_home', layout: 'webflow'
  end

  def about
    set_meta_tags title: 'О нас'
    render 'about', layout: 'webflow'
  end

  def contacts
    set_meta_tags title: 'Контакты'
    render 'contacts', layout: 'webflow'
  end

  def cart
    @cart_items = []
    cart_items_ids = []
    cart_items_ids = JSON.parse(cookies[:astra_cart]) if cookies[:astra_cart].present?
    cart_items_ids.each{|id| @cart_items << Product.find_by(id: id)}

    render 'cart', layout: 'webflow'
  end

  def thankyou
    @order = Order.find_by(id: cookies[:astra_order])
    @products = @order.product_ids.map{ |i| Product.find(i) } if @order.present?
    cookies.delete(:astra_order)

    render 'thankyou', layout: 'webflow'
  end

  def test
    render 'test', layout: 'webflow'
  end
end
