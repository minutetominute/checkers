class Array
  def zip_sum(other_array)
    self.zip(other_array).map { |el| el.inject(:+) }
  end
end
