import sys
import psycopg2

# Connect to database and set up cursor
conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")
cur = conn.cursor()

# Initialize the lower and upper bounds just to be safe
low = 0
high = 0 

# If user has specified a lower bound, use it
if len(sys.argv) > 1:
	low = int(sys.argv[1])

# If user has specified a upper bound, use it
if len(sys.argv) > 2:
	high = int(sys.argv[2])

# Check for numbers less than zero
if low < 0 or high < 0:
	sys.exit(1);

# In case only one number is entered or high is less than low, adjust
if high < low:
	low, high = high, low

# Get data from the database
cur.execute("SELECT word, count FROM tweetwordcount WHERE count >= %s AND count <= %s ORDER BY count DESC" % (low, high))

# gather up all the result records
results = cur.fetchall()

# Sort the results
results = sorted(results)


# Print out, one per line
for entries in results:
	print(entries)

cur.close()
conn.close()
