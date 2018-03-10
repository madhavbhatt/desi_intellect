from .models import Listener
from django import forms


class ListenerForm(forms.Form):
    interface = forms.GenericIPAddressField(label='listener IP')
    port = forms.IntegerField(label='listener port')

    class Meta:
        model = Listener
        fields = ['interface', 'port', ]
