import requests
import json
import time


def send_request(url):
    session = requests.Session()
    r = session.get(url)
    return r

def create_table(ask_api = False):
    data_file = 'data_file.json'
    data = ""
    url = "https://peeringdb.com/api/net"
    if ask_api == True:
        r = send_request(url)
        if r.status_code != 200:
            print(f'Not 200 return code\n')
        with open(data_file, 'w+') as f:
            json.dump(r.json(), f)
        data = r.json()
    else:
        with open(data_file, 'r') as f:
            data = json.load(f)

    if data == "":
        print("No data. Exit.")
        return

    index = 0
    output_data_file = 'asn_location.csv'
    output_data = f'id;asn;location\n'
    for key in data["data"]:

        asn = key['asn']

        # Get asn details
        asn_id = key['id']
        url_detail = f'{url}/{asn_id}'
        r = send_request(url_detail)
        if r.status_code != 200:
            continue

        asn_data = r.json()
        locations = asn_data["data"][0]['netixlan_set']
        location_list = []
        # Insert uniq names to list
        for location in locations:
            location_name = location['name']
            if location_name not in location_list:
                location_list.append(location_name)

        ## Add location names tooutput_data
        for location in location_list:
            location_name = location
            line = f'"{index}";"{asn}";"{location_name}"\n'
            output_data = output_data + line
            index+=1

        print(index)

    with open(output_data_file, 'w+') as f:
        f.write(output_data)



if __name__ == '__main__':
    create_table()


