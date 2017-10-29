#import sys
import numpy as np
#import scipy as sp
import math
from sklearn import linear_model

dataset = np.load('F:/AugTestV3_NaN.npy')
y = dataset[:, 0]
x = dataset[:, 1:]

print(y[0:10])
print(x[0:10, :])
regr = linear_model.LinearRegression()
regr.fit(x,y)
#LinearRegression(copy_X=True, fit_intercept=True, normalize=False)
print(regr.coef_)

print(math.sqrt(np.mean((regr.predict(x)-y)**2)))

# Explained variance score: 1 is perfect prediction
# and 0 means that there is no linear relationship
# between X and Y.
print(regr.score(x, y)) 

# ---------------------
regr = linear_model.Ridge(alpha=.1)
alphas = np.logspace(-4, -1, 6)
print([regr.set_params(alpha=alpha).fit(x, y).score(x, y) for alpha in alphas])

# ---------------------
regr = linear_model.Lasso()
scores = [regr.set_params(alpha=alpha).fit(x, y).score(x, y) for alpha in alphas]
best_alpha = alphas[scores.index(max(scores))]
regr.alpha = best_alpha
regr.fit(x, y)

print(regr.coef_)
print(math.sqrt(np.mean((regr.predict(x)-y)**2)))
print(regr.score(x, y))
