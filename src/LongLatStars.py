import sys
import psycopg2
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm

con = psycopg2.connect(database='KYelp', user='matteo')
cur = con.cursor()

SQLinstr = "SELECT longitude::float, latitude::float, stars FROM tbl_train_business WHERE stars = 1;"

cur.execute(SQLinstr)

records = []
for singleRecord in cur:
	records.append(singleRecord)

cur.close()
con.close()

dataset = np.array(records)

x = dataset[:, 0]
y = dataset[:, 1]
z = dataset[:, 2]

fig = plt.figure()
ax = fig.add_subplot(1,1,1)
plt.xlabel('longitude')
plt.ylabel('latitude')
plt.title('Stars by longitude/latitude')

ax.scatter(x, y, c=z, alpha= 0.1)

#cbar = plt.colorbar(z)
#cbar.set_label('stars')

plt.show()







