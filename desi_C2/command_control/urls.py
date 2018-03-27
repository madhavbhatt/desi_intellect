from django.conf.urls import url
from . import views


urlpatterns = [
    url(r'^$', views.terminal, name='terminal'),
    url(r'^host/(?P<pk>\d+)/$', views.host, name='host'),
    url(r'^host/(?P<pk>\d+)/delete/$', views.host_delete, name='host_delete'),
    url(r'^result/(?P<pk>\d+)/$', views.result, name='result'),
    url(r'^listener/list/$', views.listener_list, name='listener_list'),
    url(r'^listener/(?P<pk>\d+)/replay$', views.listener_replay, name='listener_replay'),
    url(r'^listener/(?P<pk>\d+)/$', views.listener_detail, name='listener_detail'),
    url(r'^listener/new/$', views.listener_new, name='listener_new'),
    url(r'^listener/(?P<pk>\d+)/edit/$', views.listener_edit, name='listener_edit'),
    url(r'^payload/(?P<pk>\d+)/', views.payload_create, name='payload_create'),
    url(r'^payload/(?P<pk>\d+)/download', views.payload_download, name='payload_download'),
    url(r'^listener/(?P<pk>\d+)/delete/$', views.listener_delete, name='listener_delete'),
]

