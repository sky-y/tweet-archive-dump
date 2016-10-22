#!/usr/bin/env ruby

require 'json'
require 'yaml'
require 'time'

module TweetJson
  def self.format_json_tweet(json)
    tweet = json

    tweet.reject! do |k|
      to_remove = ["source", "entities", "geo", "id_str", "in_reply_to_user_id_str", "in_reply_to_status_id_str"]
      to_remove.include?(k)
    end

    if tweet.has_key?("user")
      tweet["user"].reject! do |k|
        to_remove = ["protected", "id_str", "profile_image_url_https", "id", "verified"]
        to_remove.include?(k)
      end
      tweet["url"] = "https://twitter.com/%s/status/%s" % [tweet["user"]["screen_name"], tweet["id"].to_s]
    end

    if tweet.has_key?("retweeted_status")
      tweet["retweeted_status"].reject! do |k|
        to_remove = ["source", "entities", "geo", "id_str", "created_at"]
        to_remove.include?(k)
      end
      if tweet["retweeted_status"].has_key?("user")
        tweet["retweeted_status"]["user"].reject! do |k|
          to_remove = ["protected", "id_str", "profile_image_url_https", "id", "verified"]
          to_remove.include?(k)
        end
        tweet["retweeted_status"]["url"] = "https://twitter.com/%s/status/%s" % [tweet["retweeted_status"]["user"]["screen_name"], tweet["retweeted_status"]["id"].to_s]
      end
    end

    date = Time.parse(tweet["created_at"]).getlocal("+09:00")
    tweet["created_at"] = date

    YAML.dump(tweet)
  end
end
