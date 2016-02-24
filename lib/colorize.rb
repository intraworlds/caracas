# 'String' extension supporting text colorization.
# (unix only)
# I know I can use existing gems (such as 'colorize'),
# but I don't like a spreading dependencies.
class String

  # Helper method.
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end
  def green
    colorize(32)
  end
  def brown
    colorize(33)
  end
  def blue
    colorize(34)
  end
  def magenta
    colorize(35)
  end
  def cyan
    colorize(36)
  end
  def gray
    colorize(37)
  end

end