module Conversion

  private

  def convert_to_int_array(input)
    input.split.map(&:to_i)
  end
end
