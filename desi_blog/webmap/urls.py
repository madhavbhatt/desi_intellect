from django.conf.urls import url
from . import views


urlpatterns = [
    url(r'^$', views.post_list, name='post_list'),
    url(r'^post/(?P<pk>\d+)/$', views.post_detail, name='post_detail'),
    url(r'^post/new/$', views.post_new, name='post_new'),
    url(r'^post/(?P<pk>\d+)/edit/$', views.post_edit, name='post_edit'),
    url(r'^post/(?P<pk>\d+)/delete/$', views.post_delete, name='post_delete'),
    url(r'^search/$', views.search, name='search'),
    url(r'^confirm/post/delete/$', views.post_delete, name='confrim_post_delete'),
    # url(r'^media/$', views.media_list, name='media_list'),
    # url(r'^media/(?P<pk>\d+)/delete/$', views.media_delete, name='media_delete'),
    # url(r'^confirm/media/delete/$', views.media_delete, name='confrim_media_delete'),
]
