# gem install github-markdown-preview

# require 'github/markup'
require 'nokogiri'

readme_in = '/Users/ryanstout/Sites/volt/volt/Readme.md'
readme_out = '/Users/ryanstout/Sites/volt/apps/home/app/main/views/docs/Readme.md'
readme_rendered = '/Users/ryanstout/Sites/volt/apps/home/app/main/views/docs/Readme.md.html'
readme_html = '/Users/ryanstout/Sites/volt/apps/home/app/main/views/docs/readme.html'

# html = GitHub::Markup.render('Readme.md', File.read(readme))
#
# puts html

`cp #{readme_in.inspect} #{readme_out.inspect}`

# puts "github-markdown-preview #{readme_out.inspect}"






require 'github-markdown-preview'

# create a preview, which writes the source_file.md.html file to disk
preview = GithubMarkdownPreview::HtmlPreview.new(readme_out)







# `github-markdown-preview #{readme_out.inspect} #{readme_html.inspect}`

doc = File.read(readme_rendered)
html = Nokogiri::HTML(doc)

style = html.css('head style')[0].inner_html

style = "<style type=\"text/css\">\n#{style}\n</style>\n"

body = html.css('body').inner_html
body = "<div class=\"markdown-body\" style=\"padding:10px 40px;\">\n#{body}\n</div>"


body = body.gsub('{','***************')
body = body.gsub('}','{38.chr + "#125;"}')
body = body.gsub('***************', '{"&#123;"}')

# body = body.gsub!(/\<pre(?: lang="(.+?)")?\>(.+?)\<\/pre\>/m) do
#   "<pre class='prettyprint lang-ruby'>#{$2}</pre>"
# end

File.open(readme_html, 'w'){|file| file.write('<:Body>' + style + body)}