class Page::Search
  def initialize(query)
    @query = query
  end

  def matches
    parts = []
    bindings = []

    split_query.each do |word|
      escapted_word = escape_for_like_query(word)
      parts << 'title LIKE ? OR body LIKE ?'
      bindings << escapted_word
      bindings << escapted_word
    end
    Page.where(parts.join(' OR '), *bindings)
  end

  private
    def split_query
      @query.split(/\s+/)
    end

    def escape_for_like_query(phrase)
      "%#{phrase}%"
    end
end
