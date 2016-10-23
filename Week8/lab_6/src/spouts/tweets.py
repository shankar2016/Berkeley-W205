from __future__ import absolute_import, print_function, unicode_literals

import itertools
from streamparse.spout import Spout

class TweetSpout(Spout):

    def initialize(self, stormconf, context):
        self.tweets = [
                "She advised him to take a long holiday, so he immediately quit work and took a trip around the world",
                "He will be here in half an hour",
                "She saw him eating a sandwich",
                ]
        self.tweets = itertools.cycle(self.tweets)


    def next_tuple(self):
        tweet = next(self.tweets)
        self.emit([tweet])
