# frozen_string_literal: true

module ColorOutput
  BLACK                 = 30
  RED                   = 31
  BACKGROUND_BRIGHT_RED = '41;1'
  GREEN                 = 32
  BLUE                  = 34
  YELLOW                = 33
  MAGENTA               = 35
  CYAN                  = 36
  WHITE                 = 37

  COLORS       = [BLUE, YELLOW, GREEN, CYAN, MAGENTA, WHITE].freeze
  COLOR_PICKER = Enumerator.produce(COLORS.first) do |color|
    COLORS[(COLORS.index(color) + 1) % COLORS.length]
  end

  private

  def color(color = BLUE)
    printf "\033[#{color}m"
    yield
    printf "\033[0m"
  end
end
