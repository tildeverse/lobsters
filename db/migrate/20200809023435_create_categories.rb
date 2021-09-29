class CreateCategories < ActiveRecord::Migration[5.2]
  class Category < ActiveRecord::Base
    has_many :tags
  end
  class Tag < ActiveRecord::Base
    belongs_to :category
  end

  def change
    #raise "You need to edit this migration to define categories matching your site" unless Rails.application.name == 'Lobsters'

    create_table :categories do |t|
      t.string :category

      t.timestamps
    end
    add_reference :tags, :category

    # list your tags in console with: Tag.all.pluck(:tag).join(' ')

    {
      misc: ["test"],
      capitalism: ["business", "capitalism", "censorship", "cloud-computing", "blockchain", "cryptocurrency", "5G", "adblock", "artificial-intelligence", "data-analysis", "data-brokers", "data-exploration", "data-science", "data-visualization", "extreme-capitalism", "finding-cures", "government", "health-insurance", "information-abundance", "intelligent-cloud", "intelligent-edge", "IoT", "machine-learning", "microsoft", "oracle", "propaganda", "SaaS", "social-data", "social-media", "surveillance", "surveillance-capitalism", "twitch", "U.S.A", "USA", "youtube"],
      social: ["IRC", "matrix", "fediverse", "email"],
      software: ["projects", "command line", "algorithms", "automation", "FOSS", "GNU", "gnu+linux", "agile",  "programming", "open-source", "UNIX", "theory", "design", "kernel", "init", "software-development"],
      hardware: ["Hardware", "desktop-computing", "Raspberry-Pi"],
      os: ["BSD", "Linux", "macos", "windows", "distros"],
      languages: ["bash", "css", "javascript", "lisp", "rust", "python"],
      learn: ["ecology", "education", "EFF", "guide", "History", "Hackers", "hackerspace", "learning", "makerspace", "projects", "physics", "science", "space", "leadership"],
      tools: ["emacs", "git", "shell", "systemd", "terminal", "ssh", "vim", "dns", "scripting"],
      privacy: ["anonymity", "Privacy"],
      security: ["cryptography", "cybersecurity", "security"],
      tildes: ["yourtilde", "~team", "~town", "envs", "tildes", "tildeverse", "thunix", "system administration"],
      culture: ["coffee", "content_warning", "current-events", "Art", "astronomy", "broadcasting", "equality", "fun", "gaming", "general", "health", "meme", "repair", "tips-n-tricks", "today-i-learned", "trivia", "yikes", "random", "MUSH", "satire", "sports"],
      people: ["dennis-ritchie", "ken-thompson", "Luke Smith", "paul-ford", "richard-stallman"],
      smallinternet: ["decentralized-internet", "gopher", "gemini", "internet-freedom", "lowtech", "self-hosting", "slow", "small internet", "SpartanWeb", "non-commerical-internet", "protocols", "text", "KISS", "design"],
      web: ["digitalization", "internet", "modern-web", "mozilla", "Podcasts", "radio", "media", "multiplayer", "Reddit", "search engines", "Video", "web", "web-browsers", "web-development"],
    }.each do |category, tags|
      c = Category.create! category: category
      Tag.where(tag: tags).update_all(category_id: c.id)
    end

    # if this is throwing an exception ("Data truncated for column"), there
    # are one or more tags with a null category_id
    change_column :tags, :category_id, :bigint, null: false

    # cleanups
    rename_column :tags, :inactive, :active
    change_column :tags, :active, :boolean, default: true, null: false
    change_column :tags, :privileged, :boolean, default: false, null: false
    change_column :tags, :is_media, :boolean, default: false, null: false
    Tag.update_all("active = !active")
  end
end
