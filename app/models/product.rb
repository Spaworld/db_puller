class Product < RemoteDB

  self.table_name   = ENV['PRODUCTS_TABLE_NAME']
  self.primary_key  = ENV['PRODUCTS_PRIMARY_KEY']

  alias_attribute :sku,     ENV['PRODUCTS_SKU']
  alias_attribute :qb_sku,  ENV['PRODUCTS_QB_SKU']
  alias_attribute :kit_id,  ENV['PRODUCTS_KIT_ID']

  has_many :order_details, foreign_key: ENV['ORDER_DETAIL_PRODUCT_ID']
  has_many :orders,        through: :order_details
  has_many :channels,      through: :orders

  CHANNEL_NAMES = Channel.all.map(&:nickname)
  CHANNEL_NAMES.each do |channel_name|
    define_method("#{channel_name}_sku") do
      klass_name = ENV['TRANSLATOR_CLASS_PREFIX'] + channel_name.capitalize
      klass = Object.const_set(klass_name, Class.new(RemoteDB){
        self.table_name = ENV['TRANSLATOR_TABLE_PREFIX'] + channel_name
        alias_attribute :vendor_sku, ENV['TRANSLATOR_VENDOR_SKU']
        alias_attribute :native_sku, ENV['TRANSLATOR_LEGACY_SKU']
        def self.get_vendor_sku(sku)
          return unless find_by(native_sku: sku)
          find_by(native_sku: sku).vendor_sku
        end
      }) # oh, god...
      klass.get_vendor_sku(sku)
    end
  end

  def vendor_sku(channel_nickname)
    send("#{channel_nickname}_sku")
  end

end
