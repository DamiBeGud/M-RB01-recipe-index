class Input
  def self.text(value,max=80)
    raise Problem.new(400,'invalid_text') unless value.is_a?(String)&&!value.strip.empty?&&value.length<=max
    value.strip
  end
  def self.id(value)
    result=text(value,64)
    raise Problem.new(400,'invalid_identifier') unless result.match?(/\A[A-Za-z0-9-]+\z/)
    result
  end
  def self.amount(value,max=1_000_000)
    raise Problem.new(400,'invalid_amount') unless value.is_a?(Integer)&&value.between?(1,max)
    value
  end
end

class Input
  def self.ingredients(ids)
    unless ids.is_a?(Array)&&ids.length.between?(1,10)&&ids.uniq.length==ids.length&&ids.all?{|id|id.is_a?(Integer)&&id>0}
      raise Problem.new(400,'invalid_ingredients')
    end
    ids
  end
end
