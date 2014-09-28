require 'github/markup'
require 'open-uri'

file = 'https://raw.github.com/voltrb/volt/master/Readme.md'
destination = 'app/main/views/docs/readme.html'
content = open(file).read

@doc = GitHub::Markup.render(file, content)
@doc = @doc.gsub('{','***************')
@doc = @doc.gsub('}','{38.chr + "#125;"}')
@doc = @doc.gsub('***************', '{"&#123;"}')

@doc = @doc.gsub!(/\<pre(?: lang="(.+?)")?\>(.+?)\<\/pre\>/m) do
  "<pre class='prettyprint lang-ruby'>#{$2}</pre>"
end

File.open(destination, 'w'){|file| file.write('<:Body>' + @doc)}