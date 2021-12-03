# frozen_string_literal: true
class BidirectionalLinksGenerator < Jekyll::Generator
  def generate(site)

    all_public_notes = site.collections['notes'].docs
    if site.collections['private'] then
      all_private_notes = site.collections['private'].docs
      all_notes = all_public_notes + all_private_notes
    else 
      all_notes = all_public_notes
    end
    all_pages = site.pages

    all_docs = all_notes + all_pages

    link_extension = !!site.config["use_html_extension"] ? '.html' : ''

    # Convert all Wiki/Roam-style double-bracket link syntax to plain HTML
    # anchor tag elements (<a>) with "internal-link" CSS class
    all_notes.each do |current_note|
      all_notes.each do |note_potentially_linked_to|

        # https://apidock.com/ruby/File/extname/class#824-File-name-without-the-extension
        note_filename = File.basename(
          note_potentially_linked_to.basename,
          File.extname(note_potentially_linked_to.basename)
        )

        link_code = "<a class='internal-link #{current_note.collection.label}' id='#{current_note.url}#{note_potentially_linked_to.url}' href='#{site.baseurl}#{note_potentially_linked_to.url}#{link_extension}'>\\1</a>"

        # Replace markdown links using note filename
        # [label for a note about cats](cats)
        current_note.content = current_note.content.gsub(
          /\[([^\]]+?)(?=\])\]\((#{note_filename})\)/i, link_code
        )

        # Replace double-bracketed links using note filename
        # [[cats]]
        current_note.content = current_note.content.gsub(
          /\[\[(#{note_filename})\]\]/i, link_code
        )

        # # Replace double-bracketed links with label using note filename
        # # [[cats|label for a note about cats]]
        # current_note.content = current_note.content.gsub(
        #   /\[\[#{note_filename}\|(.+?)(?=\])\]\]/i, link_code
        # )

      end

      # At this point, all remaining double-bracket-wrapped words are
      # pointing to non-existing pages, so let's turn them into disabled
      # links by greying them out and changing the cursor
      current_note.content = current_note.content.gsub(
        /\[\[(.*)\]\]/i, # match on the remaining double-bracket links
        <<~HTML.chomp    # replace with this HTML (\\1 is what was inside the brackets)
          <span title='There is no note that matches this link.' class='invalid-link'>
            <span class='invalid-link-brackets'>[[</span>
            \\1
            <span class='invalid-link-brackets'>]]</span></span>
        HTML
      )
    end

    # # Identify note backlinks and add them to each note
    # all_notes.each do |current_note|
    #   notes_linking_to_current_note = all_notes.filter do |e|
    #     # avoid backlinks to the same note (e.url != current_note.url)
    #     e.content.include?(current_note.url) && e.url != current_note.url 
    #   end
    #   current_note.data['backlinks'] = notes_linking_to_current_note
    # end

    # # Identify connected notes (bidirectional connections) and add them to each note
    # all_notes.each do |current_note|
    #   connected_notes = all_notes.filter do |e|
    #     # avoid backlinks to the same note (e.url != current_note.url)
    #     (current_note.content.include?(e.url) || e.content.include?(current_note.url)) && e.url != current_note.url 
    #   end
    #   current_note.data['links'] = connected_notes
    # end

    all_notes.each do |current_note|
      # identify linked notes (unidirectional: from, to | bidirectional: both) 
      linked_notes = all_notes.filter do |e|
        # avoid backlinks to the same note (e.url != current_note.url)
        (current_note.content.include?(e.url) || e.content.include?(current_note.url)) && e.url != current_note.url 
      end
      # and add them to the data associated to each note
      current_note.data['links'] = linked_notes
      # identify note backlinks (only unidirectional links)
      notes_linking_to_current_note = current_note.data['links'].filter do |e|
        e.content.include?(current_note.url) && !current_note.content.include?(e.url)
      end
      # and add them to the data associated to each note
      current_note.data['backlinks'] = notes_linking_to_current_note
      # no confondre el concepte de backlinks aqui, ja que no contempla aquelles notes que estan conectades cap a les dues direccions
    end

  end

end
