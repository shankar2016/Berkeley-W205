# Natarajan Shankar : W205, Lab 6, Fall 2016
from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt

class WordCounter(Bolt):

    def initialize(self, conf, ctx):
        self.counts = Counter()

    def process(self, tup):
        # Get the word
        word = tup.values[0]

        # increment the local count
        self.counts[word] += 1

        # emit and count
        self.emit([word, self.counts[word]])
        self.log('%s: %d' % (word, self.counts[word]))
