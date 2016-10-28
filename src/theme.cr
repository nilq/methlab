def theme_style(path)
  "static/css/#{path}"
end

def theme_script(path)
  "static/js/#{path}"
end

def theme_item
  "views/post.ecr"
end

def theme_index
  render "views/index.ecr"
end
