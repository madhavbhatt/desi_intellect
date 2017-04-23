from tago import Tago
import os

TOKEN = os.environ.get('TAGO_TOKEN_DEVICE') or 'TOKEN'

def test_insert():
    result = Tago(TOKEN).device.find({'query': 'last_value'})
    print result
    if result['status']:
        assert True
    else:
        assert False
