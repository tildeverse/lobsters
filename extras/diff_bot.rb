# typed: false

class DiffBot
  # source https://tildegit.org/ben/tilde/src/branch/master/fulltext/fulltext.php
  API_URL = "https://tilde.team/~ben/fulltext/fulltext.php".freeze

  def self.get_story_text(story)
    if story.url.to_s.match(/\.pdf$/i)
      return nil
    end

    db_url = "#{API_URL}?url=#{CGI.escape(story.url)}"

    begin
      s = Sponge.new
      # we're not doing this interactively, so take a while
      s.timeout = 45
      res = s.fetch(db_url).body
      if res.present?
        return res
      end
    rescue => e
      Rails.logger.error "error fetching #{db_url} #{e.backtrace.first} #{e.message}"
    end

    begin
      s = Sponge.new
      s.timeout = 45
      s.fetch(story.archiveorg_url)
    rescue => e
      Rails.logger.error "error caching #{db_url}: #{e.backtrace.first} #{e.message}"
    end

    nil
  end
end
