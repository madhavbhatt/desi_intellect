from django.conf import settings
from django.contrib.auth import logout
from django.contrib import messages
import datetime
from django.shortcuts import redirect
import settings


MAX_AGE = getattr(settings, 'CACHE_CONTROL_MAX_AGE', 0)


class MaxAgeMiddleware(object):
    def process_response(self, request, response):
        response['Cache-Control'] = 'max-age=%d' % MAX_AGE
        return response


class SessionIdleTimeout:
    def process_request(self, request):
        if request.user.is_authenticated():
            current_datetime = datetime.datetime.now()
            if ('last_login' in request.session):
                last = (current_datetime - request.session['last_login']).seconds
                if last > settings.SESSION_IDLE_TIMEOUT:
                    logout(request, 'user_login.html')
            else:
                request.session['last_login'] = current_datetime
        return None