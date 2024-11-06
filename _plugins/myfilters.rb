# via https://stackoverflow.com/questions/14978474/how-to-show-the-modification-date-of-a-file-in-jekyll
# relacionat amb jekyll-last-modified-at
# to-do, netejar codi que no faig servir!

module Jekyll
  module MyFilters
    def file_mod_date(input)
      # File.mtime(input)
      
    end
  end
end

Liquid::Template.register_filter(Jekyll::MyFilters)