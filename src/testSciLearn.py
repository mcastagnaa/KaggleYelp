

def main():
	from sklearn import datasets
	boston = datasets.load_boston()
	print(boston.data)
	return 0

if __name__ == '__main__':
	main()

