import json
import sys



def main():
	with open(sys.argv[1]) as f:
		dataset = {}
		for line in f:
			record = json.loads(line)
			for key in record:
				if key in dataset:
					if isinstance(record[key], (int, long, float, complex)):
						dataset[key] = max(record[key], dataset[key])
					elif isinstance(record[key], (dict)):
						dataset[key] = dataset[key]
					elif isinstance(record[key], (list)):
						dataset[key] = 'list_' + str(max(len(record[key]), int(dataset[key][5:])))
					else:
						#print key, len(record[key]), dataset[key], dataset[key][5:]
						dataset[key] = 'text_' + str(max(len(record[key]), int(dataset[key][5:])))
				else:
					if isinstance(record[key], (dict)):
						dataset[key] = type(record[key])
					elif isinstance(record[key], (list)):
						dataset[key] = 'list_' + str(len(record[key]))
					elif isinstance(record[key], (int, long, float, complex)):
						dataset[key] = record[key]
					else:
						dataset[key] = 'text_' + str(len(record[key]))
				
						
		for key in dataset:
			print(key, dataset[key])
			

if __name__ == '__main__':
	main()

