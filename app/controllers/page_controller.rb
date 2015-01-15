class PageController < ApplicationController
  def home
    set_meta_tags description: 'Astra это Беларуский производитель рюкзаков и сумок. Astra Store - интернет-магазин, где вы сможете купить рюкзак или сумку в Минске по низкой цене.'
    # 'Astra это Беларуский производитель рюкзаков и сумок. Astra Store - интернет-магазин, где вы сможете купить самые интересные в Минске рюкзаки по низким ценам. Мы предлагаем рюкзаки для учебы, спорта и прогулок по городу, женские и детские, с доставкой по всей Беларуси.'

    @products = Product.by_pos.show
    render 'home_2'
  end

  def about
  end

  def contacts
  end
end
