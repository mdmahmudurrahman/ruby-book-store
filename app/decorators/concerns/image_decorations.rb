# frozen_string_literal: true
module ImageDecorations
  IMAGE_RESOLUTIONS = {
    xxs: [140, 140], xs: [150, 190],
    sm:  [290, 270], md: [350, 400]
  }.freeze

  def image(version, name, options)
    handler = "this.src='#{image_url version}'"
    options = { onerror: handler }.merge options
    image   = book.send(name).send version
    image_tag image, options
  end

  private

  def image_url(version)
    text = I18n.t 'image.not-available'
    resolution = IMAGE_RESOLUTIONS[version] * 'x'
    "http://dummyimage.com/#{resolution}/f/6e6e6e&text=#{text}"
  end
end
