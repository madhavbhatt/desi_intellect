from bs4 import BeautifulSoup
from bs4.dammit import EncodingDetector
import requests


def desi_crawler(u_r_l):
    web_list = []
    url = u_r_l
    web_list.append(url)
    domain = url

    if "www." not in domain:
        div = domain.replace('//', ' ').replace('.', ' ').split()
        domain = div[1]
    else:
        div = domain.replace('//', ' ').replace('.', ' ').split()
        domain = div[2]

    for url in web_list:
        response = requests.get(url)
        http_encoding = response.encoding if 'charset' in response.headers.get('content-type', '').lower() else None
        html_encoding = EncodingDetector.find_declared_encoding(response.content, is_html=True)
        encoding = html_encoding or http_encoding
        soup = BeautifulSoup(response.content, from_encoding=encoding)

        for link in soup.find_all('a', href=True):
            if domain in link['href']:
                if link['href'] not in web_list:
                    web_list.append(link['href'])


def fingerprint_webapp(u_r_l):
    # values = ['X-AspNetMvc-Version', 'X-AspNet-Version', 'Server', 'X-Powered-By']
    url = u_r_l
    response = requests.get(url)
    for key, value in response.headers.iteritems():
        print (key, ":", value)
