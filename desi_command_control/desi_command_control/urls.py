from django.conf.urls import url, include
from django.contrib import admin
from accounts.views import login_view, logout_view, password_change
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'', include('command_control.urls')),
    url(r'^login/$', login_view, name='login'),
    url(r'^password_change/$', password_change, name="password_change"),
    url(r'^logout/$', logout_view, name='logout'),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)