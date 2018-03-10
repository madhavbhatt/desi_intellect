# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import models


class Listener(models.Model):
    author = models.ForeignKey('auth.user', on_delete=models.CASCADE)
    interface = models.GenericIPAddressField(max_length=16, default="0.0.0.0")
    port = models.IntegerField(default="443")





