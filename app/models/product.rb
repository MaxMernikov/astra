class Product < ActiveRecord::Base
  #delegates
  delegate :url_helpers, to: 'Rails.application.routes'

  # constans
  PARAMS = [:size, :zipper, :material, :lining, :compartments, :pockets]
  VK_GROUP_ID = 73282144 # group id integer
  VK_ALBUM_ID = 204862394 # albumn id integer

  belongs_to :category
  has_settings :params

  has_many :images

  has_many :galeries
  has_many :lookbook_items, through: :galeries
  has_many :orders


  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

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

  settings_attr_accessor :size, :zipper, :material, :lining, :compartments, :pockets, :name

  def first_image
    self.images.first.image(:preview)
  end

  def trouble
    self.title.present? && self.description.present?
  end

  def set_vk
    @vk = VkontakteApi::Client.new(Admin.first.vk_token)
  end

  def url
    url_helpers.product_url(self, host: 'http://astrastore.by')
  end

  # thank you ledermann-rails-settings
  def destroy
    settings(:params).destroy
    self.delete
  end

  def site_cost
    "#{cost}0 000 руб."
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
          caption: caption,
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
      @vk.photos.edit(owner_id: vk_owner_id, photo_id: vk_photo_id, caption: caption)
    end

    def delete_vk_product
      ap 'sdasdasd'
      set_vk
      true if (@vk.photos.delete(owner_id: vk_owner_id.to_i, photo_id: vk_photo_id) == 1) || !(vk_owner_id && vk_photo_id)
    end

    

    def caption
      "#{category.title}\n#{title}\n#{site_cost}\n\n#{url}?utm_source=Vkontakte&utm_medium=banner&utm_campaign=album"
    end
end
