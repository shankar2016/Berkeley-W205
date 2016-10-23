# Natarajan Shankar : W205, Lab 6, Fall 2016
from __future__ import absolute_import, print_function, unicode_literals
import re

from collections import Counter
from streamparse.bolt import Bolt

def ascii_string(s):
        return all(ord(c) < 128 for c in s)

class TweetParser(Bolt):

    def initialize(self, conf, ctx):
        self.tweets = Counter()

    def process(self, tup):
                tweet = tup.values[0] # extract the tweet

                # split the tweet into words
                words = tweet.split()

                # Initialize a list for holding valid words
                valid_words = []

                # Cycle through all tweets and process them
                for word in words:
                        # ignore the has tag words
                        if word.startswith("#"): continue

                        # filter the user mentions
                        if word.startswith("@"): continue

                        # Filter out retweet tags
                        if word.startswith("RT"): continue

                        # Filter out URLs
                        if word.startswith("http"): continue

                        # Filter out leading and lagging punctuations
                        aword = word.strip("\"?><,'.:;)")

                        # now check whether the word contains only ASCII
                        # Store the valid words
                        if len(aword) > 0 and ascii_string(word):
                                valid_words.append([aword])

                if not valid_words: return

                # emit all words
                self.emit_many(valid_words)
