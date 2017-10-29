import psycopg2
import numpy as np
import matplotlib.pyplot as plt

con = psycopg2.connect(database='NCCF', user='matteo')
cur = con.cursor()

SQLinstr = "SELECT * FROM dataset WHERE 'Item' <> 'BS1m';"

cur.execute(SQLinstr)

records = []
for singleRecord in cur:
	records.append(singleRecord)

cur.close()
con.close()

dataset = np.array(records)

x = dataset[:, 7]
y = dataset[:, 5]
z = dataset[:, 9]

col = dataset[:, 0]

colCode = []
for element in col:
	if element == 'OMGI':
		colCode.append(2)
	elif element == 'Comp':
		colCode.append(1)
	else:
		colCode.append(3)

fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.xlabel('return')
plt.ylabel('NCCF')
plt.title('NCCF 3m vs. 3y risk/return ' + dataset[9,3])

ax.scatter(x, y, s=z*1000, c = colCode, alpha = 0.6)

plt.show()
