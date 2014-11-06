module ApplicationHelper
  def active_menu controller
    'uk-active' if params[:controller] == controller
  end

  def mark(text)
    if text
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(render_options = {hard_wrap: true}) )
      raw "<div class='markdown'>" + @markdown.render(text) + '</div>'
    end
  end

  def block_former(blocks)
    row_blocks = []

    inverse = blocks.size%5 == 2

    blocks.each_slice(5).each do |b|
      if inverse
        row_blocks << b.take(2)
        row_blocks << b.drop(2) if b.size > 2
      else
        row_blocks << b.take(3)
        row_blocks << b.drop(3) if b.size > 3
      end
    end

    result = ''
    row_blocks.each{ |i| result += render("partials/block_row", blocks: i) }
    raw result
  end

  def block_row_class(size, index)
    if index != 0
      'col-xs-12 col-sm-4'
    else
      case size
      when 1
        'col-xs-12 col-sm-4 col-sm-offset-4'
      when 2
        'col-xs-12 col-sm-4 col-sm-offset-2'
      when 3
        'col-xs-12 col-sm-4'
      end
    end
  end

  def absolute_attachment_url(attachment_name, attachment_style = :original)
    "#{request.protocol}#{request.host_with_port}#{attachment_name.url(attachment_style)}"
  end

  def astra_tag(text)
    text + ' | Astra'
  end

  def lookbook_background_position(positions)
    position = positions.split(', ')
    "#{ position.try(:[], 0).present? ? position[0] : 0 }% #{ position.try(:[], 1).present? ? position[1] : 0 }%"
  end

  def lookbook_background_size(item)
    return item.image(:original) if (item.position[:size_x].to_i > 1 || item.position[:size_y].to_i > 1)
    item.image(:preview)
  end
end
