;; Natarajan Shankar : Lab 6, W205, Fall 2016
(ns tweetcount
  (:use     [streamparse.specs])
  (:gen-class))

(defn tweetcount [options]
   [
    ;; spout configuration
    {"tweet-spout" (python-spout-spec
          options
          "spouts.tweets.TweetSpout"
          ["tweet"]
          )
    }
    ;; First layer of bolts, spawn 2 instances to process tweets
    {"tweet-bolt" (python-bolt-spec
          options
          {"tweet-spout" :shuffle}
          "bolts.tweetparser.TweetParser"
          ["words"]
          :p 2
          )
    ;; Second layer of bolts,  one instance to count
    "word-bolt" (python-bolt-spec
          options
          {"tweet-bolt" :shuffle}
          "bolts.wordcount.WordCounter"
          ["word" "count"]
          :p 1
          )
    }
  ]
)
