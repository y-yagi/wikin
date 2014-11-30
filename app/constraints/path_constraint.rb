class PathConstraint
  def matches?(request)
    path = request.path.split('/').reject(&:empty?).first
    !Page::INVALID_TITLE_PATTERN.include?(path)
  end
end
