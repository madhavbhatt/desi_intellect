from pygments import console
from tago import analysis as Analysis
from tago import extra as Extra

def myanalysis(context, scope):
    api_key = '217d254d86b0e2d8359be6c46d2742f1'
    currency = Extra('currency', api_key)

    fro = 'USD'
    to = 'BRL'

    currency.convert(fro, to)
    try:
        print(console.log)
    except ValueError:
        print(console.log)

currency = Analysis(myanalysis, 'c89f0d50-38e2-11e6-966e-b94d760acc7d')