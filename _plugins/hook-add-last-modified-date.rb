# # via https://stackoverflow.com/questions/36758072/how-to-insert-the-last-updated-time-stamp-in-jekyll-page-at-build-time/36769049#36769049
# # also related https://stackoverflow.com/questions/14978474/how-to-show-the-modification-date-of-a-file-in-jekyll
# Jekyll::Hooks.register :notes, :pre_render do |note|
#   # inject last modified time in post's datas.
#   note.data['last-modified-date'] = File.mtime( note.path )
# end