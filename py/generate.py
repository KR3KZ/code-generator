import csv
from tqdm import tqdm
import requests

csv_file = 'users.csv'
url = 'http://localhost:3000'
user_list = []

with open(csv_file, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        raw_account_list = row['accounts'].split('\n')
        account_list = [x for x in raw_account_list if x]
        str_account_list = '\r\n'.join(account_list)
        params = {
            'id': row['ticket'],
            'accounts': str_account_list
        }
        user_list.append(params)

for params in tqdm(user_list):
    r = requests.post(url, params)
    if not r.status_code == 200:
        print('ERROR for id {}: code {}: {}'.format(params['id'], r.status_code, r.text))