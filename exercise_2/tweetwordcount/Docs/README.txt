NOTE:
1. Scripts are in Scripts directory : Go to Scripts directory to run test scripts
2. Documents are in Docs directory : Architecture and other dics are here
3. Plot.png is in Plot directory : Bar chart is here
4. Screenshots are in screenshots directory: S

To run tweetwordcount application run the following steps
========================================================

STEP 1: Log into AWS and go to appropriate home directory
=========================================================

Run the two commands below

mkdir EX2
cd EX2

STEP 2: Clone the directory from git
====================================
ut and paste and run these commands:

git init
git remote add origin https://github.com/shankar2016/Berkeley-W205.git
git config core.sparseCheckout true
echo "exercise_2/" >> .git/info/sparse-checkout
echo "exercise_2/tweetwordcount/" >> .git/info/sparse-checkout
echo "exercise_2/tweetwordcount/*" >> .git/info/sparse-checkout
git pull origin master


STEP 3: cd to the application directory
=======================================

cd exercise_2
cd tweetwordcount


STEP 4: Run the application
===========================

[tweetwordcount]# sparse run

***** Hit <cr> when prompted whether to run this application as root *****


*************************************************************************

NOTES: 
Expected output should be something like this, a continuous stream
==================================================================
17790 [Thread-19-tweet-spout] INFO  backtype.storm.spout.ShellSpout - ShellLog pid:31343, name:tweet-spout Empty queue exception 
17890 [Thread-19-tweet-spout] INFO  parse-tweet-bolt - /usr/lib/python2.7/site-packages/requests-2.10.0-py2.7.egg/requests/packages/urllib3/util/ssl_.py:318: SNIMissingWarning: An HTTPS request has been made, but the SNI (Subject Name Indication) extension to TLS is not available on this platform. This may cause the server to present an incorrect TLS certificate, which can cause validation failures. You can upgrade to a newer version of Python to solve this. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#snimissingwarning.
  SNIMissingWarning
  /usr/lib/python2.7/site-packages/requests-2.10.0-py2.7.egg/requests/packages/urllib3/util/ssl_.py:122: InsecurePlatformWarning: A true SSLContext object is not available. This prevents urllib3 from configuring SSL appropriately and may cause certain SSL connections to fail. You can upgrade to a newer version of Python to solve this. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning.
    InsecurePlatformWarning

	17979 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt Ahhh: 1
	17994 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt I: 1
	17997 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt love: 1
	18008 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt Zara: 1
	18010 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt Larsson's: 1
	18012 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt voice: 1
	18014 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt is: 1
	18025 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt so: 1
	18028 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt different: 1
	18030 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt and: 1
	18040 [Thread-27] INFO  backtype.storm.task.ShellBolt - ShellLog pid:31339, name:count-bolt fluffy: 1
	





