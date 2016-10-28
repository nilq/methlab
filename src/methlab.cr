require "./methlab/*"
require "./theme"

require "markdown"
require "yaml"

require "kemal"

module Methlab

  def self.post_item(file)
    post    = {} of String => String
    content = ""

    (YAML.parse File.read("posts/posts.yml")).each do |_post|
      _post = _post.as_h

      if _post.has_key? "file"
        if (_post["file"].as(String)).ends_with?("#{file}.md")
          post = _post
          content = File.read(_post["file"].as(String))
        end
      end
    end

    theme_item
  end

  get "/" do
    theme_index
  end

  get "/style/:path" do |env|
    env.response.content_type = "text/css"
    File.read theme_style(env.params.query["path"])
  end

  get "/script/:path" do |env|
    env.response.content_type = "application/javascript"
    File.read theme_style(env.params.query["path"])
  end

  get "/:post" do |env|
    post_item(env.params.query["post"])
  end

  Kemal.run
end
