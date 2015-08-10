# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://astrastore.by/'

SitemapGenerator::Sitemap.create do

  # Category.show.each do |category|
  #   add category_path(category.slug), :changefreq => 'weekly', priority: => 0.9
  # end
  Product.show.each do |product|
    add product_path(product), lastmod: product.updated_at
  end

  add page_about_path, lastmod: Date.new(2015, 05, 13)
  add page_contacts_path, lastmod: Date.new(2015, 05, 13)

  LookbookCategory.show.each do |lookbook|
    add lookbook_path(lookbook), lastmod: lookbook.updated_at
  end

end

SitemapGenerator::Sitemap.ping_search_engines(yandex: "http://blogs.yandex.ru/pings/?status=success&url=%s") 
# Not needed if you use the rake tasks
