json.set! :pages do
  json.array!(@pages) do |page|
    json.extract! page, :id, :title
    json.url page.to_url
    json.body page.body
    json.extracted_body @markdown.render(page.body)
  end
end
json.set! :results_returned, @pages.count
