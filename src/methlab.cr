require "./methlab/*"
require "./theme"

require "markdown"
require "yaml"

require "kemal"

module Methlab

  @@posts = YAML.parse File.read("posts/posts.yml")

  def post_item(file)
    post    = {} of String => String
    content = ""

    puts "Hello, " + @@posts.as_s

    @@posts.each do |_post|
      puts _post
      _post = _post.as_h

      if _post.has_key? "file"
        if _post["file"].ends_with?("#{file}.md")
          post = _post
          content = File.read(_post["file"])
        end
      end
    end

    theme_item(post, content)
  end

  get "/" do
    theme_index
  end

  Kemal.run
end
