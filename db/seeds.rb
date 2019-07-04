# typed: strict
100.times { |i| Page.create!(title: "title#{i}", body: "body#{i}") }
