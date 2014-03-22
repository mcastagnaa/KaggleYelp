import json
import sys
import psycopg2
import datetime

def main():
	con = None
	#allRecords = ""
	try:
		con = psycopg2.connect(database='KYelp', user='matteo')
		cur = con.cursor()
		with open(sys.argv[1]) as f:
			i = 0
			for line in f:
				record = json.loads(line)
				#revDate = date.date.strpdate(record['date'], '%Y-%m-%d')
				currentRecord = "('" + record['date'] + "', " + str(record['stars']) + ", '" + \
						record['business_id'] + "', '" + record['user_id'] + "', '" + \
						record['review_id'] + "')"
				currentRecordV = "(" + str(record['votes'].get('funny')) + ", " \
						+ str(record['votes'].get('useful')) + ", " \
						+ str(record['votes'].get('cool')) + ", '" \
						+ record['review_id'] \
						+ "')"
				cur.execute("INSERT into tbl_train_review (date, stars, business_id, user_id, review_id) VALUES" + currentRecord)
				con.commit()
				cur.execute("INSERT into tbl_train_review_votes (funny, useful, cool, review_id) VALUES" + currentRecordV)
				con.commit()
				i += 1
				print i
						
		allRecords = "(" + allRecords[1:] + ")"
						
			
	except psycopg2.DatabaseError, e:
		print 'Error %s' % e    
		sys.exit(1)
    
	finally:
		if con:	
			con.close()

if __name__ == '__main__':
	main()

