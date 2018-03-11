from django.conf.urls import url
from . import views


urlpatterns = [
    url(r'^$', views.home, name='home'),
    url(r'^terminal/$', views.terminal, name='terminal'),
    url(r'^result/$', views.result, name='result'),
    url(r'^listener/list/$', views.listener_list, name='listener_list'),
    url(r'^listener/(?P<pk>\d+)/$', views.listener_detail, name='listener_detail'),
    url(r'^listener/new/$', views.listener_new, name='listener_new'),
    url(r'^listener/(?P<pk>\d+)/edit/$', views.listener_edit, name='listener_edit'),
    url(r'^listener/(?P<pk>\d+)/delete/$', views.listener_delete, name='listener_delete'),
    url(r'^confirm/listener/delete/$', views.listener_delete, name='confrim_listener_delete'),
]
