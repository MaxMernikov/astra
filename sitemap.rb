require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://astrastore.by/'
SitemapGenerator::Sitemap.create do
  Category.show.each do |category|
    add category_path(category.slug), :changefreq => 'weekly', :priority => 0.9
  end
  Product.show.each do |product|
    add product_path(product)
  end
end
# SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks