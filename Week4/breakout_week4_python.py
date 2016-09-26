#!/usr/bin/python
################################
# Mocking Lambda Architectures 
# MIDS - W205 - Week 4 Breakout
# Uri Schonfeld - Fall 2016
################################
import sys

hourly_stats = ???
current_hour_so_far_stats = ???

# realtime_processing
def realtime_processing(line):
  # Parse (deserialize) the json string to a python object.
  obj = … line
  # Update Statistics for current hour so far. (maybe a good idea to define a few functions and 
   # call them

# append_current_hour 
#
# Append current 
def append_current_hour(line):
  # Append this line to a file that contains this hour’s data.

  # If this line started a new hour
    # start a new file and append line to it.
    # Return the previous hour's path
  # Otherwise
    # append to current file
    # return None.


# mapper
# Accepts a filename, and returns a gigantic list of strings of the form "key\twhatever-you-want-here" .
# Note that this is a mockup, and normally a mapper could not return this type of list, it would be too 
# big to fit in memory.
# finished_hour - a file name with the data stored by append_current_hour.
# 
def mapper(finished_hour):
  pass

# reducer
# mapout_sorted_by_key - a list of strings of the form "key\twhatever-you-want-here" where
#                        the list is sorted by the key column.
def reducer(mapout_sorted_by_key):
  current_key = None
  values = []
  for line in mapout_sorted_by_key:
    key, value = line.split('\t')
    # if our key changed
    if key != current_key:
      # and not because it's our first key,value ever.
      if current_key is not None:
        # Reduce the key,[value0, value1, ..., valueN] we collected.
        # Meaning, calculate whatever it is your grouped by key.
      # And indicate our current key
      current_key = key
      values = []
    # Collect new value
    values.append(value)


# map_reduce_last_hour
#
# If you are confused by the map-reduce, take a look here: 
#   https://zettadatanet.wordpress.com/2015/04/04/a-hands-on-introduction-to-mapreduce-in-python/
#
# finished_hour - a file name with the data stored by append_current_hour.
def map_reduce_last_hour(finished_hour):
  # Perform MapReduce
  mapout = mapper(finished_hour)
  out = reducer(sorted(mapout, key=lambda entry: entry.split('\t')[0]))
  #And add this hours stats to hourly_stats

#  reply_to_query
# QueryID may be one of: 
#    “CLICKS_PER_URL”: Clicks per URL per day.
#    “CLICKS_PER_DOMAIN”: Clicks per domain per day.
# Be sure to support the day in progress.
def reply_to_query(query_id, day, URL=None, domain=None):
  # check which query is asked.
  #Get needed data from batch store.
  # Add the realtime data
  # and return the desired data.

# Main function. Mocks Lambda Architecture one thing at a time.
def main():
  # See how there maps to the image in the exercise ***below***.

  # ***Data***
  for line in sys.stdin:

    # ***Historic Data Store***
    # Append to current day
    finished_hour = append_current_hour(line)

    if finished_hour is not None:
      # ***Batch***
      # hour changed? Kick off this hour’s batch (In real life, launch an actual map reduce).
      map_reduce_last_hour(finished_hour)

    # And clear our realtime counts (now captured in our batch)
    clear_realtime_counts()

    # ***speed***
    # Realtime Processing
    realtime_processing(line)

    # ***query***
    # Answer some queries
    reply_to_query()

# Call main if invoked as a program.
if “__main__” == __name__:
  main()
