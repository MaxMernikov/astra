class PageController < ApplicationController
  def home
    set_meta_tags description: 'Astra это Беларуский производитель рюкзаков и сумок. Astra Store - интернет-магазин, где вы сможете купить городской рюкзак или сумку в Минске по низкой цене.',
      title: 'Магазин городских рюкзаков и сумок',
      image_src: root_url + ActionController::Base.helpers.asset_path("logo.png", type: :image)
    # 'Astra это Беларуский производитель рюкзаков и сумок. Astra Store - интернет-магазин, где вы сможете купить самые интересные в Минске рюкзаки по низким ценам. Мы предлагаем рюкзаки для учебы, спорта и прогулок по городу, женские и детские, с доставкой по всей Беларуси.'

    @products = Product.by_pos.show
    render 'home_2'
  end

  def about
    set_meta_tags title: 'О нас'
  end

  def contacts
    set_meta_tags title: 'Контакты'
  end
end
