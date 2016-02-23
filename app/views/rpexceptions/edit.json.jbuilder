json.array!(@countries) do |country|
  json.desc country.name_and_code
end
