# tweet-archive-dump

A Ruby script for Dump JSON files in [Twitter Archive](https://support.twitter.com/articles/20170160) as simplified YAML files.

## Requirement 

- Ruby 2.3.1 or up
    - rbenv is recommended.
    - This script doesn't use Bundler.

## How to Use

1. Download your Twitter Archive from the page below:
    - [Downloading your Twitter archive | Twitter Help Center](https://support.twitter.com/articles/20170160)
    - First, request it. 
    - After a couple of days, you will receive an e-mail with your archive link. Then download it.
2. Unzip it.
    - For example, let the unzipped directory be `~/twitter-archive/data/js/tweets/`.
3. Edit `config.yml`.
    - `tweet_archive_path`: The unzipped directory such as `~/twitter-archive/data/js/tweets/`
    - `dest_path`: Destination directory of generated YAML files.
4. Run this script with Ruby:
    - `ruby tweet_archive_dump.rb`
    - or `rbenv exec ruby tweet_archive_dump.rb` (with rbenv)

