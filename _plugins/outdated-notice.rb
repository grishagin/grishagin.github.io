# Shows a warning at the top of posts marked as outdated in their front matter:
#
#   outdated: true                       # generic notice
#   outdated: "Use `wsl --manage` now."  # generic notice plus this note (Markdown OK)

Jekyll::Hooks.register :posts, :pre_render do |post|
  note = post.data["outdated"]
  next unless note

  text = "This post is from #{post.date.year} and may be out of date."
  text += " #{note}" if note.is_a?(String)
  post.content = "> #{text}\n{: .prompt-warning }\n\n#{post.content}"
end
