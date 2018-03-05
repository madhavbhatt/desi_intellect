from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.url_list, name='url_list'),
    url(r'^url/(?P<pk>\d+)/$', views.url_detail, name='url_detail'),
    url(r'^url/new/$', views.url_new, name='url_new'),
    url(r'^url/(?P<pk>\d+)/edit/$', views.url_edit, name='url_edit'),
    url(r'^url/(?P<pk>\d+)/rescan/$', views.url_rescan, name='url_rescan'),
    url(r'^url/(?P<pk>\d+)/result/$', views.url_result, name='url_result'),
    url(r'^url/(?P<pk>\d+)/download/$', views.url_download, name='url_download'),
    url(r'^url/(?P<pk>\d+)/exploit/$', views.url_exploit, name='url_exploit'),
]
