#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'pathname'
require './tweet_json'

config = YAML.load_file("config.yml")
json_pathname = Pathname(config["tweet_archive_path"]).expand_path
tweet_files = Pathname.glob(json_pathname.realpath.to_s + '/*.js')
dest_path = Pathname(config["dest_path"]).expand_path
dest_path.mkpath

tweet_files.each do |p|
  basename = p.basename('.*').to_s
  year_month = basename.split('_')
  year = year_month[0]
  month = year_month[1]
  puts "Twitter Archive: #{year}年#{month}月"
  print "Publishing..."

  open(p.to_s) do |f|
    l = f.read.lines
    l.shift  # drop the 1st line
    json = l.join
    archive = JSON.load(json)

    body_lines = []
    archive.each do |tweet_org|
      tweet_pretty = TweetJson::format_json_tweet(tweet_org)
      body_lines.push(tweet_pretty)
    end

    body = body_lines.join("\n")
    dest_yaml = dest_path + Pathname(basename + '.yml')
    puts dest_yaml
    open(dest_yaml, "w") do |t|
      t.write body
    end
  end
  puts "done."
end
