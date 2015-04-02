class Array
  def matrix(operation, other_array)
    self.zip(other_array).map { |el| el.inject(operation) }
  end
end
