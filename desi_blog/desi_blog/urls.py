from django.conf.urls import url, include
from django.contrib import admin
from accounts.views import login_view, logout_view, password_change
from django.conf import settings
from django.conf.urls.static import static
from filebrowser.sites import site

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^admin/filebrowser/', include(site.urls)),
    url(r'', include('webmap.urls')),
    url(r'^login/$', login_view, name='login'),
    url(r'^password_change/$', password_change, name="password_change"),
    url(r'^logout/$', logout_view, name='logout'),
    url(r'^tinymce/', include('tinymce.urls')),
    # url(r'^register/$', register_view, name='register'),
    # url(r'^forgot_password/$', forgot_password, name="forgot_password"),
    # url(r'^password_reset/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>.*)/$', password_reset, name="password_reset"),
    # url(r'^activate/(?P<uidb64>[0-9A-Za-z_\-]+)/(?P<token>.*)/$', activate, name='activate'),
]

urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
