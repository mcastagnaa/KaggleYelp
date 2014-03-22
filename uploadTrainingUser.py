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
				
				currentRecord = "('" + record['user_id'] + "', '" + record['name'].replace("'", "") + "', " \
						+ str(record['average_stars']) + ", " + str(record['review_count']) + ")"
				currentRecordV = "(" + str(record['votes'].get('funny')) + ", " \
						+ str(record['votes'].get('useful')) + ", " \
						+ str(record['votes'].get('cool')) + ", '" \
						+ record['user_id'] \
						+ "')"
				#print currentRecord
				#print currentRecordV
				cur.execute("INSERT into tbl_train_user (user_id, name, average_stars, review_count) VALUES" + currentRecord)
				con.commit()
				cur.execute("INSERT into tbl_train_user_votes (funny, useful, cool, user_id) VALUES" + currentRecordV)
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

