# frozen_string_literal: true

module ArrayOperations
  private

  def group_and_count(list)
    list.uniq.map { |i| [i, list.count(i)] }.to_h
  end

  def most_common_elements(list)
    sort_hash(group_and_count(list), order: :desc)
  end

  def sort_hash(hsh, order: :asc)
    case order
    when :asc
      hsh.sort_by { |_k, v| v }.to_h
    when :desc
      hsh.sort_by { |_k, v| -v }.to_h
    end
  end

  def middle_value(array)
    array[(array.length / 2).floor]
  end
end
