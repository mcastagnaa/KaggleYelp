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
				'''
				currentRecord = "('" + record['city'] + "', " + str(record['review_count']) + ", " \
							+ str(record['open']) + ", '" + record['business_id'] + "', '"  \
							+ record['state'] + "', " + str(record['longitude']) + ", " + str(record['latitude']) + ", " \
							+ str(record['stars']) + ")" 
				'''
				currentRecord = "('" + record['business_id'] + "', "+ str(record['stars']) + ")" 
				print currentRecord
				#cur.execute("INSERT into tbl_train_business_amd (business_id, \
				#				longitude, latitude) VALUES" + currentRecord)
				#con.commit()
				#for cat in record['categories']:
				#	currentRecordC = "('" + record['business_id'] + "', '" + cat.replace("'", "") + "')"
				#	cur.execute("INSERT INTO tbl_train_business_cat (business_id, category) VALUES" + currentRecordC)
				#	con.commit()
				i += 1
				#print i
			
	except psycopg2.DatabaseError, e:
		print 'Error %s' % e    
		sys.exit(1)
    
	finally:
		if con:	
			con.close()

if __name__ == '__main__':
	main()

