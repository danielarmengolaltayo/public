# frozen_string_literal: true
class EmbeddedMedia < Jekyll::Generator
  def generate(site)

    all_notes = site.collections['notes'].docs
    all_pages = site.pages

    all_docs = all_notes + all_pages

    all_notes.each do |current_note|
      
      # about tabindex: https://stackoverflow.com/questions/5192859/how-to-ignore-html-element-from-tabindex
      current_note.content = current_note.content.gsub(
        /(<iframe(?= src="https:\/\/player\.vimeo\.com)|<iframe.+title="YouTube video player")/,
        "\\1 class='media-iframe' tabindex='-1'"
      )

      current_note.content = current_note.content.gsub(
        /(<iframe.+player\.vimeo\.com+.+<\/iframe>|<iframe.+title="YouTube video player".+<\/iframe>)/,
        "<div class='media-p'><div class='media'>\\1</div></div>"
      )

    end

  end

end
