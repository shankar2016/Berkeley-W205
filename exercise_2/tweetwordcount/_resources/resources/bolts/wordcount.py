from __future__ import absolute_import, print_function, unicode_literals

from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
import sys


class WordCounter(Bolt):

	def initialize(self, conf, ctx):
		self.counts = Counter()
		self.conn = psycopg2.connect(database="tcount", user="postgres", password="postgres", host="127.0.0.1", port="5432")
		cur = self.conn.cursor()

		# DOES NOT WORK because Postgres version is 8.4.20. Need at least version 9.1 to make it work
		#cur.execute('''DROP TABLE IF EXISTS tweetwordcount''')
		#cur.execute('''CREATE TABLE IF NOT EXISTS Tweetwordcount (word TEXT PRIMARY KEY, count INT)''') 
	

	# Write to Postgres
	def pg_write(self, word, count):
		cur = self.conn.cursor()

		# extract the word and its count, if it exists already
		cur.execute("SELECT word FROM Tweetwordcount WHERE word = %s", (word,))

		if cur.fetchone() is None:
			# If word does not already exist, INSERT
			cur.execute("INSERT INTO Tweetwordcount (word,count) VALUES (%s, %s);", (word, self.counts[word]))
		else:
			# If word already exists, UPDATE
			cur.execute("UPDATE Tweetwordcount SET count = %s WHERE word = %s;", (self.counts[word],word)  )

		# ensure that database is updated
		self.conn.commit()


	# main process intelligence
	def process(self, tup):
		word = tup.values[0]

		self.counts[word] += 1
		self.emit([word, self.counts[word]])

		# Write to database
		self.pg_write(word, self.counts[word])

		# visible log
		self.log('%s: %d' % (word, self.counts[word]))
