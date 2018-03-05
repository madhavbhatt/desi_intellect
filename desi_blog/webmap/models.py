# -*- coding: utf-8 -*-
from __future__ import unicode_literals

import uuid
from django.db import models
from django.utils import timezone
from django.core.urlresolvers import reverse
from tinymce import HTMLField


def keygen():
    pk = uuid.uuid4()
    return pk


class Post(models.Model):
    author = models.ForeignKey('auth.user',on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    description = HTMLField('Content')
    created_date = models.DateTimeField(default=timezone.now)
    published_date = models.DateTimeField(blank=True, null=True)

    def publish(self):
        self.published_date = timezone.now()
        return self.published_date

    def get_absolute_url(self):
        return reverse('post_detail', kwargs={'pk': self.pk})

    def __str__(self):
        return self.title

    def __unicode__(self):
        return unicode(self.title) or u''
