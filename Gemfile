source "https://rubygems.org"
ruby RUBY_VERSION

# Hello! This is where you manage which Jekyll version is used to run.
# The github-pages gem pins Jekyll, the theme and all plugins to the exact
# versions GitHub Pages uses. To upgrade, run `bundle update github-pages`.
# Run Jekyll with `bundle exec`, like so:
#
#     bundle exec jekyll serve
#
gem "github-pages", group: :jekyll_plugins

# This is the default theme for new Jekyll sites. You may change this to anything you like.
gem "minima", "~> 2.0"

# No longer bundled with Ruby >=3.0
gem "webrick"

# Plugin to generate an Atom (RSS-like) feed of your Jekyll posts
group :jekyll_plugins do
   gem "jekyll-feed", "~> 0.6"
end

# Windows and JRuby does not include zoneinfo files
platforms :windows, :jruby do
   gem "tzinfo", ">= 1", "< 3"
   gem "tzinfo-data"
end
