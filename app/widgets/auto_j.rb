module AutoJ
  def auto_j
    h = {}
    instance_variables.each do |e|
      o = instance_variable_get e.to_sym
      h[e[1..-1]] = (o.respond_to? :auto_j) ? o.auto_j : o;
    end
    h
  end
  def to_json *a
    auto_j.to_json *a
  end

  def to_json
    self.to_json
  end
end
