from .models import Listener
from django import forms


class ListenerForm(forms.ModelForm):
    title = forms.CharField(label='name', initial="reverse tcp listener")
    interface = forms.GenericIPAddressField(label='listener IP', initial="0.0.0.0" )
    port = forms.IntegerField(label='listener port')

    class Meta:
        model = Listener
        fields = ['title', 'interface', 'port', ]


