import json
import sys
import psycopg2
import datetime

def main():
	con = None
	try:
		con = psycopg2.connect(database='KYelp', user='matteo')
		cur = con.cursor()
		with open(sys.argv[1]) as f:
			i = 0
			for line in f:
				record = json.loads(line)
				currentRecord = "('" + 	record['business_id'] + "', '" + record['user_id'] + "')"
				cur.execute("INSERT into tbl_test_review (business_id, user_id) VALUES" + currentRecord)
				con.commit()
				i += 1
				print i
			
	except psycopg2.DatabaseError, e:
		print 'Error %s' % e    
		sys.exit(1)
    
	finally:
		if con:	
			con.close()

if __name__ == '__main__':
	main()
