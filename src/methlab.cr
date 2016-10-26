require "./methlab/*"

require "markdown"
require "yaml"
require "kemal"

require "kamber-theme-default" # temporary

$BLOG_TITLE = "Nilq's lab"
$BLOG_DESCR = "stuff and things"

$posts = YAML.parse File.read("./posts/posts.yml")

def post_stuff(file)
  post = {} of String => String
  content = ""

  $posts.each do |_p|
    _p = _p.as_h as Hash

    if _p.has_key? "file"
      if (_p["file"] as String).ends_with?("#{file}.md" as String)
        post = _p

        content = File.read(_p["file"] as String)
      end
    end
  end

  theme_item(post, content)
end

module Methlab
  get "/" do
    theme_index
  end

  get "/style/:path" do |e|
    e.response.content_type = "text/css"

    File.read theme_style(e.params.query["path"])
  end

  get "/script/:path" do |e|
    e.response.content_type = "application/javascript"

    File.read theme_script(e.params.query["path"])
  end

  get "/:post" do |e|
    post_stuff(e.params.query["post"])
  end

  get "/:category/:post" do |e|
    category = e.params.query["category"] as String

    post = e.params.query["post"] as String
    post_stuff(category + "/" + post)
  end

  get "/:category/:sub_category/:post" do |e|
    category = e.params.query["category"] as String
    sub_category = e.params.query["sub_category"] as String

    post_name = e.params.query["post"] as String
    post_stuff(category + "/" + sub_category + "/" + post_name)
  end

  Kemal.run
end
