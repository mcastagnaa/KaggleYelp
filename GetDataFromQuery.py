import sys
import psycopg2
import numpy
#import psycopg2.extensions
#psycopg2.extensions.register_type(psycopg2.extensions.UNICODE)
#psycopg2.extensions.register_type(psycopg2.extensions.UNICODEARRAY)

con = psycopg2.connect(database='KYelp', user='matteo')
cur = con.cursor()

SQLfile = "../KaggleYelp/sqlCode/extractDataForGlobalReg.sql"
SQLinstr = ""
i = 0
with open(SQLfile) as f:
	for line in f:
		if len(line) > 0:
			SQLinstr += line
			
#print SQLinstr
cur.execute(SQLinstr)
records = []
for singleRecord in cur:
	if i < 10000000000:
		records.append(singleRecord)
		i +=1
		print i
	else:
		break

cur.close()
con.close()

dataset = numpy.array( records )
numpy.save("../KaggleYelp/100recs",dataset)

