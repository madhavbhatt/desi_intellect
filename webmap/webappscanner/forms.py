from django import forms
from .models import Url


class ScanUrl(forms.ModelForm):
    class Meta:
        model = Url
        fields = ('url',)
