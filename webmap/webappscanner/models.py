from django.db import models
from django.utils import timezone
import uuid
from django.core.validators import URLValidator


def keygen():
    pk = uuid.uuid4()
    return pk


class Url(models.Model):
    keyid = models.CharField(max_length=36, default=keygen)
    url = models.URLField(max_length=200, validators=[URLValidator()], blank=False)
    status = models.CharField(max_length=9, default="Pending")
    created_date = models.DateTimeField(blank=True, null=True, default=timezone.now)
    completion_date = models.DateTimeField(blank=True, null=True, default=timezone.now)

    def publish(self):
        self.published_date = timezone.now()
        self.save()

    def __str__(self):
        return self.url
