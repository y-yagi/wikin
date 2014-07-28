json.set! :suggestions do
  json.array!(@pages) do |page|
    json.value page.full_title
    json.data page.id
  end
end
