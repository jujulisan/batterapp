class Ad < ActiveRecord::Base

  before_save :md_to_html

  belongs_to :category
  belongs_to :member

  validates :title, :description_md, :description_short, :category, :picture, :finish_date, presence: true
  validates :price, numericality: { greater_than: 0 }

  scope :descending_order, ->(quantity = 6) { limit(quantity).order(created_at: :desc) }
  scope :to_the, ->(member) {where(member: member)}

  monetize :price_cents

  has_attached_file :picture, styles: { medium: "320x150#", thumb: "100x100>", large: "800X300#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  def md_to_html
    options = {
      filter_html: true,
      link_attributes: {
        rel: "nofollow",
        target: "_blank"
      }
    }

    extensions = {
      space_after_headers: true,
      autolink: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    self.description = markdown.render(self.description_md)
  end
end
