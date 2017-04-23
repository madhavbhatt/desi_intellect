from pygments import console
from tago import analysis as Analysis
from tago import extra as Extra


def myanalysis(context, scope):
    api_key = 'AIzaSyAKkEKku8XrbzBJFDLDjtiacS4bRlF0E8s'  # API that you can get in the google website
    distance = Extra('distance', api_key)
    origins = "New York, NY, USA"
    destinations = "Washington, DC, USA"
    language = 'EN'
    mode = 'driving'

    distance.measure(origins, destinations, language, mode)
    try:
        print(console.log)
    except ValueError:
        print(console.log)

module = Analysis(myanalysis, 'c89f0d50-38e2-11e6-966e-b94d760acc7d')