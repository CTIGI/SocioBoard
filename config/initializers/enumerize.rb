class PaperTrailEnumerizeParser
  def self.load(source)
    root = Psych.parse(source).root
    traverse root
    root.to_ruby
  end

  private

  def self.traverse(none)
    (none.children || []).each_with_index do |c, c_idx|
      if c.tag == '!ruby/string:Enumerize::Value'
        value_idx = c.children.index { |n| n.is_a?(Psych::Nodes::Scalar) && n.value == 'value' }
        none.children[c_idx] = Psych::Nodes::Scalar.new(c.children[value_idx+1].value)
      else
        traverse c
      end
    end
  end
end
