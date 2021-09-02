# frozen_string_literal: true
class Test < Jekyll::Generator
    def generate(site)
  
      all_notes = site.collections['notes'].docs
      all_pages = site.pages
  
      all_docs = all_notes + all_pages
  
      all_notes.each do |current_note|
        
        current_note.content = current_note.content.gsub(
          /test/,
          "hello world"
        )
  
      end
  
    end
  
  end
  