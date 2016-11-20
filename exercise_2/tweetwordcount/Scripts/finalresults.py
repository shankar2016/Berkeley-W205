import sys
import psycopg2

# Connect to the local database
conn = psycopg2.connect(database="tcount", user="postgres", password = "postgres", host="127.0.0.1", port="5432")

# establish the cursor
cur = conn.cursor()

# If no string parameter specified
if len(sys.argv) == 1:
	cur.execute("SELECT word, count FROM tweetwordcount ORDER BY word ASC")
	result = cur.fetchall()
	print(result)
else: 
	# a word has been specified
	word = str(sys.argv[1])
	cur.execute("SELECT word, count FROM tweetwordcount WHERE word = '%s';" % word)
	result = cur.fetchone()
	if result is not None:
		print("Total number of occurrences of \'{}\' : {}".format(word, result[1]))
	else:
		print("No occurrences of \'{}\'".format(word))

# Clean up
cur.close()
conn.close()
