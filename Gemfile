# frozen_string_literal: true

source "https://rubygems.org"

gem "jekyll-theme-chirpy", "~> 7.6"

group :jekyll_plugins do
  # Old post URLs (e.g. /r/ubuntu/2018/10/29/setup-r-on-ubuntu.html) redirect to /posts/<slug>/
  gem "jekyll-redirect-from", "~> 0.16"
  # Repo descriptions, languages and stars for the Projects page
  gem "jekyll-github-metadata", "~> 2.16"
end

gem "html-proofer", "~> 5.0", group: :test

# Windows and JRuby do not include zoneinfo files
platforms :windows, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.2.0", :platforms => [:windows]
