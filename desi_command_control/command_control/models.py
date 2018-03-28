# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import models
from django.utils.translation import ugettext_lazy as _


class Listener(models.Model):
    author = models.ForeignKey('auth.user', on_delete=models.CASCADE)
    title = models.CharField(max_length=100)
    interface = models.GenericIPAddressField(max_length=16, default="0.0.0.0")
    port = models.IntegerField(default="443")


class pwnedHost(models.Model):
    # hostname = models.CharField(max_length=100)
    author = models.ForeignKey('auth.user', on_delete=models.CASCADE)
    ip = models.GenericIPAddressField(max_length=16)
    port = models.IntegerField(default="443")
    username = models.CharField(max_length=100)



