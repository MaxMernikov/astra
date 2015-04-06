class Product < ActiveRecord::Base
  PARAMS = [:size, :zipper, :material, :lining, :compartments, :pockets]
  belongs_to :category
  has_settings :params

  has_many :images

  has_many :galeries
  has_many :lookbook_items, through: :galeries


  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  has_many :orders

  validates :cost, :title, :images, presence: true

  scope :show, -> { where(show: true) }
  scope :by_pos, -> { order(:pos) }

  # callbacks
  after_create   :generate_vk_photo_images, :upload_vk_product
  before_update  :check_vk_association, :vk_product_caption_update
  before_destroy :delete_vk_product

  # vk part
  has_attached_file :vk_photo_image,
    styles: { original: '604x403>' },
    convert_options: {
      original: "-background white -compose Copy -gravity center -extent 604x403"
    }
  validates_attachment :vk_photo_image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  # ! set ids !
  VK_GROUP_ID = nil # group id integer
  VK_ALBUM_ID = nil # albumn id integer

  #delegates
  delegate :url_helpers, to: 'Rails.application.routes'

  #methods

  def self.settings_attr_accessor(*args)
    args.each do |method_name|
      eval "
        def #{method_name}
          self.settings(:params).send(:#{method_name})
        end
        def #{method_name}=(value)
          self.settings(:params).send(:#{method_name}=, value)
        end
      "
    end
  end

  settings_attr_accessor :size, :zipper, :material, :lining, :compartments, :pockets

  def first_image
    self.images.first.image(:preview)
  end

  def trouble
    self.title.present? && self.description.present?
  end

  def set_vk
    @vk = VkontakteApi::Client.new(ENV['VK_ACCESS_TOKEN'])
  end

  def url
    url_helpers.product_url(self, host: 'http://astrastore.by')
  end

  private


    def generate_vk_photo_images
      self.vk_photo_image = File.open(images.first.image.path)
      self.vk_photo_image.save
    end

    def upload_vk_product
      set_vk

      server_upload_url = @vk.photos.getUploadServer(group_id: VK_GROUP_ID, album_id: VK_ALBUM_ID).upload_url #take server upload url
      image_file_path = vk_photo_image.path

      vk_response = VkontakteApi.upload(url: server_upload_url, photo: [image_file_path, 'image/jpeg'])

      vk_save_photos_response =
        @vk.photos.save(
          album_id: VK_ALBUM_ID,
          group_id: VK_GROUP_ID,
          server: vk_response.server,
          photos_list: vk_response.photos_list,
          caption: "#{category.title}: #{title} \n
                    Цена: #{cost} \n
                    Подробное описание и заказ на сайте: #{url}",
          hash: vk_response['hash']
        ).first

      #set vk fields values
      self.vk_owner_id = vk_save_photos_response.owner_id
      self.vk_photo_id = vk_save_photos_response.pid
      vk_photo_image.destroy
      self.save
    end

    def check_vk_association
      unless vk_photo_id && vk_owner_id
        generate_vk_photo_images
        upload_vk_product
      end
    end

    def vk_product_caption_update
      set_vk
      vk_photo_caption = "#{category.title}: #{title} \n
                          Цена: #{cost} \n
                          Подробное описание и заказ на сайте: #{url}"
      @vk.photos.edit(owner_id: vk_owner_id, photo_id: vk_photo_id, caption: vk_photo_caption)
    end

    def delete_vk_product
      set_vk
      true if (@vk.photos.delete(owner_id: vk_owner_id.to_i, photo_id: vk_photo_id) == 1) || !(vk_owner_id && vk_photo_id)
    end
end
